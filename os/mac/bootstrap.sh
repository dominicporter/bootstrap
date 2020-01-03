# Stuff i need

# RUN THIS in termianl
# Install brew 
# https://brew.sh/
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew upgrade

# git
brew install git
# which
# is already on mac / linux

# openssh
# already installed on mac / linux.

# vscode
# https://www.code2bits.com/how-to-install-visual-studio-code-on-macos-using-homebrew/
brew cask install visual-studio-code
# MAY need to do this:
# tell vscode where git is:
# which git
# then File > Preferences > Settings, and under User Settings add: "git.path”: “c:\\the\\path\\to\\git”
# restart and then do: code .

# go
brew install go
# THEN in your bash profile put:
# export GO111MODULE=on
# export GOROOT=/usr/local/opt/go/libexec
# export GOPATH=$HOME/workspace/go
# export PATH=$PATH:$GOROOT/bin
# export PATH=$PATH:$GOPATH/bin




# protoc
scoop install protobuf


# glfw
# Do we need it ?

# gcc
# needed for golang CGO etc.
brew install gcc


# flutter IOS stuff
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy cocoapods
pod setup

# sometimes needed
# brew upgrade cocoapods

# flutter
# needs a fw other things first
brew cask install adoptopenjdk
brew cask install android-studio

# flutter
# best to install via git clone
mkdir $(HOME)/workspace
cd $(HOME)/workspace && git clone -b master https://github.com/flutter/flutter.git
./flutter/bin/flutter --version



