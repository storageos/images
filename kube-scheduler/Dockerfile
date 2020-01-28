FROM golang:1.13.5 AS build
ENV K8S_REPO_VERSION=v1.17.0
ENV K8S_COMPONENT_NAME=kube-scheduler
WORKDIR /go/src/github.com/storageos/images/kube-scheduler
COPY LICENSE .
RUN apt-get update && apt-get install rsync -y
RUN git clone --branch $K8S_REPO_VERSION https://github.com/kubernetes/kubernetes $GOPATH/src/k8s.io/kubernetes --depth=1
RUN cd "$GOPATH/src/k8s.io/kubernetes" && make WHAT=cmd/$K8S_COMPONENT_NAME GOFLAGS=-v

FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL name="kube-scheduler" \
    maintainer="support@storageos.com" \
    vendor="StorageOS" \
    version="v1.17.0" \
    release="1" \
    distribution-scope="public" \
    architecture="x86_64" \
    url="https://docs.storageos.com" \
    io.k8s.description="kube-scheduler is the default scheduler for Kubernetes." \
    io.k8s.display-name="kube-scheduler" \
    io.openshift.tags="" \
    summary="The Kubernetes Scheduler determines workload placement." \
    description="This container is not intended to be run manually. Instead, use the StorageOS Cluster Operator to install and manage StorageOS."
RUN mkdir -p /licenses
COPY --from=build /go/src/k8s.io/kubernetes/_output/bin/kube-scheduler /usr/local/bin/kube-scheduler
COPY --from=build /go/src/github.com/storageos/images/kube-scheduler/LICENSE /licenses/
CMD ["/bin/sh", "-c"]
