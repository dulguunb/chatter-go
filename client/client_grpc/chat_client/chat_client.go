package chat_client

import (
	"context"
	"sync"
	"time"

	chatterPb "github.com/dulguunb/go-chatter/gen"
	"google.golang.org/grpc"
)

const TIMEOUT = 10

type ChatService struct {
	Inbox    chan *chatterPb.Envelope
	Outbox   chan *chatterPb.Envelope
	sender   string
	receiver string
	mu       sync.Mutex
	conn     *grpc.ClientConn
	timer    int64 // send message counter
}

func New(conn *grpc.ClientConn, sender string, receiver string) *ChatService {
	return &ChatService{
		sender:   sender,
		receiver: receiver,
		conn:     conn,
		Inbox:    make(chan *chatterPb.Envelope),
		Outbox:   make(chan *chatterPb.Envelope),
		timer:    0,
	}
}
func (c *ChatService) receiveEnvelopeInternal() (*chatterPb.Envelope, error) {
	chatClient := chatterPb.NewChatClient(c.conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	defer cancel()
	r, err := chatClient.ReceiveEnvelope(ctx, &chatterPb.Address{Sender: c.sender, Receiver: c.receiver})
	if err != nil {
		return nil, err
	}
	return r, nil
}

func (c *ChatService) ReceiveMessage() {
	//  Update every one second
	ticker := time.NewTicker(1 * time.Second)
	go func() {
		for {
			select {
			case <-ticker.C:
				r, err := c.receiveEnvelopeInternal()
				if err != nil {
					return
				}
				c.Inbox <- r
			}
		}
	}()
}

func (c *ChatService) SendMessage(message string) (*chatterPb.Envelope, error) {
	chatClient := chatterPb.NewChatClient(c.conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	defer cancel()
	address := chatterPb.Address{Sender: c.sender, Receiver: c.receiver}
	outbox := &chatterPb.Message{
		Message: message,
		Time:    c.timer,
	}
	r, err := chatClient.SendEnvelope(ctx, &chatterPb.Envelope{Addr: &address, Outbox: outbox})
	if err != nil {
		return nil, err
	}
	c.timer += 1
	return r, nil
}
