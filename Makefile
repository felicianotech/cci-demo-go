GOFILES = $(shell find . -name '*.go' -not -path './vendor/*')
GOPACKAGES = $(shell go list ./...  | grep -v /vendor/)

default: build

workdir:
	mkdir -p ~/.go_workspace/src/github.com/felicianotech/cci-demo-go/workdir

build: workdir/contacts

build-native: $(GOFILES)
	go build -o ~/.go_workspace/src/github.com/felicianotech/cci-demo-go/workdir/native-contacts .

workdir/contacts: $(GOFILES)
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o ~/.go_workspace/src/github.com/felicianotech/cci-demo-go/workdir/contacts .

test: test-all

test-all:
	@go test -v $(GOPACKAGES)
