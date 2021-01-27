FROM alpine:3.13.0
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="tftp-hpa server on alpine linux"

# add tftp-hpa
RUN apk add --no-cache tftp-hpa

# tftp-hpa environment variables
# (see: https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html)
ENV ADDRESS="" \
    BLOCKSIZE="" \
    CREATE=0 \
    FOREGROUND=1 \
    IPV4=0 \
    IPV6=0 \
    LISTEN=0 \
    MAPFILE=/srv/mapfile \
    PERMISSIVE=0 \
    PIDFILE="" \
    PORTRANGE="4096:32767" \
    REFUSE="" \
    RETRANSMIT="" \
    SECURE=1 \
    TFTPROOT=/srv/tftp \
    TIMEOUT="" \
    UMASK="" \
    USER=tftp \
    VERBOSE=1 \
    VERBOSITY=""

# add mapfile
COPY mapfile $MAPFILE

EXPOSE 69/udp
VOLUME $TFTPROOT

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD getent services tftp || exit 1
