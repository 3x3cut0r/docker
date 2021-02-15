FROM alpine:3.13.1
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="tftp-hpa server on alpine linux"

# set UID/GID for tftp
ENV UID=9069 \
    GID=9069

# add user tftp
RUN addgroup -g $GID -S tftp && \
    adduser --disabled-password --gecos "" --shell /sbin/nologin \
            --home /home/tftp --no-create-home --ingroup tftp \
            --uid $UID tftp

# add tftp-hpa
RUN apk add --no-cache tftp-hpa libcap && \
    setcap 'cap_net_bind_service=+ep' /usr/sbin/in.tftpd

# tftp-hpa environment variables
# (see: https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html)
ENV BLOCKSIZE="" \
    CREATE=0 \
    MAPFILE=/mapfile \
    PERMISSIVE=0 \
    PORTRANGE="4096:32767" \
    REFUSE="" \
    RETRANSMIT="" \
    SECURE=1 \
    TIMEOUT="" \
    UMASK="" \
    VERBOSE=1 \
    VERBOSITY=3

VOLUME /tftpboot
EXPOSE 69/udp

# add mapfile
COPY mapfile $MAPFILE

# set permissions for TFTPROOT & MAPFILE
RUN mkdir -p /tftpboot && \
    chown -R "${UID}":"${GID}" /tftpboot && \
    chmod -R 0777 /tftpboot && \
    chown "${UID}":"${GID}" "${MAPFILE}" && \
    chmod 0400 "${MAPFILE}"

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

USER tftp
ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD getent services tftp || exit 1
