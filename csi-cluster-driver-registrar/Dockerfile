FROM golang:1.13.5 AS build
ENV GIT_UPSTREAM_REPO=https://github.com/kubernetes-csi/cluster-driver-registrar
ENV GIT_VERSION=v1.0.1
WORKDIR /go/src/github.com/storageos/images/csi-cluster-driver-registrar
COPY LICENSE .

# Clone upstream with full history and checkout to the forked branch to retain
# correct version tag used in the build flag.
RUN git clone $GIT_UPSTREAM_REPO $GOPATH/src/github.com/kubernetes-csi/cluster-driver-registrar
RUN cd "$GOPATH/src/github.com/kubernetes-csi/cluster-driver-registrar" \
    && git checkout $GIT_VERSION \
    && make

FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL name="csi-cluster-driver-registrar" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v1.0.1" \
    release="1" \
    distribution-scope="public" \
    architecture="x86_64" \
    url="https://docs.storageos.com" \
    io.k8s.description="csi-cluster-driver-registrar registers the CSI driver with the Kubernetes cluster." \
    io.k8s.display-name="csi-cluster-driver-registrar" \
    io.openshift.tags="" \
    summary="The CSI Cluster Driver Registrar registers the CSI driver with the Kubernetes cluster." \
    description="This container is not intended to be run manually. Instead, use the StorageOS Cluster Operator to install and manage StorageOS."
RUN mkdir -p /licenses
COPY --from=build /go/src/github.com/kubernetes-csi/cluster-driver-registrar/bin/cluster-driver-registrar /csi-cluster-driver-registrar
COPY --from=build /go/src/github.com/storageos/images/csi-cluster-driver-registrar/LICENSE /licenses/
ENTRYPOINT ["/csi-cluster-driver-registrar"]
