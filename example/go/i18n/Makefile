# github.com/winwisely99/main
# windows users run in git-bash. Also might have to add SSH key to github to perform
# git operations from make file
# https://help.github.com/en/enterprise/2.17/user/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent	
ifndef $(GOPATH)
    GOPATH=$(shell go env GOPATH)
    export GOPATH
endif
LIB_NAME=i18n
LIB=github.com/winwisely99/bootstrap/example/go/$(LIB_NAME)
LIB_BRANCH=master
GO111MODULE=on

ifeq ($(OS),Windows_NT)
LIB_FSPATH=$(subst \,/,$(subst C:\,/c/,$(GOPATH)/src/$(LIB)))
SAMPLE_FSPATH=$(subst \,/,$(subst C:\,/c/,$(LIB_FSPATH)))
PROTO_OUTPUT=$(subst /c/,C:\,$(subst \,/,$(LIB_FSPATH)))
HOME_PATH=$(subst \,/,$(subst C:\,/c/,$(HOME)))
else
LIB_FSPATH=$(GOPATH)/src/$(LIB)
SAMPLE_FSPATH=$(LIB_FSPATH)
HOME_PATH=$(HOME)
endif 

GO_OS 		:= $(shell go env GOOS)
GO_ARCH		:= $(shell go env GOARCH)

GIT_VERSION	:= $(shell git describe --tags)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## print

	@echo
	@echo GO_OS: $(GO_OS)
	@echo GO_OS: $(GO_ARCH)
	@echo

	@echo
	@echo GIT_VERSION: $(GIT_VERSION)
	@echo GIT_OTHER: $(shell git describe --all)
	@echo

	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo GOPATH $(GOPATH)
	@echo HOME $(HOME)
	@echo

	@echo
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)
	@echo PROTO_OUTPUT: $(PROTO_OUTPUT)
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

os-dep: ##os-dep
	@echo Installing OS required tools
	
	hover doctor

ifeq ($(GO_OS), linux)
	@echo Linux detected
endif

ifeq ($(GO_OS), darwin)
	@echo Mac detected
endif

ifeq ($(GO_OS), windows)
	@echo Windows detected
endif

flu-config: ## flu-config
	flutter config
	flutter doctor -v
	flutter devices

flu-config-desk: ## flu-config-desk
	hover -h




flu-clean:
	cd $(SAMPLE_FSPATH) && flutter clean
flu-update:
	cd $(SAMPLE_FSPATH) && flutter packages get
	$(MAKE) gen-icons
	$(MAKE) gen-hive
	$(MAKE) gen-proto
	$(MAKE) gen-i18n
	cd $(SAMPLE_FSPATH) && flutter analyze 

gen-icons:
	# mobile and web
	@echo
	@echo Generating icons for Flutter
	@echo
	cd $(SAMPLE_FSPATH) && flutter pub run flutter_launcher_icons:main

	# desktop
	@echo
	@echo Copying icon-png from flutter assets into go assets, so hover can use it
	@echo
	cp $(SAMPLE_FSPATH)/assets/icon/icon.png $(SAMPLE_FSPATH)/go/assets
gen-hive:
	cd $(SAMPLE_FSPATH) && flutter packages pub run build_runner clean
	cd $(SAMPLE_FSPATH) && flutter packages pub run build_runner build --delete-conflicting-outputs
gen-i18n:
	# calls google and pulls the data using the golang tool, etc etc
	# does the dat i18n code gen.....
gen-proto:
	pub global activate protoc_plugin
	mkdir -p $(SAMPLE_FSPATH)/lib/api/v1/google/protobuf


ifeq ($(GO_OS), windows)
	@echo Windows detected
	protoc empty.proto timestamp.proto wrappers.proto --proto_path=$(LIB_FSPATH)/server/third_party/google/protobuf/ --plugin=$(HOME_PATH)/AppData/Roaming/Pub/Cache/bin/protoc-gen-dart.bat --dart_out=grpc:"$(PROTO_OUTPUT)/client/lib/chat_view/api/v1/google/protobuf"
	protoc chat.proto --proto_path=$(LIB_FSPATH)/server/api/proto/v1/ --plugin=$(HOME_PATH)/AppData/Roaming/Pub/Cache/bin/protoc-gen-dart.bat --dart_out=grpc:"$(PROTO_OUTPUT)/client/lib/chat_view/api/v1/"
else
	protoc empty.proto timestamp.proto wrappers.proto --proto_path=$(LIB_FSPATH)/server/third_party/google/protobuf --plugin=protoc-gen-dart=$(HOME)/.pub-cache/bin/protoc-gen-dart --dart_out=grpc:$(SAMPLE_FSPATH)/lib/api/v1/google/protobuf
	protoc chat.proto --proto_path=$(LIB_FSPATH)/server/api/proto/v1/ --plugin=protoc-gen-dart=$(HOME)/.pub-cache/bin/protoc-gen-dart --dart_out=grpc:$(SAMPLE_FSPATH)/client/lib/chat_view/api/v1/
endif

GSHEET_FSPATH=$(PWD)/../../bootstrap/tool/googlesheet
gen-mockdata:
	#cd $(GSHEET_FSPATH) && $(MAKE) local-run-datadump
	cp -r $(GSHEET_FSPATH)/outputs/datadump/json ./assets/mockData2



### DESK

flu-desk-local-run: ## flu-desk-local-run
	cd $(SAMPLE_FSPATH) && hover run

flu-desk-local-build: ## flu-desk-local-build

ifeq ($(GO_OS), linux)
	@echo Linux detected

	cd $(SAMPLE_FSPATH) && hover build $(GO_OS)-appimage --version-number $(GIT_VERSION)
	cd $(SAMPLE_FSPATH) && hover build $(GO_OS)-deb --version-number $(GIT_VERSION)
	cd $(SAMPLE_FSPATH) && hover build $(GO_OS)-rpm --version-number $(GIT_VERSION)
	cd $(SAMPLE_FSPATH) && hover build $(GO_OS)-snap --version-number $(GIT_VERSION)

endif

ifeq ($(GO_OS), darwin)
	@echo Mac detected

	#cd $(SAMPLE_FSPATH) && hover build $(GO_OS)-bundle --version-number $(GIT_VERSION)
	#cd $(SAMPLE_FSPATH) && hover build $(GO_OS) --version-number $(GIT_VERSION)
	cd $(SAMPLE_FSPATH) && hover build $(GO_OS)-pkg --version-number $(GIT_VERSION)
	#cd $(SAMPLE_FSPATH) && hover build $(GO_OS)-dmg --version-number $(GIT_VERSION)

endif

ifeq ($(GO_OS), windows)
	@echo Windows detected
	cd $(SAMPLE_FSPATH) && hover build $(GO_OS) --version-number $(GIT_VERSION)
	cd $(SAMPLE_FSPATH) && hover build $(GO_OS)-msi --version-number $(GIT_VERSION)
endif

	

flu-desk-build-all: ## flu-desk-build-all
	$(MAKE) flu-desk-build-clean
	$(MAKE) flu-desk-build-init
	$(MAKE) flu-desk-build

flu-desk-build-init: 
	cd $(SAMPLE_FSPATH) && hover init $(LIB)

flu-desk-build-clean:
	rm -rf $(SAMPLE_FSPATH)/go
	docker system prune


flu-desk-build:
	# uses docker to build

	cd $(SAMPLE_FSPATH) && hover build darwin --version-number $(GIT_VERSION)
	cd $(SAMPLE_FSPATH) && hover build windows --version-number $(GIT_VERSION)
	# broken: need to look into
	#cd $(SAMPLE_FSPATH) && hover build linux --version-number $(GIT_VERSION)

flu-desk-buildrun: flu-desk-build

	# darwin
	open $(SAMPLE_FSPATH)/go/build/outputs/darwin/
	open $(SAMPLE_FSPATH)/go/build/outputs/darwin/$(SAMPLE)

### Desk Packaging

flu-desk-pack-all: ## flu-desk-pack-all
	$(MAKE) flu-desk-pack-clean
	$(MAKE) flu-desk-pack-init
	$(MAKE) flu-desk-pack

flu-desk-pack-clean:
	rm -rf $(SAMPLE_FSPATH)/go/packaging

	# this wipes ALL of docker data
	docker system prune
	#docker system prune --force




flu-desk-pack-init:

	# Creates any files needed to do packaging.
	# Only needed once.

	# hover init-packaging --help

	#darwin
	cd $(SAMPLE_FSPATH) && hover init-packaging darwin-bundle
	cd $(SAMPLE_FSPATH) && hover init-packaging darwin-pkg

	# windows
	cd $(SAMPLE_FSPATH) && hover init-packaging windows-msi

	# linux
	cd $(SAMPLE_FSPATH) && hover init-packaging linux-appimage
	cd $(SAMPLE_FSPATH) && hover init-packaging linux-deb
	cd $(SAMPLE_FSPATH) && hover init-packaging linux-snap


flu-desk-pack:


	# NOTE: Mac devs: # For docker builds on MAC you need to add "/var/folders/wp/" to your docker file sharing.
	# hover build --help


	# darwin (works)
	cd $(SAMPLE_FSPATH) && hover build darwin-pkg --version-number $(GIT_VERSION)
	
	# windows (works)
	#cd $(SAMPLE_FSPATH) && hover build windows-msi

	# linux 
	# works
	#cd $(SAMPLE_FSPATH) && hover build linux-deb

	# broken: Issue: https://github.com/go-flutter-desktop/go-flutter/issues/287#issuecomment-544161253
	# marked as "will not fix" because its shitty Ubuntu SnapCraft error.
	# It seems that linux-appimage (https://appimage.org/) works on ubuntu so screw SnapCraft..
	# to install on ubuntu using a appimage is easy: https://askubuntu.com/questions/774490/what-is-an-appimage-how-do-i-install-it
	# We need to try and make sure it works with flutter ! Who has an ubuntu laptop ?

	# Update: works for basic go-flutter example
	#cd $(SAMPLE_FSPATH) && hover build linux-snap

	# broken: Issue: https://github.com/go-flutter-desktop/go-flutter/issues/289
	# Marked "as wont fix". So have to ask AppImage team.

	# Update: works for basic go-flutter example
	#cd $(SAMPLE_FSPATH) && hover build linux-appimage
	
flu-desk-pack-open:
	# to see the outputs in your file system.
	open $(SAMPLE_FSPATH)/go/build/outputs


# Will vary per run and machine.
DOCKERTEMP_FSPATH=/var/folders/wp/ff6sz9qs6g71jnm12nj2kbyw0000gp

flu-desk-pack-tmp-list:
	ls /var/folders/wp/
	stat $(DOCKERTEMP_FSPATH)

flu-desk-pack-tmp-clean:
	# clean out docker tmp file dir
	rm -rf $(DOCKERTEMP_FSPATH)

	#ls /var/folders/wp/
	#cd /var/folders/wp/ && rm -rf *
	#ls /var/folders/wp/

flu-desk-pack-tmp-zip:
	# to share whats in tmp
	cd $(DOCKERTEMP_FSPATH) && zip -r -X $(SAMPLE_FSPATH)/go/build/outputs/dockertemp.zip *




### Desk Zipping

flu-desk-dist-all: ## flu-desk-dist-all
	$(MAKE) flu-desk-dist-clean
	$(MAKE) flu-desk-dist-zip
	$(MAKE) flu-desk-dist-unzip

flu-desk-dist-clean:
	rm -rf $(SAMPLE_FSPATH)/dist
	mkdir -p $(SAMPLE_FSPATH)/dist

flu-desk-dist-zip:
	# zip build by OS.

	# darwin
	cd $(SAMPLE_FSPATH)/go/build/outputs/darwin && zip -r -X $(SAMPLE_FSPATH)/dist/darwin.zip *

	# windows
	cd $(SAMPLE_FSPATH)/go/build/outputs/windows && zip -r -X $(SAMPLE_FSPATH)/dist/windows.zip *
	
	# linux
	cd $(SAMPLE_FSPATH)/go/build/outputs/linux && zip -r -X $(SAMPLE_FSPATH)/dist/linux.zip *
	

flu-desk-dist-unzip:
	# clean dist
	rm -rf $(SAMPLE_FSPATH)/dist/out
	mkdir -p $(SAMPLE_FSPATH)/dist/out


	# darwin
	unzip $(SAMPLE_FSPATH)/dist/darwin.zip -d $(SAMPLE_FSPATH)/dist/out/darwin

	# windows
	unzip $(SAMPLE_FSPATH)/dist/windows.zip -d $(SAMPLE_FSPATH)/dist/out/windows
	
	# linux
	unzip $(SAMPLE_FSPATH)/dist/linux.zip -d $(SAMPLE_FSPATH)/dist/out/linux

	

### Mob


flu-mob-run: ## flu-mob-run
	cd $(SAMPLE_FSPATH) && flutter run -d all

flu-mob-build-and: ## flu-mob-build-and

	# Create keystore
	# Warning: Keep the keystore file private; do not check it into public source control.
	@echo Creating Keystore 
ifeq ($(GO_OS), linux)
	@echo Linux detected
	keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
endif

ifeq ($(GO_OS), darwin)
	@echo Mac detected
	keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
endif

ifeq ($(GO_OS), windows)
	@echo Windows detected
	keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
endif

	# Create keystore
	

	# TODO and sign
	#cd $(SAMPLE_FSPATH) && flutter 



### WEB

flu-web-config:
	# flutter channel ?
	#flutter channel dev
	#flutter upgrade

	flutter config --enable-web
	# turn off any desktop
	flutter config --no-enable-linux-desktop
	flutter config --no-enable-macos-desktop
	flutter config --no-enable-windows-desktop
flu-web-create: flu-web-config
	# works 
	# make sure using new dir.
	mkdir -p $(SAMPLE_FSPATH)
	cd $(SAMPLE_FSPATH) && flutter create --web .
flu-web-run: flu-web-config ## flu-web-run
	# works
	# Reload works too :)
	cd $(SAMPLE_FSPATH) && flutter run -d chrome
flu-web-build: flu-web-config ## flu-web-build
	# works :)
	cd $(SAMPLE_FSPATH) && flutter build web --release
flu-web-test: flu-web-config ## flu-web-test
	# works :)
	cd $(SAMPLE_FSPATH) && flutter test --platform=chrome




### Firebase


# Deploy to Firebase ( using this for ease for now )

# TOGGLE environment:
# PROD
FB_PROD_PROJ_ID=winwisely-app-prod

# DEV
FB_DEV_PROJ_ID=winwisely-app-dev

# User ( the developer)
FB_USER_PROJ_ID=winwisely99-main-master

# Set the final variables used here !
FB_SESSION_PROJECT_ID=$(FB_USER_PROJ_ID)

FB_SESSION_PROJECT_CONSOLE_URL=https://console.firebase.google.com/project/$(FB_SESSION_PROJECT_ID)/hosting/main
FB_SESSION_PROJECT_WEB_URL=https://$(FB_SESSION_PROJECT_ID).firebaseapp.com/
GCLOUD_SESSION_PROJECT_CONSOLE_URL=https://console.cloud.google.com/home/dashboard?project=$(FB_SESSION_PROJECT_ID)

GIT_HASH=$(shell git log -1 --pretty=format:"%H")

fb-print: ## fb-print
	@echo
	@echo FB_SESSION_PROJECT_ID: $(FB_SESSION_PROJECT_ID)

	@echo GIT_HASH=$(GIT_HASH)

	@echo FB_SESSION_PROJECT_CONSOLE_URL: $(FB_SESSION_PROJECT_CONSOLE_URL)
	@echo FB_SESSION_PROJECT_WEB_URL: $(FB_SESSION_PROJECT_WEB_URL)
	@echo GCLOUD_SESSION_PROJECT_CONSOLE_URL: $(GCLOUD_SESSION_PROJECT_CONSOLE_URL)
	@echo

fb-auth:
	
	# firebase logout
	firebase logout

	# firebase login and pick which account to use via which browser you hit.
	firebase login --no-localhost

	# see what projects you have setup
	firebase projects:list

fb-init:
	# This is a one time thing for a project

	#firebase init 
	firebase init

fb-console:
	# opens the web console.
	open $(FB_SESSION_PROJECT_CONSOLE_URL)

fb-test:
	@echo $(LIB_FSPATH)/client/build/web

fb-serve: ## fb-serve
	# runs locally

	# rebuilds flutter web
	$(MAKE) flu-web-build

	# copy code from web build folder to public folder
	rm -R ./public
	cp -R $(LIB_FSPATH)/client/build/web ./public

	firebase serve --only hosting

fb-deploy: ## fb-deploy
	# rebuilds flutter web
	$(MAKE) flu-web-build

	# copy code from web build folder to public folder
	rm -R ./public
	cp -R $(LIB_FSPATH)/client/build/web ./public

	firebase deploy --only hosting -m "githash: $(GIT_HASH)"

fb-ci-get:
	# gets secure keys used for CI automation
	firebase login:ci
	# PROJ: winwisely99-main-master
	# record the secret

fb-ci-revoke:
	# revokes secure keys used for CI automation
	firebase logout --token <token>

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
	
	







