# see exampe: https://github.com/GeertJohan/go.rice/tree/master/example

dep:
	go get github.com/GeertJohan/go.rice
	go get github.com/GeertJohan/go.rice/rice

	go get -u github.com/davecgh/go-spew/spew

build: gen
	go build -o ./bin/hellocloud

run: gen
	go run main.go

gen:
	# embed statics
	rice embed-go