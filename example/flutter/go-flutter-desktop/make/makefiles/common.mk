

### FLutter common make file (shared)

GO111MODULE=on

# https://github.com/mysteriumnetwork/go-ci
# Mage 
GO_PATH=$(shell go env GOPATH)
DEP_PATH=$(GO_PATH)/bin/dep
MAGE=go run ci/mage.go

default:
ifeq ("$(wildcard $(DEP_PATH))", "")
	go get -u github.com/golang/dep/cmd/dep
endif
	${DEP_PATH} ensure
	${MAGE} -l

% :
ifeq ("$(wildcard $(DEP_PATH))", "")
	go get -u github.com/golang/dep/cmd/dep
endif
	${DEP_PATH} ensure
	${MAGE} $(MAKECMDGOALS)
    

print:
	@echo
	@echo GO_PATH: $(GO_PATH)
	@echo DEP_PATH: $(DEP_PATH)
	@echo MAGE: $(MAGE)
	@echo

	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo

	@echo
	@echo SAMPLE: $(SAMPLE)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)
	@echo

git-clone:
	# need flutter desktop :)
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
	# Assume hover make file was used.

flu-desk-config:
	hover -h

flu-config-check:
	flutter config
	flutter doctor -v
	flutter devices


flu-clean:
	cd $(LIB_FSPATH)/$(SAMPLE) && flutter clean
flu-update:
	cd $(LIB_FSPATH)/$(SAMPLE) && flutter packages get


flu-desk-init:
	cd $(LIB_FSPATH)/$(SAMPLE) && hover init $(LIB)/$(SAMPLE)
flu-desk-init-clean:
	rm -rf $(LIB_FSPATH)/$(SAMPLE)/go
flu-desk-run:
	cd $(LIB_FSPATH)/$(SAMPLE) && hover run
flu-desk-build:
	cd $(LIB_FSPATH)/$(SAMPLE) && hover build
flu-desk-buildrun: flu-desk-build
	open $(LIB_FSPATH)/$(SAMPLE)/go/build/outputs/darwin/
	open $(LIB_FSPATH)/$(SAMPLE)/go/build/outputs/darwin/$(SAMPLE)
flu-desk-pack:
	# Use the fyne Packaging golang code !!
	# This makes proper packaging for all Desktops. Just needs adaption for Flutter

	
	



