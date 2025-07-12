package api

import (
	"context"
	"log"
	"time"

	"github.com/ThreeDotsLabs/watermill"
	"github.com/ThreeDotsLabs/watermill/message"
	"github.com/ThreeDotsLabs/watermill/pubsub/gochannel"
	"github.com/google/uuid" // Import the uuid library
	"google.golang.org/grpc"
	"google.golang.org/protobuf/proto"

	"github.com/dulguunb/chatter-go/client/logging"
	"github.com/dulguunb/chatter-go/server/store"
	pb "github.com/dulguunb/go-chatter/gen"
)

// TODO: Create another layer of abstraction for message store: Memory only or with database
type ChatServer struct {
	pb.UnimplementedChatServiceServer
	publisher *gochannel.GoChannel // TODO: message.Publisher interface for flexibility
	dataStore store.DataStoreHandler
}

func NewChatServer(dataStore store.DataStoreHandler) *ChatServer {
	logger := watermill.NewStdLogger(false, false) // Simple logger
	pubSub := gochannel.NewGoChannel(gochannel.Config{}, logger)
	return &ChatServer{
		publisher: pubSub,
		dataStore: dataStore,
	}
}

func (s *ChatServer) SendMessage(ctx context.Context, req *pb.SendMessageRequest) (*pb.SendMessageResponse, error) {
	msg := &pb.Message{
		Id:             uuid.NewString(),
		ConversationId: req.ConversationId,
		SenderId:       req.SenderId,
		Content:        req.Content,
		Timestamp:      time.Now().UnixMilli(),
		Username:       req.Username,
	}
	s.dataStore.SendMessage(msg, req.ConversationId)

	var updatedConv *pb.Conversation
	conv, err := s.dataStore.GetConversation(req.ConversationId)
	if err != nil {
		logging.Logger.Sugar().Error(err)
	} else {
		conv.LastMessageId = msg.Id
		updatedConv = conv
	}
	logging.Logger.Sugar().Infof("SendMessage(): ConversationId: %s", req.ConversationId)

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

func (s *ChatServer) GetConversations(ctx context.Context, req *pb.GetConversationsRequest) (*pb.GetConversationsResponse, error) {

	conversations, _ := s.dataStore.GetConversationsFromUserId(req.UserId)
	resp := pb.GetConversationsResponse{
		Conversations: conversations,
	}
	return &resp, nil
}
func (s *ChatServer) GetMessages(ctx context.Context, req *pb.GetMessagesRequest) (*pb.GetMessagesResponse, error) {
	message, err := s.dataStore.GetMessages(req.ConversationId)
	if err != nil {

	}
	messageResponse := pb.GetMessagesResponse{Messages: message}
	return &messageResponse, err
}

func (s *ChatServer) GetMessagesStream(req *pb.GetMessagesRequest, stream grpc.ServerStreamingServer[pb.GetMessagesResponse]) error {
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
				message, err := s.dataStore.GetMessages(receivedConv.Id)
				if err != nil {
					logging.Logger.Sugar().Error(err)
				}
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
	conv := &pb.Conversation{
		Id:             uuid.NewString(),
		ParticipantIds: req.ParticipantIds,
		Name:           req.Name,
		LastMessageId:  "",
	}
	err := s.dataStore.SetConversation(conv)
	if err != nil {
		logging.Logger.Sugar().Error(err)
		return nil, err
	}
	// Publish a topic per conversation participants
	for _, participantId := range req.ParticipantIds {
		payload, err := proto.Marshal(conv)
		if err != nil {
			logging.Logger.Sugar().Errorf("Error marshalling conversation for Watermill: %v", err)
		}
		watermillMsg := message.NewMessage(uuid.NewString(), payload)
		topic := "created_convo_" + participantId
		if err := s.publisher.Publish(topic, watermillMsg); err != nil {
			logging.Logger.Sugar().Errorf("Error publishing conversation update to Watermill topic %s: %v", topic, err)
		} else {
			logging.Logger.Sugar().Info("Published update for conversation topic %s", topic)
		}
	}
	createdConv, err := s.dataStore.GetConversation(conv.Id)

	return &pb.CreateConversationResponse{Conversation: createdConv}, err
}

func (s *ChatServer) StreamUsersUpdate(req *pb.GetAvailableUsersRequest, stream grpc.ServerStreamingServer[pb.GetAvailableUsersResponse]) error {
	for {
		users := s.dataStore.GetAvailableUsers()
		resp := pb.GetAvailableUsersResponse{
			Users: users,
		}
		if err := stream.Send(&resp); err != nil {
			return err
		}
		time.Sleep(1 * time.Second)
	}
}

func (s *ChatServer) AddUser(ctx context.Context, in *pb.AddUserRequest) (*pb.AddUserResponse, error) {
	s.dataStore.AddUser(in.User)
	logging.Logger.Sugar().Infof("Added a new user: %s", in.User.Username)
	return &pb.AddUserResponse{User: in.User}, nil
}

func (s *ChatServer) SendPublicKey(ctx context.Context, in *pb.PublicKeySendRequest) (*pb.PublicKeySendResponse, error) {
	err := s.dataStore.SetPublicKey(in.ParticipantId, in.PublicKey)
	if err != nil {
		logging.Logger.Sugar().Error(err)
	}
	logging.Logger.Sugar().Info("public key: ")
	logging.Logger.Sugar().Info(in.PublicKey)
	return &pb.PublicKeySendResponse{ParticipantId: in.ParticipantId, Success: 1}, err
}

func (s *ChatServer) GetPublicKeyOfPartner(ctx context.Context, in *pb.PublicKeyRequest) (*pb.PublicKeyResponse, error) {
	publicKey, err := s.dataStore.GetPublicKey(in.ParticipantId)
	return &pb.PublicKeyResponse{PublicKey: publicKey, ParticipantId: in.ParticipantId}, err
}
