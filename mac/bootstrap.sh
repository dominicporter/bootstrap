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
scoop install gcc

# dart
# I dont think its needed actually... we see.
#scoop install dart-dev

# flutter
# NOT needed. hover does it.
scoop install flutter

# flutter IOS stuff
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy cocoapods
pod setup

# flutter android stuff
brew cask install adoptopenjdk
brew cask install android-studio