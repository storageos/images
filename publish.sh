#!/usr/bin/env bash

set -e

source key
echo "$REGISTRY_KEY" | docker login -u "$REGISTRY_USER" --password-stdin "$CONTAINER_REGISTRY"
NEW_IMAGE="$CONTAINER_REGISTRY/$PID/kube-scheduler:$CONTAINER_TAG"
docker tag storageos/kube-scheduler:latest "$NEW_IMAGE"
docker push "$NEW_IMAGE"
