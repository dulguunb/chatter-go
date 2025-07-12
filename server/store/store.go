package store

import (
	pb "github.com/dulguunb/go-chatter/gen"
)

type DataStoreHandler interface {
	AddUser(in *pb.User) (*pb.User, error)
	SetConversation(conversation *pb.Conversation) error
	GetConversation(userId string) (*pb.Conversation, error)
	GetMessages(convId string) ([]*pb.Message, error)
	GetLastMessage(convId string) (*pb.Message, error)
	SendMessage(message *pb.Message, convId string) error
	SetPublicKey(userId string, publicKey string) error
	GetPublicKey(userId string) (string, error)
	GetAvailableUsers() []*pb.User
	GetConversationsFromUserId(userId string) ([]*pb.Conversation, error)
}
