
PROGRAM_NAME ?= ""
VERSION=$$(git rev-parse HEAD | cut -c1-7)
# Example you can run the build:
# PROGRAM_NAME=server make linux -f build.mk
linux: ${PROGRAM_NAME}/main.go
	echo ${VERSION}
	mkdir -p ${PROGRAM_NAME}/build
	go build -ldflags="-X '${PROGRAM_NAME}/config.VERSION=${VERSION}'" ${PROGRAM_NAME}/main.go
	mv ${PROGRAM_NAME}/main ${PROGRAM_NAME}/build/${PROGRAM_NAME}

proto: proto/chat.proto
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	protoc -I=./proto --go_out=./gen --go_opt=paths=source_relative ./proto/chat.proto --go-grpc_out=./gen --go-grpc_opt=paths=source_relative