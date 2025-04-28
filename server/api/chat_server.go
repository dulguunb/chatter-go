package api

import (
	"context"
	"sync"

	"github.com/dulguunb/chatter-go/server/singletons"
	chatterPb "github.com/dulguunb/go-chatter/gen"
)

type ChatServer struct {
	chatterPb.UnimplementedChatServer
	mu sync.Mutex
}

func (s *ChatServer) SendEnvelope(ctx context.Context, req *chatterPb.Envelope) (*chatterPb.Envelope, error) {
	envelope := singletons.GetEnvelopeInstance()
	sender := envelope[req.Addr.Sender]
	receiver := envelope[req.Addr.Receiver]
	receiver.Msg = req.Msg

	return sender, nil
}
func (s *ChatServer) ReceiveEnvelope(ctx context.Context, req *chatterPb.Address) (*chatterPb.Envelope, error) {
	envelope := singletons.GetEnvelopeInstance()
	sender := envelope[req.Sender]
	receiver := envelope[req.Receiver]
	sender.Msg = receiver.Msg
	return sender, nil
}

// func (s *ChatServer) messageExchange(sender *chatterPb.Envelope, receiver *chatterPb.Envelope) {

// }

// func (s *ChatServer) UpdateBackground(ctx context.Context) {
// 	ticker := time.NewTicker(1 * time.Second)
// 	for {
// 		select {
// 		case <-ticker.C:
// 			s.mu.Lock()
// 			envelope := singletons.GetEnvelopeInstance()

// 			s.mu.Unlock()
// 		}
// 	}
// }
