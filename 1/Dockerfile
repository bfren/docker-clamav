FROM bfren/alpine-s6:alpine3.18-5.0.0-dev

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-clamav"

ARG BF_IMAGE
ARG BF_VERSION
ARG BF_PUBLISH

EXPOSE 3310

ENV \
    # the number of times per day freshclam will run to update definitions
    BF_CLAMAV_FRESH_PER_DAY=12

COPY ./overlay /
COPY ./1/overlay /

RUN bf-install
