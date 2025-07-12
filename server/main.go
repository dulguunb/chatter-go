package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"net"

	"github.com/dulguunb/chatter-go/server/api"
	"github.com/dulguunb/chatter-go/server/store"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	_ "github.com/lib/pq"
	"google.golang.org/grpc"
)

var (
	port = 50051
)

func main() {
	storageType := flag.String("storage", "memory", "the storage type to be used")
	dbport := flag.Int("postgres_port", 5432, "postgres port")
	dbhost := flag.String("postgres_host", "localhost", "the storage type to be used")
	dbpassword := flag.String("postgres_password", "postgres", "postgres password")
	dbuser := flag.String("postgres_user", "postgres", "postgres user")
	dbname := flag.String("postgres_db", "chatter_db", "database name")
	var memStore store.DataStoreHandler
	flag.Parse()
	if *storageType == "memory" {
		memStore = store.NewMemoryStore()
	} else if *storageType == "postgres" {
		psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+
			"password=%s dbname=%s sslmode=disable",
			*dbhost, *dbport, *dbuser, *dbpassword, *dbname)
		db, err := sql.Open("postgres", psqlInfo)
		if err != nil {
			log.Fatal(err)
		}
		memStore = store.NewDatabaseStoreHandler(db)
	}

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
