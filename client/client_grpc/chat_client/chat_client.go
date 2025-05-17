package chat_client

import (
	"context"
	"fmt"
	"slices"
	"sync"
	"time"

	"github.com/dulguunb/chatter-go/client/encryption"
	"github.com/dulguunb/chatter-go/client/logging"
	"github.com/dulguunb/chatter-go/client/usernames"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	"google.golang.org/grpc"
)

const TIMEOUT = 10

type ChatService struct {
	Sender       *chatterPb.User
	mu           sync.Mutex
	conn         *grpc.ClientConn
	timer        int64 // send message counter
	Conversation *chatterPb.Conversation
	MessageChan  chan *chatterPb.Message
	MessageIds   []string
	lastMessage  int64
	keys         encryption.KeyMaterial
}

func New(conn *grpc.ClientConn, sender *chatterPb.User) *ChatService {
	keys := *encryption.New()
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	client := chatterPb.NewChatServiceClient(conn)
	defer cancel()
	_, err := client.SendPublicKey(ctx, &chatterPb.PublicKeySendRequest{ParticipantId: sender.Id, PublicKey: string(keys.GetMyPublicKey())})
	if err != nil {
		logging.Logger.Sugar().Error("could not send public keys for e2e encryption")
		logging.Logger.Sugar().Fatal(err)
	}

	return &ChatService{
		Sender:       sender,
		conn:         conn,
		timer:        0,
		lastMessage:  0,
		MessageChan:  make(chan *chatterPb.Message),
		MessageIds:   make([]string, 0),
		Conversation: &chatterPb.Conversation{},
		keys:         keys,
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
		logging.Logger.Sugar().Fatal(err)
		return nil, err
	}
	return r, nil
}

func (c *ChatService) GetConversations() (chan *chatterPb.Conversation, grpc.ServerStreamingClient[chatterPb.GetConversationsResponse], error) {
	client := chatterPb.NewChatServiceClient(c.conn)
	ctx := context.Background()
	r, err := client.GetConversations(ctx,
		&chatterPb.GetConversationsRequest{
			UserId: c.Sender.Id,
		})
	if err != nil {
		return nil, nil, err
	}
	conversationChan := make(chan *chatterPb.Conversation, 0)
	go func() {
		for {
			stream, err := r.Recv()
			if err != nil {
				logging.Logger.Sugar().Error(err)
			}
			logging.Logger.Sugar().Info(stream.Conversations)
			// right now only one conversation per person is supported
			if len(stream.Conversations) == 1 {
				c.Conversation = stream.Conversations[0]
				conversationChan <- stream.Conversations[0]
				if err != nil {
					logging.Logger.Sugar().Error(err)
				}
				break
			}
		}
	}()
	return conversationChan, r, nil
}

func (c *ChatService) SendMessage(senderId string, message string) error {
	client := chatterPb.NewChatServiceClient(c.conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*TIMEOUT)
	defer cancel()
	logging.Logger.Sugar().Infof("senderId: %s message: %s", senderId, message)

	if c.keys.GetOtherPublicKey() == "" {
		c.SetOthersPublicKey(ctx, client, senderId)
	}

	encryptedMessage, err := c.keys.EncryptMessage(message)
	logging.Logger.Sugar().Info("encrpyted message: ")
	logging.Logger.Sugar().Info(encryptedMessage)
	if err != nil {
		logging.Logger.Sugar().Fatal(encryptedMessage)
	}
	//  TODO: Integrate the encryption properly
	messageRequest := chatterPb.SendMessageRequest{
		ConversationId: c.Conversation.Id,
		Content:        message,
		SenderId:       senderId,
		Username:       c.Sender.Username,
	}
	_, err = client.SendMessage(ctx, &messageRequest)
	if err != nil {
		return err
	}

	return nil
}

func (c *ChatService) SetOthersPublicKey(ctx context.Context, client chatterPb.ChatServiceClient, senderId string) {
	publicKeyResp, err := client.GetPublicKeyOfPartner(ctx, &chatterPb.PublicKeyRequest{
		ParticipantId: senderId,
	})
	if err != nil {
		logging.Logger.Sugar().Fatal(err)
	}
	logging.Logger.Sugar().Info("others key: ", publicKeyResp.PublicKey)
	err = c.keys.SetOthersKey(publicKeyResp.PublicKey)
	if err != nil {
		logging.Logger.Sugar().Fatal(err)
	}
}

func (c *ChatService) ReceiveMessage(senderId string) (chan []string, error) {
	ctx := context.Background()
	client := chatterPb.NewChatServiceClient(c.conn)
	messagesChan := make(chan []string)
	if c.keys.GetOtherPublicKey() == "" {
		c.SetOthersPublicKey(ctx, client, senderId)
	}
	go func() {
		for {
			getMessageRequest := chatterPb.GetMessagesRequest{
				ConversationId: c.Conversation.Id,
				Offset:         0,
			}

			stream, err := client.GetMessages(ctx, &getMessageRequest)
			if err != nil {
				logging.Logger.Sugar().Error(err)
			}
			messageResponse, err := stream.Recv()
			if err != nil {
				logging.Logger.Sugar().Error(err)
			}
			newMessages := make([]string, 0)

			for _, message := range messageResponse.Messages {
				oldMessage := slices.Contains(c.MessageIds, message.Id)
				if !oldMessage {
					c.MessageIds = append(c.MessageIds, message.Id)
					newMessageDisplay := fmt.Sprintf("%s: %s", message.Username, message.Content)
					newMessages = append(newMessages, newMessageDisplay)
				}
			}
			messagesChan <- newMessages
		}
	}()
	return messagesChan, nil
}
