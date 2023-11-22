#!/bin/sh

IMAGE=`cat VERSION`
CLAMAV=${1:-1}

docker buildx build \
    --load \
    --progress plain \
    --build-arg BF_IMAGE=clamav \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${CLAMAV}/Dockerfile \
    -t clamav${CLAMAV}-dev \
    . \
    && \
    docker run -it -e BF_DEBUG=1 clamav${CLAMAV}-dev sh
