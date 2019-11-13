

### Flutter Desktop (golang)

# https://github.com/go-flutter-desktop/hover

# Has cross compile using Docker. This is huge 
#https://github.com/go-flutter-desktop/hover/pull/23

LIB_NAME=hover
LIB=github.com/go-flutter-desktop/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

print:
	@echo
	@echo $(OS)
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)

	@echo
	@echo LIB_BIN_NAME: $(LIB_BIN_NAME)
	@echo LIB_BIN_FSPATH: $(LIB_BIN_FSPATH)
	@echo

git-clone:
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
git-pull:
	cd $(LIB_FSPATH) && git pull
git-clean:
	rm -rf $(LIB_FSPATH)

code:
	code $(LIB_FSPATH)

os-dep:
ifeq ($(OS),Windows_NT)
	# install 
	scoop install docker
else 
	UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	# linux
	#apt install libglfw
endif
ifeq ($(UNAME_S),Darwin)
	# glfw
	# mac
	brew install glfw
	# docker for cross compile
	# the client
	brew install docker
	# the dmg
	brew cask install docker
endif
endif

go-build-list:
	@echo
	@echo Listing binaries:

	stat $(LIB_BIN_FSPATH)
	stat $(LIB_BIN_FSPATH).exe

go-build:
	cd $(LIB_FSPATH) && GOOS=darwin go build -o $(LIB_BIN_FSPATH) .
	cd $(LIB_FSPATH) && GOOS=windows go build -o $(LIB_BIN_FSPATH).exe .

	$(MAKE) go-build-list
go-build-clean:
	rm -f $(LIB_BIN_FSPATH)
	rm -f $(LIB_BIN_FSPATH).exe

	$(MAKE) go-build-list

ci:
	# usesd by CI
	$(MAKE) git-clone
	cd $(LIB_FSPATH) && GOOS=darwin go build -o $(LIB_BIN_FSPATH) .



