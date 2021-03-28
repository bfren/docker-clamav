FROM bcgdesign/alpine-s6:alpine3.13-2.0.5

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="ClamAV" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

EXPOSE 3310

ENV \
    # the number of times per day freshclam will run to update definitions
    CLAMAV_FRESH_PER_DAY=12

COPY ./overlay /
COPY ./CLAMAV_BUILD /tmp/VERSION

RUN bcg-install
