FROM golang:1.15.11 AS build
ENV GIT_UPSTREAM_REPO=https://github.com/kubernetes-csi/node-driver-registrar
ENV GIT_VERSION=v2.1.0

# WORKDIR is not getting created on RH build service, create it manually.
RUN mkdir -p "$GOPATH/src/github.com/kubernetes-csi/node-driver-registrar"

# Clone upstream with full history and checkout to the forked branch to retain
# correct version tag used in the build flag.
RUN git clone $GIT_UPSTREAM_REPO $GOPATH/src/github.com/kubernetes-csi/node-driver-registrar
RUN cd "$GOPATH/src/github.com/kubernetes-csi/node-driver-registrar" \
    && git checkout $GIT_VERSION \
    && make

FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL name="csi-node-driver-registrar" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v2.1.0" \
    release="1" \
    distribution-scope="public" \
    architecture="x86_64" \
    url="https://docs.storageos.com" \
    io.k8s.description="csi-node-driver-registrar registers the CSI driver with kubelet." \
    io.k8s.display-name="csi-node-driver-registrar" \
    io.openshift.tags="" \
    summary="The CSI Node Driver Registrar registers the CSI driver with the Kubernetes node." \
    description="This container is not intended to be run manually. Instead, use the StorageOS Cluster Operator to install and manage StorageOS."
RUN mkdir -p /licenses
COPY --from=build /go/src/github.com/kubernetes-csi/node-driver-registrar/bin/csi-node-driver-registrar /csi-node-driver-registrar
COPY --from=build /go/src/github.com/kubernetes-csi/node-driver-registrar/LICENSE /licenses/
ENTRYPOINT ["/csi-node-driver-registrar"]
