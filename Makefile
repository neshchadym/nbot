APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := ghcr.io/neshchadym
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v		

get:
	go get 

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o nbot -ldflags "-X github.com/neshchadym/nbot/cmd.appVersion=${VERSION}"	

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push: 
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} 	

clean: 
	rm -rf nbot  
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}