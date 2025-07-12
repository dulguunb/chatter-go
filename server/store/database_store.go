package store

import (
	"database/sql"

	"github.com/dulguunb/chatter-go/client/logging"
	pb "github.com/dulguunb/go-chatter/gen"
	"github.com/google/uuid"
)

type DatabaseStoreHandler struct {
	db *sql.DB
}

var _ DataStoreHandler = (*DatabaseStoreHandler)(nil)

func NewDatabaseStoreHandler(db *sql.DB) *DatabaseStoreHandler {
	logging.Logger.Sugar().Info("postgres mode")
	return &DatabaseStoreHandler{
		db: db,
	}
}

func (m *DatabaseStoreHandler) GetAvailableUsers() []*pb.User {
	availableUsers := make([]*pb.User, 0)
	query := `SELECT uuid,username,display_name,avatar_url,available FROM users WHERE available = true`
	rows, err := m.db.Query(query)
	if err != nil {
		logging.Logger.Sugar().Error(err)
		return []*pb.User{}
	}
	for rows.Next() {
		user := &pb.User{}
		err := rows.Scan(&user.Id, &user.Username, &user.DisplayName, &user.AvatarUrl, &user.Available)
		if err != nil {
			logging.Logger.Sugar().Error(err)
		}
		availableUsers = append(availableUsers, user)
	}
	return availableUsers
}

func (m *DatabaseStoreHandler) SetPublicKey(userUuid string, publicKey string) error {
	query := `select * from add_public_key_to_user (uuid_in => $1, public_key_in => $2)`
	userUuidParsed, err := uuid.Parse(userUuid)
	if err != nil {
		return err
	}
	logging.Logger.Sugar().Info(userUuid)
	_, err = m.db.Query(query, userUuidParsed, publicKey)
	if err != nil {
		return err
	}
	return nil
}

func (m *DatabaseStoreHandler) GetPublicKey(userid string) (string, error) {
	query := `SELECT * FROM get_public_key(uuid_in => $1);`
	participantUuid, err := uuid.Parse(userid)
	if err != nil {
		return "", err
	}
	row := m.db.QueryRow(query, participantUuid)
	publicKey := ""
	err = row.Scan(&publicKey)
	if err != nil {
		return "", err
	}
	return publicKey, nil
}

func (m *DatabaseStoreHandler) AddUser(in *pb.User) (*pb.User, error) {
	query := `INSERT INTO users (username, display_name, available,avatar_url) VALUES ($1,$2,$3,$4)`
	_, err := m.db.Query(query, in.Username, in.DisplayName, in.Available, in.AvatarUrl)
	if err != nil {
		logging.Logger.Sugar().Error(err)
		return nil, err
	}
	query = `SELECT uuid FROM users where username = $1`
	row := m.db.QueryRow(query, in.Username)
	if row.Err() != nil {
		logging.Logger.Sugar().Error(row.Err())
		return nil, row.Err()
	}
	row.Scan(&in.Id)
	return in, nil
}

func (m *DatabaseStoreHandler) SetConversation(conversation *pb.Conversation) error {
	tx, err := m.db.Begin()
	if err != nil {
		return err
	}
	defer tx.Commit()
	conversationUuid, err := uuid.Parse(conversation.Id)
	if err != nil {
		return err
	}

	numberOfConversation := 0
	query := "SELECT count(name) FROM conversations where uuid = $1"
	row := m.db.QueryRow(query, conversationUuid)

	err = row.Scan(&numberOfConversation)
	if err != nil {
		return err
	}

	if numberOfConversation == 0 {
		query = `INSERT INTO conversations (name,uuid) VALUES ($1,$2)`
		_, err := tx.Query(query, conversation.Name, conversationUuid)
		if err != nil {
			tx.Rollback()
			logging.Logger.Sugar().Errorf("could not insert to the conversations table", err)
			return err
		}
		return nil
	}
	// TODO: Add last message id
	// lastMessageUuid, err := uuid.Parse(conversation.LastMessageId)
	// if err != nil {
	// 	return err
	// }

	query = `UPDATE conversations SET name=$1 WHERE uuid=$2`
	_, err = tx.Query(query, conversation.Name, conversationUuid)

	if err != nil {
		tx.Rollback()
		return err
	}
	return nil

}

func (m *DatabaseStoreHandler) GetConversation(convId string) (*pb.Conversation, error) {
	conversationUuid, err := uuid.Parse(convId)
	if err != nil {
		return nil, err
	}
	// TODO: Add last messageID
	query := `SELECT uuid, name FROM conversations WHERE uuid=$1`
	row := m.db.QueryRow(query, conversationUuid)
	if row.Err() != nil {
		return nil, row.Err()
	}
	gotConversation := &pb.Conversation{}
	err = row.Scan(&gotConversation.Id, &gotConversation.Name)
	if err != nil {
		return nil, err
	}
	return gotConversation, nil
}

func (m *DatabaseStoreHandler) GetConversationsFromUserId(userId string) ([]*pb.Conversation, error) {
	query := `select c.id,c.name,c.last_message_id from conversations c where c.id in (select conversation_id from conversation_participants where user_id = $1)`

	userUuid, err := uuid.Parse(userId)
	if err != nil {
		return nil, err
	}

	conversations := make([]*pb.Conversation, 0)
	rows, err := m.db.Query(query, userUuid)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		conversation := &pb.Conversation{}
		err := rows.Scan(&conversation.Id, &conversation.Name, &conversation.LastMessageId)
		if err != nil {
			return nil, err
		}
		conversations = append(conversations, conversation)
	}

	return conversations, nil
}

func (m *DatabaseStoreHandler) GetMessages(convId string) ([]*pb.Message, error) {
	messages := make([]*pb.Message, 0)
	conversationUuid, err := uuid.Parse(convId)
	if err != nil {
		return nil, err
	}
	query := `SELECT uuid, conversation_uuid, sender_uuid, content,timestamp ,username FROM messages WHERE conversation_uuid=$1`
	rows, err := m.db.Query(query, conversationUuid)
	if err != nil {
		return nil, err
	}
	for rows.Next() {
		message := &pb.Message{}
		err := rows.Scan(&message.Id, &message.ConversationId, &message.SenderId, &message.Content, &message.Timestamp, &message.Username)
		if err != nil {
			return nil, err
		}
		messages = append(messages, message)
	}
	return messages, nil
}

func (m *DatabaseStoreHandler) GetLastMessage(convoId string) (*pb.Message, error) {
	return nil, nil
}

func (m *DatabaseStoreHandler) SendMessage(message *pb.Message, convId string) error {
	conversationUuid, err := uuid.Parse(convId)
	if err != nil {
		return err
	}
	messageUuid, err := uuid.Parse(message.Id)
	if err != nil {
		return err
	}
	senderUuid, err := uuid.Parse(message.SenderId)
	if err != nil {
		return err
	}
	query := "INSERT INTO messages(uuid, conversation_uuid, sender_uuid, content, timestamp, username) VALUES ($1,$2,$3,$4,$5,$6)"
	row := m.db.QueryRow(query, &messageUuid, &conversationUuid, &senderUuid, &message.Content, &message.Timestamp, &message.Username)
	if row.Err() != nil {
		return row.Err()
	}
	return nil
}
