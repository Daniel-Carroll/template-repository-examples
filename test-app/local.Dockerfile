FROM golang:1.16.4-alpine3.13

WORKDIR /usr/local/go/src/github.com/Daniel-Carroll/example-repo

COPY . /usr/local/go/src/github.com/Daniel-Carroll/example-repo/

RUN apk --no-cache add tzdata

RUN go get github.com/githubnemo/CompileDaemon && go get -d -v ./...