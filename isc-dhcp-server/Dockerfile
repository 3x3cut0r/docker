FROM alpine:3.20
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="isc-dhcp-server on alpine linux (ipv4 only)"

# set UID/GID for dhcp
ENV UID=9067 \
    GID=9067

# add user dhcp
RUN addgroup -g $GID -S dhcp && \
    adduser --disabled-password --gecos "" --shell /sbin/nologin \
            --home /var/lib/dhcp --no-create-home --ingroup dhcp \
            --uid $UID dhcp

# add isc-dhcp-server
RUN apk add --no-cache dhcp tzdata && \
    mkdir -p /var/lib/dhcp && \
    touch /var/lib/dhcp/dhcpd.conf && \
    touch /var/lib/dhcp/dhcpd.leases

# isc-dhcp-server environment variables
# (see: https://manpages.debian.org/jessie/isc-dhcp-server/dhcpd.8.en.html)
ENV TZ="UTC" \
    IFACE=eth0 \
    PROTOCOL=4 \
    QUIET=0 \
    DEFAULT_LEASE_TIME=3600 \
    MAX_LEASE_TIME=86400 \
    AUTHORITATIVE=1 \
    LOGFACILITY="local7" \
    SUBNET="" \
    NETMASK="" \
    RANGE_BEGIN="" \
    RANGE_END="" \
    BROADCAST="" \
    ROUTERS="" \
    DOMAIN_NAME="" \
    DOMAIN_NAME_SERVERS="" \
    DOMAIN_SEARCH="" \
    NEXT_SERVER="" \
    TFTP_SERVER_NAME="" \
    BOOTFILE_NAME="" \
    NTP_SERVERS="" \
    ROOT_PATH="" \
    VENDOR_ENCAPSULATED_OPTIONS="" \
    SUBNET6="" \
    RANGE6_BEGIN="" \
    RANGE6_END="" \
    DHCP6_NAME_SERVERS="" \
    DHCP6_DOMAIN_SEARCH="" \
    PREFIX6=""

VOLUME /etc/dhcp

# set permissions for DHCPD
RUN chown -R "${UID}":"${GID}" /etc/dhcp && \
    chmod -R 0644 /etc/dhcp && \
    chown -R "${UID}":"${GID}" /var/lib/dhcp && \
    chmod -R 0644 /var/lib/dhcp

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD ps | grep dhcpd | grep -v grep || exit 1
