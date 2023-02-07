FROM golang:alpine AS builder

WORKDIR /go/src

COPY main.go /go/src

RUN cd /go/src && go mod init mods && go build -o main

FROM alpine:latest

WORKDIR /app
COPY --from=builder /go/src/main /app/
ENTRYPOINT ./main
