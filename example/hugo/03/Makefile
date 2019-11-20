# https://github.com/gohugoio/hugoBasicExample

LIB_FSPATH=$(PWD)/hugoBasicExample

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## print
	@echo
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo


git-clone: ## git-clone
	git clone https://github.com/gohugoio/hugoBasicExample.git
	cd hugoBasicExample

dep-os: ## dep-os

	# Later these will be installed for you by the higher level mage script.
	# CI can then call then and so do the dep-os at the CI level

	## assumes hugo installed from tools folder into GO BIN
	which hugo
	## assumes mage installed from tools folder into GO BIN
	which mage

build:
	cp magefile.go $(LIB_FSPATH)


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




