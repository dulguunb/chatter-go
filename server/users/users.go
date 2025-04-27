package users

import (
	"sync"

	chatterPb "github.com/dulguunb/go-chatter/gen"
)

var (
	UsersInstance map[string]*chatterPb.UserInfo
	once          sync.Once
)

func GetInstance() map[string]*chatterPb.UserInfo {
	once.Do(func() {
		users := make(map[string]*chatterPb.UserInfo)
		UsersInstance = users
	})
	return UsersInstance
}
