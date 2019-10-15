

### Flutter Desktop (golang)

# https://github.com/go-flutter-desktop/examples


#include ../pack/Makefile
MAKE_IMPORT=$(GOPATH)/src/github.com/winwisely99/bootstrap/example/flutter/go-flutter-desktop/pack

LIB_NAME=examples
LIB=github.com/go-flutter-desktop/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

GO111MODULE=on


help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)



print: ## print
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
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


SAMPLE_NAME=draggable_borderless
# Does not work.

#SAMPLE_NAME=keyboard_event
#SAMPLE_NAME=mousebuttons
#SAMPLE_NAME=plugin_tutorial
#SAMPLE_NAME=pointer_demo
#SAMPLE_NAME=stocks
#SAMPLE_NAME=texture_tutorial
# broken

#SAMPLE_NAME=xbox_controller
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)

flu-print:
	@echo
	@echo SAMPLE_NAME: $(SAMPLE_NAME)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)
	@echo
flu-clean:
	cd $(SAMPLE_FSPATH) && flutter clean
flu-update:
	cd $(SAMPLE_FSPATH) && flutter packages get

flu-desk-init-pack: ## flu-desk-init-pack

	# Creates any files needed to do packaging.
	# hover build wil then use them.

	# linux
	# this can only be run from Linux, and so must be run in the docker
	cd $(SAMPLE_FSPATH) && hover init-packaging linux-deb

	#cd $(MAKE_IMPORT) && $(MAKE) win-init


flu-desk-init:
	cd $(SAMPLE_FSPATH) && hover init $(LIB)/$(SAMPLE_NAME)
flu-desk-init-clean:
	rm -rf $(SAMPLE_FSPATH)/go
flu-desk-run:
	cd $(SAMPLE_FSPATH) && hover run
flu-desk-build:
	# uses docker to build

	#cd $(SAMPLE_FSPATH) && hover build darwin
	cd $(SAMPLE_FSPATH) && hover build windows
	#cd $(SAMPLE_FSPATH) && hover build linux

flu-desk-buildrun: flu-desk-build
	open $(SAMPLE_FSPATH)/go/build/outputs/darwin/
	open $(SAMPLE_FSPATH)/go/build/outputs/darwin/$(SAMPLE)



### i18n

#SAMPLE=keyboard_event
# works

#SAMPLE=mousebuttons
# works

#SAMPLE=pointer_demo
# works and is amazing
# Is perfect sampler, as it has: licenses, setting ( dark mode, debugging)
# TODO: The i18n code is there and working, but there is no easy way to change it in the GUI.
# TODO: Looks like i can use my Google trans gocode to gen more if i can parse the ARBS

stocks-i18n-step1:

	# generate ui code --> i18n code ( intl_messages.arb from lib/stock_strings.dart )
	cd $(LIB_FSPATH)/$(SAMPLE) && flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/stock_strings.dart
	ls -al cd $(LIB_FSPATH)/$(SAMPLE)/lib/i18n

stocks-i18n-step2:
	# generate arb string --> i18n code (a stock_messages_<locale>.dart for each stocks_<locale>.arb file and stock_messages_all.dart)
	cd $(LIB_FSPATH)/$(SAMPLE) && flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n \
   --generated-file-prefix=stock_ --no-use-deferred-loading lib/*.dart lib/i18n/stocks_*.arbs
    # Now you have all the "stock_messages_all, en, es.dart regenerated
	# Its used the stocks_en,es.arb as sources
	# Now each of the locale i18n dart code is populated with the translated string.
	
	



