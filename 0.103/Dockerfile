FROM bfren/alpine-s6:alpine3.14-4.0.0-beta

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 3310

ENV \
    # the number of times per day freshclam will run to update definitions
    CLAMAV_FRESH_PER_DAY=12

COPY ./overlay /
COPY ./0.103/CLAMAV_BUILD /tmp/

RUN bf-install
