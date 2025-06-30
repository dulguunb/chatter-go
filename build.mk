
PROGRAM_NAME ?= ""
VERSION=$$(git rev-parse HEAD | cut -c1-7)
CONTAINER_TAG ?= "meow-chat-${VERSION}"
PATH ?= "${PATH}:${HOME}/go/bin/"
# Example you can run the build:
# PROGRAM_NAME=server make linux -f build.mk
# PROGRAM_NAME=server make linux_static -f build.mk
linux_static: ${PROGRAM_NAME}/main.go
	echo ${VERSION}
	mkdir -p ${PROGRAM_NAME}/build
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-X '${PROGRAM_NAME}/config.VERSION=${VERSION}'" ${PROGRAM_NAME}/main.go
	mv main ${PROGRAM_NAME}/build/${PROGRAM_NAME}

linux: ${PROGRAM_NAME}/main.go
	echo ${VERSION}
	mkdir -p ${PROGRAM_NAME}/build
	GOOS=linux GOARCH=amd64 go build -ldflags="-X '${PROGRAM_NAME}/config.VERSION=${VERSION}'" ${PROGRAM_NAME}/main.go
	mv main ${PROGRAM_NAME}/build/${PROGRAM_NAME}

windows: ${PROGRAM_NAME}/main.go
	echo ${VERSION}
	mkdir -p ${PROGRAM_NAME}/build
	GOOS=windows GOARCH=amd64 go build -ldflags="-X '${PROGRAM_NAME}/config.VERSION=${VERSION}'" ${PROGRAM_NAME}/main.go
	mv main.exe ${PROGRAM_NAME}/build/${PROGRAM_NAME}.exe

fmt:
	go fmt client/*/*

proto: proto/chat.proto
	# make sure that the protoc-gen-go is in PATH
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	protoc -I=./proto --go_out=./gen --go_opt=paths=source_relative ./proto/chat.proto --go-grpc_out=./gen --go-grpc_opt=paths=source_relative
	protoc -I=./proto --go_out=./gen --go_opt=paths=source_relative ./proto/chat.proto --dart_out=grpc:flutter_client/lib/generated

build_container: linux
	mv ${PROGRAM_NAME}/build/${PROGRAM_NAME} deploy/docker
	cd deploy/docker && docker build --file=server.Dockerfile --build-arg SERVER_BUILD_PATH=./server -t=${CONTAINER_TAG} .

mockery:
	go install github.com/vektra/mockery/v3@v3.2.5
	mockery client/
