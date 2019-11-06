# see: https://github.com/news-maily/app/blob/master/Makefile

.PHONY: build

ifneq ($(shell uname), Darwin)
	EXTLDFLAGS = -extldflags "-static" $(null)
else
	EXTLDFLAGS =
endif

PACKAGES = $(shell go list ./... | grep -v /vendor/)


gen: gen_migrations

gen_migrations:
	#go generate github.com/news-maily/app/storage/migrations

test: 
	#go test -cover $(PACKAGES)

build: build_go

build_go:
	mkdir -p bin
	cd $(PWD)/example/go/hello && $(MAKE) build
	cd $(PWD)/example/go/embedcloud && $(MAKE) build
	#go build -o ./bin/hello ./example/go/hello
	#go build -o bin/screenshot ./example/go/screenshot
	#go build -o bin/glfw ./example/go/glfw
	#go build -o bin/app .
	#go build -o bin/bulksender ./consumers/bulksender
	#go build -o bin/campaigner ./consumers/campaigner

build_static:
	cd dashboard; yarn && yarn build
	mkdir -p static
	cp -r dashboard/build static/dashboard

image:
	docker build -t news-maily/app:latest .