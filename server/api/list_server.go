package api

import (
	"context"
	"fmt"
	"sync"
	"time"

	"github.com/dulguunb/chatter-go/server/singletons"
	chatterPb "github.com/dulguunb/go-chatter/gen"
)

const OFFLINE_TIMER = 100

type ListUserServer struct {
	chatterPb.UnimplementedListUsersRequestServiceServer
	mu sync.Mutex
}

func New() *ListUserServer {
	return &ListUserServer{}
}

func (s *ListUserServer) SendRequest(ctx context.Context, req *chatterPb.ListUsersRequest) (*chatterPb.ListUsersResponse, error) {
	username := req.Username
	users := singletons.GetUsersInstance()
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

func (s *ListUserServer) DeleteUnavailableUsers(ctx context.Context) {
	ticker := time.NewTicker(5 * time.Second)
	for {
		select {
		case <-ticker.C:
			users := singletons.GetUsersInstance()
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

func (s *ListUserServer) CheckAvailableBackground(ctx context.Context) {
	ticker := time.NewTicker(5 * time.Second)
	for {
		select {
		case <-ticker.C:
			users := singletons.GetUsersInstance()
			// messages := singletons.GetMessageInstance()
			for requesterUsername, info := range users {
				if info.Partner != "" {
					s.mu.Lock()
					// messages.Message[requesterUsername] = &chatterPb.MessageInfo{
					// 	Receiver: info.Partner,
					// 	Message:  "",
					// }
					partnerUsername := info.Partner
					users[partnerUsername].Partner = requesterUsername
					s.mu.Unlock()
				}
				if info.IsAvailable {
					s.mu.Lock()
					info.ServerTime += 1
					s.mu.Unlock()
				}
				if (info.ClientTime - info.ServerTime) > OFFLINE_TIMER {
					info.IsAvailable = false
				}
			}

		}
	}
}
