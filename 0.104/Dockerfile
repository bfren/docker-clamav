FROM bfren/alpine-s6:alpine3.15-4.2.12

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-clamav"

ARG BF_IMAGE
ARG BF_VERSION
ARG BF_PUBLISH

EXPOSE 3310

ENV \
    # the number of times per day freshclam will run to update definitions
    CLAMAV_FRESH_PER_DAY=12

COPY ./overlay /
COPY ./0.104/overlay /

RUN bf-install
