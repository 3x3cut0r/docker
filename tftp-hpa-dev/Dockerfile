FROM 3x3cut0r/alpine:3.13.0
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="TFTP-HPA Server on Alpine Linux"

# add app
RUN apk add --no-cache tftp-hpa

# set UID/GID for tftp
ENV UID=9069 \
    GID=9069

# add user tftp
RUN addgroup -g $GID -S tftp && \
    adduser --disabled-password --gecos "" --shell /sbin/nologin \
            --home /home/tftp --no-create-home --ingroup tftp \
            --uid $UID tftp

# app environment parameters
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
    PORTRANGE="" \
    REFUSE="" \
    RETRANSMIT="" \
    SECURE=1 \
    TFTPROOT=/srv/tftp \
    TIMEOUT=900 \
    UMASK="" \
    USER=tftp \
    VERBOSE=1 \
    VERBOSITY=""

COPY mapfile $MAPFILE
VOLUME $MAPFILE

EXPOSE 69/udp
VOLUME $TFTPROOT

# add entrypoint
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD getent services tftp || exit 1
