package main

import "github.com/dulguunb/chatter-go/client/tui"

func main() {
	tui := tui.New()
	tui.CreateLandingPage()
	// userResponseChan := make(chan *chatterPb.ListUsersResponse)
	// username := usernames.GenerateWords(1)
	// clientService := client_grpc.New(username, "localhost")
	// clientService.ValidateTheConnection()
	// go clientService.ListUsersRequest()
	// for {
	// 	select {
	// 	case resp := <-clientService.ListUserChan:
	// 		println(len(resp.Users))
	// 		for username, info := range resp.Users {
	// 			infoUser := fmt.Sprintf("username: %s, clientTime:%d", username, info.ClientTime)
	// 			println(infoUser)
	// 		}
	// 	}
	// }
}
