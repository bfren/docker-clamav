FROM bfren/alpine-s6:alpine3.18-5.1.0

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-clamav"

ARG BF_IMAGE
ARG BF_VERSION
ARG BF_PUBLISH

COPY ./overlay /
COPY ./1.1/overlay /

EXPOSE 3310

ENV \
    # the number of times per day freshclam will run to update definitions
    BF_CLAMAV_FRESH_PER_DAY=12

RUN bf-install
