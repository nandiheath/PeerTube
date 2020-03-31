#!/bin/bash

if [ "$TRAVIS_PULL_REQUEST" = "true" ] || [ "$TRAVIS_BRANCH" != "tvhk-dev" ]; then
  docker buildx build \
    --progress plain \
    --platform=linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le,linux/s390x \
    .
  exit $?
fi
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin &> /dev/null
docker buildx build \
     --progress plain \
    --platform=linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le,linux/s390x \
    -t nandiheath/tvhk-peertube:$TRAVIS_COMMIT \
    --build-arg NPM_RUN_BUILD_OPTS=$NPM_RUN_BUILD_OPTS \
    --push \
    .
