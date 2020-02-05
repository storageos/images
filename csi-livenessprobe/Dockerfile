FROM golang:1.13.5 AS build
ENV GIT_UPSTREAM_REPO=https://github.com/kubernetes-csi/livenessprobe
ENV GIT_TAG=v1.1.0
WORKDIR /go/src/github.com/storageos/images/csi-livenessprobe
COPY LICENSE .
# Clone upstream and build from target tag directly. 
RUN git clone $GIT_UPSTREAM_REPO $GOPATH/src/github.com/kubernetes-csi/livenessprobe
RUN cd "$GOPATH/src/github.com/kubernetes-csi/livenessprobe" \
    && git checkout $GIT_TAG \
    && make

FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL name="csi-livenessprobe" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v1.1.0" \
    release="1" \
    distribution-scope="public" \
    architecture="x86_64" \
    url="https://docs.storageos.com" \
    io.k8s.description="csi-livenessprobe is the kubernetes CSI livenessprobe." \
    io.k8s.display-name="csi-livenessprobe" \
    io.openshift.tags="" \
    summary="The Kubernetes CSI Liveness is part of CSI deployments responsible for checking the health of the CSI driver." \
    description="This container is not intended to be run manually. Instead, use the StorageOS Cluster Operator to install and manage StorageOS."
RUN mkdir -p /licenses
COPY --from=build /go/src/github.com/kubernetes-csi/livenessprobe/bin/livenessprobe /livenessprobe
COPY --from=build /go/src/github.com/storageos/images/csi-livenessprobe/LICENSE /licenses/
ENTRYPOINT ["/livenessprobe"]
