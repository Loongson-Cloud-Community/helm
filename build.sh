#!/usr/bin/bash

set -ex

### check
export DIST_DIRS=linux_loong64
export VERSION=v3.3.1

### build
mkdir -p _dist/linux_loong64
export LDFLAGS="-w -s -X helm.sh/helm/v3/internal/version.version=v3.3.1 -X helm.sh/helm/v3/internal/version.metadata= -X helm.sh/helm/v3/internal/version.gitCommit=249e5215cde0c3fa72e27eb7a30e8d55c9696144 -X helm.sh/helm/v3/internal/version.gitTreeState=dirty"
CGO_ENABLED=0 GO111MODULE=on go build  -tags '' -ldflags "$LDFLAGS" -o _dist/linux_loong64/helm ./cmd/helm
### 制品目录
cd _dist 
cp ../LICENSE $DIST_DIRS
cp ../README.md $DIST_DIRS
tar -zcf helm-$VERSION-$DIST_DIRS.tar.gz $DIST_DIRS
zip -r helm-$VERSION-$DIST_DIRS.zip $DIST_DIRS
