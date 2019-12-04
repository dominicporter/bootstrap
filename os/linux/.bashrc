# bashrc or bash_profile

### GoLang ###
# Installed using: "sudo apt-get install go""

export GO111MODULE=on
export GOROOT=/usr/local/go
export GOPATH=$HOME/go

export PATH=$PATH:$GOROOT/bin

# needed for GOMOBILE
export PATH=$PATH:$GOPATH/bin

# Flutter
export FLUTTER_PATH=$HOME/flutter/bin
export PATH=$PATH:$FLUTTER_PATH

# Dart Protobuf
export PATH=$PATH:$HOME/.pub-cache/bin

# Java
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export PATH=$PATH:$JAVA_HOME/bin

### Android Studio & SDK & NDK ###
# ``` snap install android-studio ```

export ANDROID_SDK=$HOME/Library/Android/sdk

# gomobile needs this. see: (https://github.com/golang/mobile/blob/master/cmd/gomobile/doc.go#L57)
export ANDROID_HOME=$ANDROID_SDK

# other standard stuff
export ANDROID_NDK=$ANDROID_SDK/ndk-bundle

# gomobile needs this. gomobile install calls adb, and so the Platform Tools need to be on the path
export ANDROID_PLATFORM_TOOLS=$ANDROID_SDK/platform-tools

export ANDROID_TOOLS=$ANDROID_SDK/tools
