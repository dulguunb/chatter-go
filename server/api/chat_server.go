package api

import (
	"context"
	"log"
	"sync"
	"time"

	"github.com/ThreeDotsLabs/watermill"
	"github.com/ThreeDotsLabs/watermill/message"
	"github.com/ThreeDotsLabs/watermill/pubsub/gochannel"
	"github.com/google/uuid" // Import the uuid library
	"google.golang.org/grpc"
	"google.golang.org/protobuf/proto"

	"github.com/dulguunb/chatter-go/client/logging"
	pb "github.com/dulguunb/go-chatter/gen"
)

// TODO: Create another layer of abstraction for message store: Memory only or with database
type ChatServer struct {
	pb.UnimplementedChatServiceServer
	mu            sync.Mutex
	conversations map[string]*pb.Conversation

	messages  map[string][]*pb.Message
	publisher *gochannel.GoChannel // TODO: message.Publisher interface for flexibility

	newUserChannel chan *pb.User
	Users          []*pb.User

	PublicKeys map[string]string
}

func NewChatServer() *ChatServer {
	logger := watermill.NewStdLogger(false, false) // Simple logger

	pubSub := gochannel.NewGoChannel(gochannel.Config{}, logger)

	return &ChatServer{
		conversations: make(map[string]*pb.Conversation),
		messages:      make(map[string][]*pb.Message),
		Users:         make([]*pb.User, 0),
		publisher:     pubSub,
		PublicKeys:    make(map[string]string),
	}
}

func (s *ChatServer) SendMessage(ctx context.Context, req *pb.SendMessageRequest) (*pb.SendMessageResponse, error) {
	s.mu.Lock()
	defer s.mu.Unlock()

	msg := &pb.Message{
		Id:             uuid.NewString(),
		ConversationId: req.ConversationId,
		SenderId:       req.SenderId,
		Content:        req.Content,
		Timestamp:      time.Now().UnixMilli(),
		Username:       req.Username,
	}

	s.messages[req.ConversationId] = append(s.messages[req.ConversationId], msg)
	var updatedConv *pb.Conversation

	if conv, ok := s.conversations[req.ConversationId]; ok {
		conv.LastMessageId = msg.Id
		updatedConv = conv
	}

	if updatedConv != nil && s.publisher != nil {
		payload, err := proto.Marshal(updatedConv)
		if err != nil {
			logging.Logger.Sugar().Errorf("Error marshalling conversation for Watermill: %v", err)
		} else {
			watermillMsg := message.NewMessage(uuid.NewString(), payload)
			topic := "updated_convo_" + updatedConv.Id
			if err := s.publisher.Publish(topic, watermillMsg); err != nil {
				logging.Logger.Sugar().Info("Error publishing conversation update to Watermill topic %s: %v", topic, err)
			} else {
				logging.Logger.Sugar().Info("Published update for conversation %s to topic %s", updatedConv.Id, topic)
			}
		}
	}
	return &pb.SendMessageResponse{Message: msg}, nil
}

func (s *ChatServer) GetConversations(req *pb.GetConversationsRequest, stream grpc.ServerStreamingServer[pb.GetConversationsResponse]) error {
	for {
		var userConvs []*pb.Conversation
		for _, conv := range s.conversations {
			for _, pid := range conv.ParticipantIds {
				if pid == req.UserId {
					userConvs = append(userConvs, conv)
					break
				}
			}
		}
		resp := pb.GetConversationsResponse{
			Conversations: userConvs,
		}
		if err := stream.Send(&resp); err != nil {
			return err
		}
		time.Sleep(1 * time.Second)
	}
}

func (s *ChatServer) GetMessages(req *pb.GetMessagesRequest, stream grpc.ServerStreamingServer[pb.GetMessagesResponse]) error {
	convoID := req.ConversationId
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	topic := "updated_convo_" + convoID
	messages, err := s.publisher.Subscribe(ctx, topic)
	if err != nil {
		log.Fatal(err)
	}

	msgChannel := make(chan []*pb.Message)

	go func() {
		logging.Logger.Sugar().Infof("Subscriber started, listening on topic %q", topic)
		for msg := range messages {
			logging.Logger.Sugar().Infof("Subscriber received message: %s, payload: %s", msg.UUID, string(msg.Payload))
			receivedConv := &pb.Conversation{}
			err := proto.Unmarshal(msg.Payload, receivedConv)
			if err != nil {
				logging.Logger.Sugar().Error(err)
			} else {
				message := s.messages[receivedConv.Id]
				msgChannel <- message
				logging.Logger.Sugar().Info(message)
			}
			msg.Ack()
		}
		logging.Logger.Info("Subscriber goroutine finished")
	}()

	for {
		select {
		case messages := <-msgChannel:
			start := req.Offset
			end := int64(len(messages))
			// TODO: After integrating DB and encryption, add paging
			// end := start + req.Limit
			// if int(end) > len(messages) {
			// 	end = int64(len(messages))
			// }
			message := pb.GetMessagesResponse{Messages: messages[start:end]}
			err := stream.Send(&message)
			if err != nil {
				return err
			}
		case <-ctx.Done():
			logging.Logger.Sugar().Infof("gRPC stream context cancelled for convo %s: %v", convoID, ctx.Err())
			return ctx.Err()
		}

		time.Sleep(1000 * time.Millisecond)
	}
}

func (s *ChatServer) CreateConversation(ctx context.Context, req *pb.CreateConversationRequest) (*pb.CreateConversationResponse, error) {
	s.mu.Lock()
	defer s.mu.Unlock()

	conv := &pb.Conversation{
		Id:             uuid.NewString(),
		ParticipantIds: req.ParticipantIds,
		Name:           req.Name,
		LastMessageId:  "",
	}

	s.conversations[conv.Id] = conv

	return &pb.CreateConversationResponse{Conversation: conv}, nil
}

func (s *ChatServer) StreamUsersUpdate(req *pb.GetAvailableUsersRequest, stream grpc.ServerStreamingServer[pb.GetAvailableUsersResponse]) error {
	for {
		resp := pb.GetAvailableUsersResponse{
			Users: s.Users,
		}
		if err := stream.Send(&resp); err != nil {
			return err
		}
		time.Sleep(1 * time.Second)
	}
}

func (s *ChatServer) AddUser(ctx context.Context, in *pb.AddUserRequest) (*pb.AddUserResponse, error) {
	s.mu.Lock()
	s.Users = append(s.Users, in.User)
	s.mu.Unlock()
	logging.Logger.Sugar().Infof("Added a new user: %s", in.User.Username)
	return &pb.AddUserResponse{User: in.User}, nil
}

func (s *ChatServer) SendPublicKey(ctx context.Context, in *pb.PublicKeySendRequest) (*pb.PublicKeySendResponse, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.PublicKeys[in.ParticipantId] = in.PublicKey
	logging.Logger.Sugar().Info("public key: ")
	logging.Logger.Sugar().Info(s.PublicKeys)
	return &pb.PublicKeySendResponse{ParticipantId: in.ParticipantId, Success: 1}, nil
}

func (s *ChatServer) GetPublicKeyOfPartner(ctx context.Context, in *pb.PublicKeyRequest) (*pb.PublicKeyResponse, error) {
	if s.PublicKeys[in.ParticipantId] != "" {
		return &pb.PublicKeyResponse{PublicKey: s.PublicKeys[in.ParticipantId], ParticipantId: in.ParticipantId}, nil
	} else {
		return &pb.PublicKeyResponse{PublicKey: "", ParticipantId: in.ParticipantId}, nil
	}
}
