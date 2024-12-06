#!/bin/sh

IMAGE=clamav
VERSION=`cat VERSION`
CLAMAV=${1:-1.4}
TAG=${IMAGE}-test

docker buildx build \
    --load \
    --build-arg BF_IMAGE=${IMAGE} \
    --build-arg BF_VERSION=${VERSION} \
    -f ${CLAMAV}/Dockerfile \
    -t ${TAG} \
    . \
    && \
    docker run --entrypoint /test ${TAG}
