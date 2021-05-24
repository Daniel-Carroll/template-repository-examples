# Build Stage
FROM us.gcr.io/constellation-utils/golang-alp:latest as build-go

WORKDIR /usr/local/go/src/example-module

ARG CURRENT_ENVIRONMENT=$ENVIRONMENT

COPY . /usr/local/go/src/github.com/Daniel-Carroll/example-repo

# Compiler flags are set. Reference: http://www.jeffsloyer.io/post/cross-compiling-docker-alpine-golang/
RUN go get -d -v ./... \
    && cd /usr/local/go/src/github.com/Daniel-Carroll/example-repo/cmd/fulfillment/ \
    && GOOS=linux go build -ldflags "-s" -a -installsuffix cgo .

# Final Stage
FROM alpine 

# Certificates needed for https to google function
RUN apk add --update --no-cache ca-certificates \
    && mkdir /app

RUN apk --no-cache add tzdata

WORKDIR /app

COPY --from=build-go /usr/local/go/src/github.com/Daniel-Carroll/example-repo/cmd/fulfillment .
COPY --from=build-go /usr/local/go/src/github.com/Daniel-Carroll/example-repo/scripts/start-app .

CMD ["sh", "-c", "./start-app"]