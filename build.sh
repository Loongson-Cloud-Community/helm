#!/usr/bin/bash

set -ex

### check
export DIST_DIRS=linux_loong64
export VERSION=v2.16.10

### build
mkdir -p _dist/linux_loong64
export LDFLAGS="-w -s -X k8s.io/helm/pkg/version.Version=v2.16.10 -X k8s.io/helm/pkg/version.BuildMetadata= -X k8s.io/helm/pkg/version.GitCommit=bceca24a91639f045f22ab0f41e47589a932cf5e -X k8s.io/helm/pkg/version.GitTreeState=dirty -extldflags -static"
GOOS=linux GOARCH=loong64 CGO_ENABLED=0 GO111MODULE=auto go build -o _dist/linux_loong64/helm -a -installsuffix cgo -tags '' -ldflags "$LDFLAGS" ./cmd/helm
GOOS=linux GOARCH=loong64 CGO_ENABLED=0 GO111MODULE=auto go build -o _dist/linux_loong64/tiller -a -installsuffix cgo -tags '' -ldflags "$LDFLAGS" ./cmd/tiller
### 制品目录
cd _dist 
cp ../LICENSE $DIST_DIRS
cp ../README.md $DIST_DIRS
tar -zcf helm-$VERSION-$DIST_DIRS.tar.gz $DIST_DIRS
zip -r helm-$VERSION-$DIST_DIRS.zip $DIST_DIRS
