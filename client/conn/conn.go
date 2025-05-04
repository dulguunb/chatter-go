package conn

import (
	"fmt"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func CreateServerConnection(serverIp string, port int64) (*grpc.ClientConn, error) {
	address := fmt.Sprintf("%s:%d", serverIp, port)
	conn, err := grpc.NewClient(address, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		return nil, err
	}
	return conn, nil
}
