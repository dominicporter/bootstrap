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



# protoc
scoop install protobuf


# glfw
# Do we need it ?

# gcc
# needed for golang CGO etc.
brew install gcc

# dart
# I dont think its needed actually... we see.
#scoop install dart-dev

# flutter
# NOT needed. hover does it.

# see: https://github.com/flutter/flutter/issues/14050

# using this one: https://github.com/socheatsok78/homebrew-flutter
# currently NOT working due to Mac Calolina security lockdown.. 
#brew cask install socheatsok78/flutter/flutter

# https://github.com/leoafarias/fvm
pub global activate fvm


# flutter IOS stuff
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy cocoapods
pod setup

# sometimes needed
# brew upgrade cocoapods

# flutter android stuff
brew cask install adoptopenjdk
brew cask install android-studio