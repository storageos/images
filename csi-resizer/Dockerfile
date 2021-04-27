FROM golang:1.15.11 AS build
ENV GIT_UPSTREAM_REPO=https://github.com/kubernetes-csi/external-resizer
ENV GIT_VERSION=v1.1.0

# WORKDIR is not getting created on RH build service, create it manually.
RUN mkdir -p "$GOPATH/src/github.com/kubernetes-csi/external-resizer"

# Clone upstream with full history and checkout to the forked branch to retain
# correct version tag used in the build flag.
RUN git clone $GIT_UPSTREAM_REPO $GOPATH/src/github.com/kubernetes-csi/external-resizer
RUN cd "$GOPATH/src/github.com/kubernetes-csi/external-resizer" \
    && git checkout $GIT_VERSION \
    && make

FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL name="csi-resizer" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v1.1.0" \
    release="1" \
    distribution-scope="public" \
    architecture="x86_64" \
    url="https://docs.storageos.com" \
    io.k8s.description="csi-resizer handles volume expansion operations." \
    io.k8s.display-name="csi-resizer" \
    io.openshift.tags="" \
    summary="The CSI Resizer watches the Kubernetes API for volume expansion requests." \
    description="This container is not intended to be run manually. Instead, use the StorageOS Cluster Operator to install and manage StorageOS."
RUN mkdir -p /licenses
COPY --from=build /go/src/github.com/kubernetes-csi/external-resizer/bin/csi-resizer /csi-resizer
COPY --from=build /go/src/github.com/kubernetes-csi/external-resizer/LICENSE /licenses/
ENTRYPOINT ["/csi-resizer"]
