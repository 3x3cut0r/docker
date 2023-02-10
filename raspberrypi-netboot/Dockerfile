FROM alpine:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="extract files from a RaspiOS.img into the tftpboot and nfsroot directory for RPi pxe-boot"

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
    NFS_IP=192.168.0.200 \
    NFS_ROOT=/nfsroot/raspberrypi \
    NFS_VERSION=3

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

WORKDIR /netboot

ENTRYPOINT ["/docker-entrypoint.sh"]
