FROM alpine:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="download syslinux files for pxe boot"

# add prerequisites
RUN apk add --no-cache wget && \
    mkdir -p    /syslinux \
                /etc/dhcpd

# syslinux environment variables
ENV DHCPD_UID=9067 \
    DHCPD_GID=9067 \
    SYSLINUX_UID=9069 \
    SYSLINUX_GID=9069 \
    SYSLINUX_VERSION=6.03 \
    TFTPD_ADDRESS=192.168.0.1

VOLUME /syslinux
VOLUME /etc/dhcpd

# add dhcpd-pxe.conf
RUN mkdir /etc/dhcpd
COPY ./etc/dhcpd/dhcpd-pxe.conf /etc/dhcpd/

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]
