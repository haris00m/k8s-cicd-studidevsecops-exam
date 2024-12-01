# Stage 1: Build stage using the Golang base image
FROM golang:1.22.6-alpine as builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
RUN go build -o goapp ./cmd/main.go

# Stage 2: Runtime stage with a minimal image
FROM alpine:3.20.3

WORKDIR /

COPY --from=builder /app/goapp /usr/local/bin/goapp

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/goapp"]