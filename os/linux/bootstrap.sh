# upgrade
apt-get upgrade

# curl
apt-get install curl

# unzip
apt-get install unzip

# git
apt-get install git

# openssh
apt-get install openssh-server

# go
GOLANG_FILE=go1.13.4.linux-amd64.tar.gz
curl https://dl.google.com/go/${GOLANG_FILE} -o ${GOLANG_FILE}
tar -C /usr/local/ -xzf ${GOLANG_FILE}
rm -f ${GOLANG_FILE}

# protoc
PROTOC_VERSION=3.10.1
curl https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip -L -o protoc-${PROTOC_VERSION}-linux-x86_64.zip
unzip -o protoc-${PROTOC_VERSION}-linux-x86_64.zip -d $GOPATH
rm -f ${PROTOC_FILE}

# gcc
apt-get install gcc

# flutter
# needs a fw other things first
apt-get install openjdk-8-jdk
snap install android-studio

# Flutter github
git clone -b master https://github.com/flutter/flutter.git
./flutter/bin/flutter --version
