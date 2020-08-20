FROM golang:1.13.5 AS build
ENV GIT_UPSTREAM_REPO=https://github.com/kubernetes-csi/external-resizer
ENV GIT_VERSION=v0.5.0
# Red Hat build service was not auto-creating WORKDIR, create it.
RUN mkdir -p /go/src/github.com/storageos/images/csi-resizer
WORKDIR /go/src/github.com/storageos/images/csi-resizer

# Clone upstream with full history and checkout to the forked branch to retain
# correct version tag used in the build flag.
RUN git clone $GIT_UPSTREAM_REPO $GOPATH/src/github.com/kubernetes-csi/external-resizer
RUN cd "$GOPATH/src/github.com/kubernetes-csi/external-resizer" \
    && git checkout $GIT_VERSION \
    # && bash /build.sh -x
    # The default make target builds linux and windows binaries together. Use
    # make when the build server has enough resources.
    && make

FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL name="csi-resizer" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v0.5.0" \
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
