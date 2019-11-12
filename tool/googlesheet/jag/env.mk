# https://github.com/jaegertracing/jaeger
LIB_NAME=jaeger
LIB=github.com/jaegertracing/$(LIB_NAME)
LIB_BRANCH=master
LIB_TAG=v1.15.1
LIB_FSPATH=$(GOPATH)/src/$(LIB)

GO111MODULE=on

SAMPLE_NAME=examples/hotrod
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)

CLOUD_PROJECT_ID=winwisely-cloudrun-hotrod
CLOUD_PROJECT_URL=????

