package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"sync"
	"time"

	"github.com/dulguunb/chatter-go/server/users"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	"google.golang.org/grpc"
)

var (
	port = 50051
)

type server struct {
	chatterPb.UnimplementedListUsersRequestServiceServer
	mu sync.Mutex
}

func New() *server {
	return &server{}
}
func (s *server) SendRequest(ctx context.Context, req *chatterPb.ListUsersRequest) (*chatterPb.ListUsersResponse, error) {
	username := req.Username
	users := users.GetInstance()
	currentUser := users[username]
	serverTime := int64(0)
	if currentUser != nil {
		serverTime = currentUser.ServerTime
	}
	users[username] = &chatterPb.UserInfo{
		IsAvailable: true,
		ClientTime:  req.ClientTime,
		ServerTime:  serverTime,
		Terminate:   false,
	}
	currentUser = users[username]
	logMsg := fmt.Sprintf("user name: %s, serverTime: %d, clientTime %d", username, currentUser.ServerTime, currentUser.ClientTime)
	println(logMsg)
	return &chatterPb.ListUsersResponse{Users: users}, nil
}

func (s *server) DeleteUnavailableUsers(ctx context.Context) {
	ticker := time.NewTicker(5 * time.Second)
	for {
		select {
		case <-ticker.C:
			users := users.GetInstance()
			toBeDeleted := make([]string, 0)
			for username, info := range users {
				if !info.IsAvailable {
					toBeDeleted = append(toBeDeleted, username)
				}
			}
			for _, user := range toBeDeleted {
				delete(users, user)
			}
		}
	}
}

func (s *server) CheckAvailableBackground(ctx context.Context) {
	ticker := time.NewTicker(5 * time.Second)
	for {
		select {
		case <-ticker.C:
			users := users.GetInstance()
			for _, info := range users {
				if info.IsAvailable {
					s.mu.Lock()
					info.ServerTime += 1
					s.mu.Unlock()
				}
				if (info.ClientTime - info.ServerTime) > 10 {
					info.IsAvailable = false
				}
			}

		}
	}
}

func main() {
	ctx := context.Background()
	chatService := server{}
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	chatterPb.RegisterListUsersRequestServiceServer(s, &chatService)
	go chatService.CheckAvailableBackground(ctx)
	go chatService.DeleteUnavailableUsers(ctx)
	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
