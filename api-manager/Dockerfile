FROM golang:1.15.2 AS build
ENV GIT_UPSTREAM_REPO=https://github.com/storageos/api-manager
ENV GIT_VERSION=v0.1.0
WORKDIR /workspace

# Clone upstream with full history and checkout to the forked branch to retain
# correct version tag used in the build flag.
RUN git clone $GIT_UPSTREAM_REPO /workspace
RUN cd /workspace \
    && git checkout $GIT_VERSION
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
RUN go mod download
# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o manager main.go

FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /
LABEL name="api-manager" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v0.1.0" \
    release="1" \
    distribution-scope="public" \
    architecture="x86_64" \
    url="https://docs.storageos.com" \
    io.k8s.description="api-manager handles interactions between different apis." \
    io.k8s.display-name="api-manager" \
    io.openshift.tags="" \
    summary="The StorageOS API Manager acts as a middle-man between various APIs." \
    description="This container is not intended to be run manually. Instead, use the StorageOS Cluster Operator to install and manage StorageOS."
RUN mkdir -p /licenses
COPY --from=build /workspace/manager .
COPY --from=build /workspace/LICENSE /licenses/
ENTRYPOINT ["/manager"]
