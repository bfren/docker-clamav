FROM bfren/alpine-s6:alpine3.15-4.0.4

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 3310

ENV \
    # the number of times per day freshclam will run to update definitions
    CLAMAV_FRESH_PER_DAY=12

COPY ./overlay /
COPY ./0.104/CLAMAV_BUILD /tmp/

RUN bf-install
