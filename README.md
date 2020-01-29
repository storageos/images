## kube-scheduler release branch

This branch is for automated release of kube-scheduler container images only.
To create a new release, ensure that the `CONTAINER_TAG` in .travis.yaml is the
tag for the new release and create a git tag from this branch, `kube-scheduler`.
Git tags trigger a release build in the CI. Changes to the branch only builds
the container image.

Any change related to kube-scheduler build, including k8s version upgrade,
should be done in the [Dockerfile](kube-scheduler/Dockerfile).
