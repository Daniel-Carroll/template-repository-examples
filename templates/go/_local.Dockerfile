FROM golang:1.16.4-alpine3.13

WORKDIR /usr/local/go/src/{{ repo_url }}

COPY . /usr/local/go/src/{{ repo_url }}/

RUN apk --no-cache add tzdata

RUN go get github.com/githubnemo/CompileDaemon && go get -d -v ./...