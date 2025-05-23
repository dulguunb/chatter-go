package list_client

import (
	"context"
	"log"
	"sync"
	"time"

	"github.com/dulguunb/chatter-go/client/logging"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	"github.com/google/uuid"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"google.golang.org/grpc/credentials/insecure"
)

const TIMEOUT = 10

type Chatter interface {
}

type ListUsersService struct {
	clientTime int64
	mu         sync.Mutex
	Me         *chatterPb.User
	creds      credentials.TransportCredentials
	Conn       *grpc.ClientConn
	Users      map[string]*chatterPb.User
	Error      chan error
}

var _ Chatter = (*ListUsersService)(nil)

func New(username string, conn *grpc.ClientConn) *ListUsersService {

	listUsersService := &ListUsersService{
		Me: &chatterPb.User{
			Username:  username,
			Id:        uuid.New().String(),
			Available: true,
		},
		Conn:  conn,
		creds: insecure.NewCredentials(),
		Error: make(chan error),
		Users: map[string]*chatterPb.User{},
	}
	_, err := listUsersService.addMe()
	if err != nil {
		log.Fatal(err)
	}
	return listUsersService
}

func (c *ListUsersService) addMe() (*chatterPb.AddUserResponse, error) {
	client := chatterPb.NewChatServiceClient(c.Conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	defer cancel()
	r, err := client.AddUser(ctx, &chatterPb.AddUserRequest{User: c.Me})
	if err != nil {
		return nil, err
	}
	return r, nil
}

func (c *ListUsersService) GetAvailableUsers() (chan map[string]*chatterPb.User, error) {
	client := chatterPb.NewChatServiceClient(c.Conn)
	ctx := context.Background()
	r, err := client.StreamUsersUpdate(ctx, &chatterPb.GetAvailableUsersRequest{User: c.Me})
	if err != nil {
		return nil, err
	}
	usersChan := make(chan map[string]*chatterPb.User)
	go func() {
		for {
			stream, err := r.Recv()
			if err != nil {
				logging.Logger.Sugar().Error(err)
			}
			for _, user := range stream.Users {
				if user.Id != c.Me.Id {
					c.mu.Lock()
					c.Users[user.Id] = user
					c.mu.Unlock()
				}
			}
			usersChan <- c.Users
		}
	}()

	return usersChan, nil
}
