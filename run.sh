#!/bin/sh

IMAGE=`cat VERSION`
CLAMAV=${1:-1}

docker buildx build \
    --load \
    --build-arg BF_IMAGE=clamav \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${CLAMAV}/Dockerfile \
    -t clamav${CLAMAV}-dev \
    . \
    && \
    docker run -it clamav${CLAMAV}-dev sh
