package api

import (
	"context"
	"log"
	"sync"
	"time"

	"github.com/google/uuid" // Import the uuid library

	"github.com/dulguunb/chatter-go/client/logging"
	"github.com/dulguunb/chatter-go/server/errors"
	pb "github.com/dulguunb/go-chatter/gen"
)

type ChatServer struct {
	pb.UnimplementedChatServiceServer
	mu            sync.Mutex
	conversations map[string]*pb.Conversation
	messages      map[string][]*pb.Message
	Users         map[string]*pb.User
}

func NewChatServer() *ChatServer {
	return &ChatServer{
		conversations: make(map[string]*pb.Conversation),
		messages:      make(map[string][]*pb.Message),
		Users:         make(map[string]*pb.User),
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

func (s *ChatServer) GetConversations(ctx context.Context, req *pb.GetConversationsRequest) (*pb.GetConversationsResponse, error) {
	conversationIsFound := false
	s.mu.Lock()
	defer s.mu.Unlock()

	var userConvs []*pb.Conversation
	for _, conv := range s.conversations {
		for _, pid := range conv.ParticipantIds {
			if pid == req.UserId {
				userConvs = append(userConvs, conv)
				conversationIsFound = true
				break
			}
		}
	}
	if !conversationIsFound {
		return nil, errors.ConversationIsNotFound
	}

	return &pb.GetConversationsResponse{Conversations: userConvs}, nil
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

func (s *ChatServer) GetAvailableUsers(ctx context.Context, in *pb.GetAvailableUsersRequest) (*pb.GetAvailableUsersResponse, error) {
	users := make([]*pb.User, 0)
	for _, user := range s.Users {
		users = append(users, user)
	}
	log.Println("AvailableUsers")
	log.Println(users)
	return &pb.GetAvailableUsersResponse{Users: users}, nil
}

func (s *ChatServer) AddUser(ctx context.Context, in *pb.AddUserRequest) (*pb.AddUserResponse, error) {
	s.Users[in.User.Id] = in.User
	log.Println("Added users")
	log.Println(s.Users)
	return &pb.AddUserResponse{User: in.User}, nil
}
