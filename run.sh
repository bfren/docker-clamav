#!/bin/sh

IMAGE=`cat VERSION`
CLAMAV=${1:-0.104}

docker buildx build \
    --build-arg BF_IMAGE=clamav \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${CLAMAV}/Dockerfile \
    -t clamav${CLAMAV}-dev \
    . \
    && \
    docker run -it clamav${CLAMAV}-dev sh
