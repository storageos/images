FROM golang:1.13.5 AS build
ENV GIT_UPSTREAM_REPO=https://github.com/kubernetes-csi/external-attacher
ENV GIT_TAG=v3.1.0
WORKDIR /go/src/github.com/storageos/images/external-attacher

# Clone upstream and build from target tag directly.
RUN git clone $GIT_UPSTREAM_REPO $GOPATH/src/github.com/kubernetes-csi/external-attacher
RUN cd "$GOPATH/src/github.com/kubernetes-csi/external-attacher" \
    && git checkout $GIT_TAG \
    && make

FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL name="csi-attacher" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v3.1.0" \
    release="1" \
    distribution-scope="public" \
    architecture="x86_64" \
    url="https://docs.storageos.com" \
    io.k8s.description="csi-attacher is the kubernetes CSI external-attacher." \
    io.k8s.display-name="csi-attacher" \
    io.openshift.tags="" \
    summary="The Kubernetes CSI External Attacher is part of CSI deployments responsible for attaching volumes to workloads." \
    description="This container is not intended to be run manually. Instead, use the StorageOS Cluster Operator to install and manage StorageOS."
RUN mkdir -p /licenses
COPY --from=build /go/src/github.com/kubernetes-csi/external-attacher/bin/csi-attacher /csi-attacher
COPY --from=build /go/src/github.com/kubernetes-csi/external-attacher/LICENSE /licenses/
ENTRYPOINT ["/csi-attacher"]
