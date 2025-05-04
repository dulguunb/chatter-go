package chat_client

import (
	"context"
	"fmt"
	"slices"
	"strings"
	"sync"
	"time"

	"github.com/dulguunb/chatter-go/client/logging"
	"github.com/dulguunb/chatter-go/client/usernames"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	"google.golang.org/grpc"
)

const TIMEOUT = 10

type ChatService struct {
	Sender                *chatterPb.User
	mu                    sync.Mutex
	conn                  *grpc.ClientConn
	timer                 int64 // send message counter
	Conversation          *chatterPb.Conversation
	ConversationInitiated chan bool
	MessageChan           chan *chatterPb.Message
	MessageIds            []string
	lastMessage           int64
}

func New(conn *grpc.ClientConn, sender *chatterPb.User) *ChatService {
	return &ChatService{
		Sender:                sender,
		conn:                  conn,
		timer:                 0,
		lastMessage:           0,
		MessageChan:           make(chan *chatterPb.Message),
		ConversationInitiated: make(chan bool),
		MessageIds:            make([]string, 0),
	}
}

func (c *ChatService) CreateConversation(receiver *chatterPb.User) (*chatterPb.CreateConversationResponse, error) {
	logging.Logger.Sugar().Infof("receiver name: %s, receiver id: %s", receiver.Username, receiver.Id)

	client := chatterPb.NewChatServiceClient(c.conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	defer cancel()
	conversation := chatterPb.CreateConversationRequest{
		ParticipantIds: []string{c.Sender.Id, receiver.Id},
		Name:           usernames.GenerateWords(1),
	}
	r, err := client.CreateConversation(ctx, &conversation)
	c.mu.Lock()
	c.Conversation = r.Conversation
	c.mu.Unlock()
	if err != nil {
		logging.Logger.Fatal(err.Error())
		return nil, err
	}
	c.lastMessage += 1
	return r, nil
}

func (c *ChatService) GetConversationsBackground() {
	ticker := time.NewTicker(1 * time.Second)
	go func() {
		for {
			select {
			case <-ticker.C:
				resp, err := c.GetConversations(c.Sender.Id)
				if err != nil {
					logging.Logger.Sugar().Error(err)
				}
				if err == nil {
					c.mu.Lock()
					c.Conversation = resp
					c.ConversationInitiated <- true
					c.mu.Unlock()
				}
			}
		}
	}()
}

func (c *ChatService) GetConversations(userId string) (*chatterPb.Conversation, error) {
	client := chatterPb.NewChatServiceClient(c.conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	defer cancel()
	conversationReq := chatterPb.GetConversationsRequest{
		UserId: c.Sender.Id,
	}
	r, err := client.GetConversations(ctx, &conversationReq)
	if err != nil {
		return nil, err
	}
	c.lastMessage += 1
	return r.Conversations[0], nil
}

func (c *ChatService) SendMessage(senderId string, message string) error {
	logging.Logger.Sugar().Infof("senderId: %s message: %s", senderId, message)
	client := chatterPb.NewChatServiceClient(c.conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	defer cancel()
	messageRequest := chatterPb.SendMessageRequest{
		ConversationId: c.Conversation.Id,
		Content:        message,
		SenderId:       senderId,
		Username:       c.Sender.Username,
	}
	_, err := client.SendMessage(ctx, &messageRequest)
	if err != nil {
		return err
	}
	return nil
}

func (c *ChatService) ReceiveMessage(senderId string) (string, error) {

	client := chatterPb.NewChatServiceClient(c.conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	defer cancel()
	getMessageRequest := chatterPb.GetMessagesRequest{
		ConversationId: c.Conversation.Id,
		Offset:         0,
	}

	messageResponse, _ := client.GetMessages(ctx, &getMessageRequest)
	newMessages := make([]string, 0)

	for _, message := range messageResponse.Messages {
		oldMessage := slices.Contains(c.MessageIds, message.Id)
		if !oldMessage {
			c.MessageIds = append(c.MessageIds, message.Id)
			newMessageDisplay := fmt.Sprintf("%s: %s", message.Username, message.Content)
			newMessages = append(newMessages, newMessageDisplay)
		}
	}

	return strings.Join(newMessages, ""), nil
}
