#!/bin/bash
# check Dockerfile supported architecture https://hub.docker.com/_/node/?tab=tags&page=1&name=latest
# https://medium.com/@quentin.mcgaw/cross-architecture-docker-builds-with-travis-ci-arm-s390x-etc-8f754e20aaef
if [ "$TRAVIS_PULL_REQUEST" = "true" ] || [ "$TRAVIS_BRANCH" != "tvhk-dev" ]; then
  docker buildx build \
    --progress plain \
    --platform=linux/amd64,linux/arm64,linux/arm/v7 \ 
    .
  exit $?
fi

# ,linux/ppc64le,linux/s390x -> some libraries not avaliable on pcc64le
    

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin &> /dev/null
docker buildx build \
     --progress plain \
    --platform=linux/amd64,linux/arm64,linux/arm/v7 \
    -t nandiheath/tvhk-peertube:$TRAVIS_COMMIT \
    --build-arg NPM_RUN_BUILD_OPTS=$NPM_RUN_BUILD_OPTS \
    --push \
    .
