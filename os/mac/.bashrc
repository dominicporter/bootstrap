# bashrc or bash_profile


# Change this if you use a different username on your Mac.
USER=apple
echo "Environment:"
echoLog "USER" $USER


### HomeBrew ###
HOMEBREW_INSTALL=/usr/local
export PATH="/usr/local/sbin:$PATH"


### GoLang ###
# Installed using: "brew install go""

export GO111MODULE=on
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/workspace/go

export PATH=$PATH:$GOROOT/bin
# needed for GOMOBILE
export PATH=$PATH:$GOPATH/bin

echoLog "GOROOT (exported)" $GOROOT 



#### Flutter  ###
export FLUTTER_ROOT=$HOME/fvm/master


# Dart Protobuf
export PATH=$PATH:$HOME/.pub-cache/bin

### Java
# ``` brew cask install adoptopenjdk ```
# https://github.com/AdoptOpenJDK/homebrew-openjdk
# It puts Java in a different place.
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-12.0.2.jdk/Contents/Home"
export PATH=$PATH:$JAVA_HOME/bin


### Android Studio & SDK & NDK ###
# ``` brew cask install android-studio ```

export ANDROID_SDK=$HOME/Library/Android/sdk

# gomobile needs this. see: (https://github.com/golang/mobile/blob/master/cmd/gomobile/doc.go#L57)
export ANDROID_HOME=$ANDROID_SDK 


# other standard stuff
export ANDROID_NDK=$ANDROID_SDK/ndk-bundle

# gomobile needs this. gomobile install calls adb, and so the Platform Tools need to be on the path 
export ANDROID_PLATFORM_TOOLS=$ANDROID_SDK/platform-tools

export ANDROID_TOOLS=$ANDROID_SDK/tools
















