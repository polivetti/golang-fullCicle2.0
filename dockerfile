
FROM golang:alpine as builder

RUN mkdir -p /app
WORKDIR /app

COPY go.mod .

### Setting a proxy for downloading modules
ENV GOPROXY https://proxy.golang.org,direct

### Download Go application module dependencies
RUN go mod download

COPY . .

### CGO has to be disabled cross platform builds
### Otherwise the application won't be able to start
ENV CGO_ENABLED=0


RUN GOOS=linux go build ./app.go


### Define the running image
FROM scratch

WORKDIR /app

COPY --from=builder /app/app .

CMD ["/app/app"]