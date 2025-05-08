package api

import (
	"context"
	"sync"
	"time"

	"github.com/google/uuid" // Import the uuid library
	"google.golang.org/grpc"

	"github.com/dulguunb/chatter-go/client/logging"
	pb "github.com/dulguunb/go-chatter/gen"
)

type ChatServer struct {
	pb.UnimplementedChatServiceServer
	mu             sync.Mutex
	conversations  map[string]*pb.Conversation
	messages       map[string][]*pb.Message
	newUserChannel chan *pb.User
	Users          []*pb.User
}

func NewChatServer() *ChatServer {
	return &ChatServer{
		conversations: make(map[string]*pb.Conversation),
		messages:      make(map[string][]*pb.Message),
		Users:         make([]*pb.User, 0),
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

	logging.Logger.Sugar().Info("Send message: ")
	logging.Logger.Sugar().Info(msg)

	if conv, ok := s.conversations[req.ConversationId]; ok {
		conv.LastMessageId = msg.Id
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
		logging.Logger.Sugar().Info("GetConversation: ")
		logging.Logger.Sugar().Info(userConvs)
		if err := stream.Send(&resp); err != nil {
			logging.Logger.Sugar().Errorw(err.Error(), "stream_error")
			return err
		}
		time.Sleep(1 * time.Second)
	}
}

func (s *ChatServer) GetMessages(ctx context.Context, req *pb.GetMessagesRequest) (*pb.GetMessagesResponse, error) {
	s.mu.Lock()
	defer s.mu.Unlock()

	msgs := s.messages[req.ConversationId]
	start := req.Offset
	end := int64(len(msgs)) // start + req.Limit
	// if int(end) > len(msgs) {
	// 	end = int64(len(msgs))
	// }
	logging.Logger.Sugar().Info(msgs)
	return &pb.GetMessagesResponse{Messages: msgs[start:end]}, nil
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
			logging.Logger.Sugar().Errorw(err.Error(), "stream_error")
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
