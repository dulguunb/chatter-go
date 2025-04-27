package client_grpc

import (
	"context"
	"fmt"
	"sync"
	"time"

	chatterPb "github.com/dulguunb/go-chatter/gen"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"google.golang.org/grpc/credentials/insecure"
)

type Chatter interface {
	ValidateTheConnection() (bool, error)
	ListUsersRequest()
}

type ClientService struct {
	clientTime   int64
	mu           sync.Mutex
	username     string
	serverIp     string
	port         int
	creds        credentials.TransportCredentials
	conn         *grpc.ClientConn
	ListUserChan chan *chatterPb.ListUsersResponse
	Users        map[string]*chatterPb.UserInfo
}

var _ Chatter = (*ClientService)(nil)

func New(username string, serverIp string) *ClientService {
	return &ClientService{
		username:     username,
		serverIp:     serverIp,
		port:         50051,
		creds:        insecure.NewCredentials(),
		conn:         nil,
		ListUserChan: make(chan *chatterPb.ListUsersResponse),
	}
}
func (c *ClientService) ValidateTheConnection() (bool, error) {
	address := fmt.Sprintf("%s:%d", c.serverIp, c.port)
	conn, err := grpc.NewClient(address, grpc.WithTransportCredentials(c.creds))
	c.conn = conn
	if err != nil {
		return false, nil
	}
	return true, nil
}

func (c *ClientService) listUsersRequest() (*chatterPb.ListUsersResponse, error) {
	client := chatterPb.NewListUsersRequestServiceClient(c.conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()
	c.mu.Lock()
	c.clientTime += 1
	c.mu.Unlock()
	r, err := client.SendRequest(ctx, &chatterPb.ListUsersRequest{Username: c.username, ClientTime: c.clientTime})
	if err != nil {
		return nil, err
	}
	return r, nil
}

func (c *ClientService) ListUsersRequest() {
	ticker := time.NewTicker(5 * time.Second)
	response, err := c.listUsersRequest()
	if err != nil {
		return
	}
	c.ListUserChan <- response
	for {
		select {
		case <-ticker.C:
			resp, err := c.listUsersRequest()
			if err != nil {
				return
			}
			c.ListUserChan <- resp
		}
	}
}
