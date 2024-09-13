FROM ghcr.io/bfren/alpine-s6:alpine3.17-5.4.9

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-clamav"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /
COPY ./0.105/overlay /

EXPOSE 3310

ENV \
    # the number of times per day freshclam will run to update definitions
    BF_CLAMAV_FRESH_PER_DAY=12

RUN bf-install
