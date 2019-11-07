# see exampe: https://github.com/GeertJohan/go.rice/tree/master/example
all: build

dep-os:
	go get github.com/GeertJohan/go.rice
	go get github.com/GeertJohan/go.rice/rice

	go get -u github.com/davecgh/go-spew/spew

gen: dep-os
	# embed statics
	rice embed-go

build: gen
	go build -o ./bin/hellocloud

run:
	go run main.go

