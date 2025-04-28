package main

import (
	"context"
	"fmt"
	"log"
	"net"

	"github.com/dulguunb/chatter-go/server/api"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	"google.golang.org/grpc"
)

var (
	port = 50051
)

func main() {
	ctx := context.Background()
	listUserServer := api.ListUserServer{}
	chatServer := api.ChatServer{}
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	chatterPb.RegisterListUsersRequestServiceServer(s, &listUserServer)
	chatterPb.RegisterChatServer(s, &chatServer)
	go listUserServer.CheckAvailableBackground(ctx)
	go listUserServer.DeleteUnavailableUsers(ctx)
	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
