#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="4.5.0"
echo "Base: ${BASE_REVISION}"

CLAMAV_VERSIONS="0.103 0.104 0.105 1"
for V in ${CLAMAV_VERSIONS} ; do

    echo "ClamAV ${V}"
    ALPINE_MINOR=`cat ./${V}/ALPINE_MINOR`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        ALPINE_MINOR=${ALPINE_MINOR} \
        CLAMAV_MINOR=${V}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile

done

docker system prune -f
echo "Done."
