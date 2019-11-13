# https://github.com/mtpereira/parede
# uses mage
# uses CI

LIB_NAME=parede
LIB=github.com/mtpereira/$(LIB_NAME)
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

all: build

dep-os:
	## assumes mage installed from tools folder into GO BIN


build:
	cd $(LIB_FSPATH) && mage -compile $(PWD)/bin/$(LIB_BIN_NAME)
run:
	./bin/$(LIB_BIN_NAME)
	
mage-init:
	cp main.go $(LIB_FSPATH)
	cd $(LIB_FSPATH) && go mod init
mage-list:
	cd $(LIB_FSPATH) && go run main.go
mage-content:
	cd $(LIB_FSPATH) && go run main.go content
mage-preview:
	cd $(LIB_FSPATH) && go run main.go preview
mage-publish:
	cd $(LIB_FSPATH) && go run main.go publish




