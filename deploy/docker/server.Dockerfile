FROM alpine:3.21.3

WORKDIR /app
COPY server /app/

EXPOSE 50051
ENTRYPOINT [ "/app/server" ]