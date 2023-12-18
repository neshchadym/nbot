APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := ghcr.io/neshchadym
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETARCH=amd64 
TARGETOS=linux

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
	docker build . -t $(REGISTRY)/$(APP):$(VERSION)-${TARGETOS}-$(TARGETARCH) --build-arg TARGETARCH=$(TARGETARCH

push: 
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH} 	

clean: 
	rm -rf nbot  
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
