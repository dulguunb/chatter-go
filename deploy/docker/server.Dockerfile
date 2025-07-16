FROM alpine:3.21.3

WORKDIR /app
COPY server /app/
COPY  db/* /app/db/migrations/

EXPOSE 50051
ENTRYPOINT [ "/app/server" ]