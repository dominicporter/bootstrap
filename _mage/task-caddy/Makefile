# https://github.com/caddyserver/caddy-docker

.DEFAULT_GOAL:=help
SHELL:=/bin/bash


LIB_NAME=caddy-docker
LIB=github.com/caddyserver/$(LIB_NAME)
LIB_BRANCH=master
LIB_TAG=v1.33.0
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)


help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## Print
	# info is standard. error and warming also work.
	$(info )
	$(info Variables - )


	$(info LIB_NAME: 		$(LIB_NAME))
	$(info LIB: 			$(LIB)) 
	$(info LIB_BRANCH: 		$(LIB_BRANCH))
	$(info LIB_FSPATH: 		$(LIB_FSPATH))
	$(info LIB_BIN_NAME: 	$(LIB_BIN_NAME))
	$(info LIB_BIN_FSPATH: 	$(LIB_BIN_FSPATH)) 

	$(info )
	$(info MAKE_IMPORT: 	$(MAKE_IMPORT)) 

	$(info )
	$(info SAMPLE_NAME: 	$(SAMPLE_NAME))
	$(info SAMPLE_FSPATH: 	$(SAMPLE_FSPATH)) 
	$(info )


##@ Git

git-print: ## Git Print
	cd $(LIB_FSPATH) && git status

git-clone: ## git-clone
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)

	cd $(LIB_FSPATH) && git status

git-clone-tag: ## git-clone-tag
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout tags/$(LIB_TAG)
	#cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)

	cd $(LIB_FSPATH) && git status

git-pull: ## Git pull
	cd $(LIB_FSPATH) && git pull
git-clean: ## Git clean
	rm -rf $(LIB_FSPATH)
git-code: ## Git clean
	code $(LIB_FSPATH)

dep-os: ## dep-os

	# call sub make file
	cd go-task && $(MAKE) build

run:
	cd $(LIB_FSPATH) && task

run-docker:
	cd $(LIB_FSPATH) && task





