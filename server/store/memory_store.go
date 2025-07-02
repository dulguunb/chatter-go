package store

import (
	"fmt"
	"slices"
	"sync"

	pb "github.com/dulguunb/go-chatter/gen"
)

type MemoryStoreHandler struct {
	mu            sync.Mutex
	messages      map[string][]*pb.Message
	users         []*pb.User
	publicKeys    map[string]string
	conversations map[string]*pb.Conversation
}

var _ DataStoreHandler = (*MemoryStoreHandler)(nil)

func NewMemoryStore() *MemoryStoreHandler {
	return &MemoryStoreHandler{
		messages:      make(map[string][]*pb.Message),
		users:         make([]*pb.User, 0),
		publicKeys:    make(map[string]string),
		conversations: make(map[string]*pb.Conversation),
	}
}

func (m *MemoryStoreHandler) GetAvailableUsers() []*pb.User {
	availableUsers := make([]*pb.User, 0)
	for _, user := range m.users {
		if user.Available {
			availableUsers = append(availableUsers, user)
		}
	}
	return availableUsers
}

func (m *MemoryStoreHandler) SetPublicKey(userid string, publicKey string) error {
	m.mu.Lock()
	defer m.mu.Unlock()
	m.publicKeys[userid] = publicKey
	// TODO: check the memory limit
	return nil
}

func (m *MemoryStoreHandler) GetPublicKey(userid string) (string, error) {
	m.mu.Lock()
	defer m.mu.Unlock()
	if k, ok := m.publicKeys[userid]; ok {
		return k, nil
	}
	return "", fmt.Errorf("user: %s does not have public key exist", userid)
}

func (m *MemoryStoreHandler) AddUser(in *pb.User) error {
	m.mu.Lock()
	defer m.mu.Unlock()
	m.users = append(m.users, in)
	// TODO: check the memory limit
	return nil
}
func (m *MemoryStoreHandler) SetConversation(convId string, conversation *pb.Conversation) error {
	m.mu.Lock()
	defer m.mu.Unlock()
	m.conversations[convId] = conversation
	// TODO: check the memory limit
	return nil
}

func (m *MemoryStoreHandler) GetConversation(convId string) (*pb.Conversation, error) {
	if m, ok := m.conversations[convId]; ok {
		return m, nil
	}
	return nil, fmt.Errorf("convId: %s does not belong to any conversation", convId)
}

func (m *MemoryStoreHandler) GetConversationsFromUserId(userId string) ([]*pb.Conversation, error) {
	conversations := make([]*pb.Conversation, 0)
	for _, conv := range m.conversations {
		if slices.Contains(conv.ParticipantIds, userId) {
			conversations = append(conversations, conv)
		}
	}
	return conversations, nil
}

func (m *MemoryStoreHandler) GetMessages(convId string) ([]*pb.Message, error) {
	if m, ok := m.messages[convId]; ok {
		return m, nil
	}
	return []*pb.Message{}, nil
}

func (m *MemoryStoreHandler) GetLastMessage(convoId string) (*pb.Message, error) {

	return nil, nil
}

func (m *MemoryStoreHandler) SendMessage(message *pb.Message, convId string) error {
	m.mu.Lock()
	defer m.mu.Unlock()
	m.messages[convId] = append(m.messages[convId], message)
	// TODO: check the memory limit
	return nil
}
