## kube-scheduler release branch

This branch is for automated release of kube-scheduler container images only.
To publish a new image, ensure that the `CONTAINER_TAG` in `.travis.yaml` is
set correctly and create a git tag from this branch, `kube-scheduler`. The git
tag name is not considered in the image tag. It is used for triggering release
builds in the CI only. Changes to the branch only builds the container image,
no image is published.

Any change related to kube-scheduler build, including k8s version upgrade,
should be done in the [Dockerfile](kube-scheduler/Dockerfile).

The secured environment variables specific to kube-scheduler and the container
registry are stored in `.travis.yml` encrypted. The file `key.enc` contains the
registry key. Since the key is too long, travis cli fails to encrypt it. Travis
[`encrypt-file`](https://docs.travis-ci.com/user/encrypting-files/) is used to
encrypt the key in `key.enc`. Any other branch that publishes a different image
should encrypt new key that's specific to the image.

### Environment variables:

| Variable Name | Description |
| ------------- | ----------- |
| `CONTAINER_REGISTRY` | Address of the container registry. |
| `REGISTRY_USER` | Login user name for the container registry. |
| `REGISTRY_KEY` | Login token for the container registry. |
| `PID` | ID of the container image repo in the registry. |
| `CONTAINER_TAG` | Tag of the container image to be published. |
