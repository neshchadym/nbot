VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v		

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o nbot -ldflags "-X github.com/neshchadym/nbot/cmd.appVersion=${VERSION}"	

clean: 
	rm -rf nbot  