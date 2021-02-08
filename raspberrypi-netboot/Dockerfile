FROM alpine:3.13.1
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="RaspberryPi netboot"

# set UID/GID for pi
ENV UID=9999 \
    GID=9999

# add user pi
RUN addgroup -g $GID -S pi && \
    adduser --disabled-password --gecos "" --shell /sbin/nologin \
            --home /home/pi --no-create-home --ingroup pi \
            --uid $UID pi

# add dependencies
RUN apk add --no-cache parted rsync unzip wget zip && \
    mkdir -p /netboot

VOLUME /netboot/nfsroot
VOLUME /netboot/tftpboot

# netboot environment variables
# (see: https://www.raspberrypi.org/software/operating-systems/)
ENV IMG="https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-01-12/2021-01-11-raspios-buster-armhf-lite.zip" \
    NFSIP=192.168.0.200 \
    NFSROOT=/nfsroot/raspberrypi

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

WORKDIR /netboot

ENTRYPOINT ["/docker-entrypoint.sh"]
