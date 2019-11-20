# https://github.com/mtpereira/parede
# uses mage
# uses CI

LIB_NAME=parede
LIB=github.com/mtpereira/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## print
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

dep-os: ## dep-os

	# Later these will be installed for you by the higher level mage script.
	# CI can then call then and so do the dep-os at the CI level

	## assumes hugo installed from tools folder into GO BIN
	which hugo
	## assumes mage installed from tools folder into GO BIN
	which mage


### build

build:
	cd $(LIB_FSPATH) && mage -compile $(PWD)/bin/$(LIB_BIN_NAME)
build-run:
	./bin/$(LIB_BIN_NAME)



### mage based ( used by dev that has mage )
	
mage-help:
	cd $(LIB_FSPATH) && mage -help

mage-list:
	cd $(LIB_FSPATH) && mage
	
mage-content:
	cd $(LIB_FSPATH) && mage content



### go based ( used by CI, that does not have mage )
go-init:
	cp main.go $(LIB_FSPATH)
	cd $(LIB_FSPATH) && go mod init
go-list:
	cd $(LIB_FSPATH) && go run main.go
go-content:
	cd $(LIB_FSPATH) && go run main.go content
go-preview:
	cd $(LIB_FSPATH) && go run main.go preview
go-publish:
	cd $(LIB_FSPATH) && go run main.go publish




