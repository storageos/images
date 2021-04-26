FROM golang:1.15.11 AS build
ENV GIT_UPSTREAM_REPO=https://github.com/kubernetes-csi/external-provisioner
ENV GIT_FORK_REPO=https://github.com/storageos/external-provisioner
ENV GIT_BRANCH=v2.1.1-patched

# WORKDIR is not getting created on RH build service, create it manually.
RUN mkdir -p "$GOPATH/src/github.com/kubernetes-csi/external-provisioner"

# Clone upstream with full history and checkout to the forked branch to retain
# correct version tag used in the build flag.
RUN git clone $GIT_UPSTREAM_REPO $GOPATH/src/github.com/kubernetes-csi/external-provisioner
RUN cd "$GOPATH/src/github.com/kubernetes-csi/external-provisioner" \
    && git remote add fork $GIT_FORK_REPO \
    && git fetch fork \
    && git checkout -t fork/$GIT_BRANCH \
    && make

FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL name="csi-provisioner" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v2.1.1-patched" \
    release="1" \
    distribution-scope="public" \
    architecture="x86_64" \
    url="https://docs.storageos.com" \
    io.k8s.description="csi-provisioner is the kubernetes CSI external-provisioner." \
    io.k8s.display-name="csi-provisioner" \
    io.openshift.tags="" \
    summary="The Kubernetes CSI External Provisioner is part of CSI deployments responsible for provisioning volumes." \
    description="This container is not intended to be run manually. Instead, use the StorageOS Cluster Operator to install and manage StorageOS."
RUN mkdir -p /licenses
COPY --from=build /go/src/github.com/kubernetes-csi/external-provisioner/bin/csi-provisioner /csi-provisioner
COPY --from=build /go/src/github.com/kubernetes-csi/external-provisioner/LICENSE /licenses/
ENTRYPOINT ["/csi-provisioner"]
