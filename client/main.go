package main

import (
	"fmt"

	"github.com/dulguunb/chatter-go/client/tui"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

// import "github.com/dulguunb/chatter-go/client/tui"
func CreateServerConnection(serverIp string, port int64) (*grpc.ClientConn, error) {
	address := fmt.Sprintf("%s:%d", serverIp, port)
	conn, err := grpc.NewClient(address, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		return nil, err
	}
	return conn, nil
}

func main() {
	tui := tui.New()
	tui.CreateLandingPage()
}
