proto: proto/chat.proto
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	protoc -I=./proto --go_out=./gen --go_opt=paths=source_relative ./proto/chat.proto --go-grpc_out=./gen --go-grpc_opt=paths=source_relative
.PHONY: proto