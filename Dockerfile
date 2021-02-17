FROM bcgdesign/alpine-s6:alpine-3.13-1.5.0

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
COPY ./CLAMAV_BUILD /tmp/CLAMAV_VERSION

RUN bcg-install

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=5 CMD [ "healthcheck" ]
