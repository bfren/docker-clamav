FROM bcgdesign/alpine-s6:1.0.3

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="ClamAV" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

EXPOSE 3310

COPY ./VERSION /tmp/VERSION
RUN export CLAMAV_VERSION=$(cat /tmp/VERSION) \
    && echo "ClamAV v${CLAMAV_VERSION}" \
    && apk update \
    && apk upgrade \
    && apk add \
        clamav=${CLAMAV_VERSION} \
        clamav-libunrar=${CLAMAV_VERSION} \
        wget \
    && rm -rf /var/cache/apk/*

COPY ./overlay /

RUN chmod +x /usr/bin/healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=5 CMD [ "/usr/bin/healthcheck" ]
