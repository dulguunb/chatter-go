package main

import (
	"fmt"
	"log"
	"net"

	"github.com/dulguunb/chatter-go/server/api"
	"github.com/dulguunb/chatter-go/server/store"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	"google.golang.org/grpc"
)

var (
	port = 50051
)

func main() {
	memStore := store.NewMemoryStore()
	chatServer := api.NewChatServer(memStore)
	lis, err := net.Listen("tcp", fmt.Sprintf("0.0.0.0:%d", port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	chatterPb.RegisterChatServiceServer(s, chatServer)
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
