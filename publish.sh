#!/usr/bin/env bash

set -Eeuxo pipefail

docker login -u "$REGISTRY_USER" -p "$REGISTRY_KEY" "$CONTAINER_REGISTRY"
NEW_IMAGE="$CONTAINER_REGISTRY/$PID/kube-scheduler:$CONTAINER_TAG"
docker tag storageos/kube-scheduler:latest "$NEW_IMAGE"
docker push "$NEW_IMAGE"
