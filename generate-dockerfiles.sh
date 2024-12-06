#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_VERSION="5.5.0"
echo "Base: ${BASE_VERSION}"

CLAMAV_VERSIONS="0.104 0.105 1.1 1.2 1.4"
for V in ${CLAMAV_VERSIONS} ; do

    echo "ClamAV ${V}"
    ALPINE_EDITION=`cat ./${V}/ALPINE_MINOR`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_VERSION=${BASE_VERSION} \
        ALPINE_EDITION=${ALPINE_EDITION} \
        CLAMAV_VERSION=${V}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile

done

docker system prune -f
echo "Done."
