FROM alpine:3.13.1
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="isc-dhcp-server on alpine linux (ipv4 only)"

# set UID/GID for dhcp
ENV UID=9067 \
    GID=9067

# add user dhcp
RUN addgroup -g $GID -S dhcp && \
    adduser --disabled-password --gecos "" --shell /sbin/nologin \
            --home /home/dhcp --no-create-home --ingroup dhcp \
            --uid $UID dhcp

# add isc-dhcp-server
RUN apk add --no-cache dhcp && \
    mkdir -p /var/lib/dhcp && \
    touch /var/lib/dhcp/dhcpd.conf && \
    touch /var/lib/dhcp/dhcpd.leases

# isc-dhcp-server environment variables
# (see: https://manpages.debian.org/jessie/isc-dhcp-server/dhcpd.8.en.html)
ENV QUIET=0 \
    DEFAULT_LEASE_TIME=600 \
    MAX_LEASE_TIME=7200 \
    AUTHORITATIVE=1 \
    LOGFACILITY="local7" \
    SUBNET=192.168.0.0 \
    NETMASK=255.255.255.0 \
    RANGE_BEGIN=192.168.0.10 \
    RANGE_END=192.168.0.199 \
    OPTION_BROADCAST=192.168.0.255 \
    OPTION_ROUTERS="192.168.0.1" \
    OPTION_DOMAIN_NAME=".local" \
    OPTION_DOMAIN_NAME_SERVERS="8.8.8.8, 8.8.4.4" \
    NEXT_SERVER="" \
    OPTION_TFTP_SERVER_NAME="" \
    OPTION_BOOTFILE_NAME="" \
    OPTION_NTP_SERVERS=""

VOLUME /etc/dhcp
EXPOSE 9067/udp

# set permissions for DHCPD
RUN chown -R "${UID}":"${GID}" /etc/dhcp && \
    chmod -R 0644 /etc/dhcp && \
    chown -R "${UID}":"${GID}" /var/lib/dhcp && \
    chmod -R 0777 /var/lib/dhcp

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD ps | grep dhcpd | grep -v grep || exit 1
