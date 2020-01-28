#!/usr/bin/env bash

# Use separate build script to avoid building windows binary. Builds fail on CIs
# with limited resources. The default make targets have linux and windows build
# commands coupled.

set -Eeuxo pipefail

REV=$(git describe --long --tags --match='v*' --dirty 2>/dev/null || git rev-list -n1 HEAD)
mkdir -p bin
LDFLAGS="-X main.version=${REV} -extldflags \"-static\""
CGO_ENABLED=0 GOOS=linux go build -v -a -ldflags "${LDFLAGS}" -o ./bin/csi-provisioner ./cmd/csi-provisioner
