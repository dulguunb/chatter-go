package singletons

import (
	"sync"

	chatterPb "github.com/dulguunb/go-chatter/gen"
)

var (
	UsersInstance map[string]*chatterPb.UserInfo
	once          sync.Once
)

func GetUsersInstance() map[string]*chatterPb.UserInfo {
	once.Do(func() {
		users := make(map[string]*chatterPb.UserInfo)
		UsersInstance = users
	})
	return UsersInstance
}
