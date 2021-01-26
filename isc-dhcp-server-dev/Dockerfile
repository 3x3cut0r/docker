FROM 3x3cut0r/alpine:3.13.0
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="isc-dhcp-server on alpine Linux"

# add isc-dhcp-server
RUN apk add --no-cache dhcp

# set UID/GID for dhcp
ENV UID=9067 \
    GID=9067

# add user dhcp
RUN addgroup -g $GID -S dhcp && \
    adduser --disabled-password --gecos "" --shell /sbin/nologin \
            --home /home/dhcp --no-create-home --ingroup dhcp \
            --uid $UID dhcp

# isc-dhcp-server environment variables
# (see: https://manpages.debian.org/jessie/isc-dhcp-server/dhcpd.8.en.html)
ENV CONFIG=/config \
    AUTHORITATIVE=1 \
    SUBNET=192.168.0.0 \
    NETMASK=255.255.255.0 \
    RANGE_BEGIN=192.168.0.10 \
    RANGE_END=192.168.0.199 \
    DEFAULT_LEASE_TIME=86400 \

# Options dhcpd.conf Environment Variables
ENV OPTION_ROUTERS "192.168.0.1" \
    OPTION_DOMAIN_NAME ".local" \
    OPTION_DOMAIN_NAME_SERVERS "192.168.0.1" \
    NEXT_SERVER "192.168.0.1" \
    OPTION_TFTP_SERVER_NAME "192.168.0.1" \
    OPTION_TEST ""

WORKDIR $CONFIG_PATH

EXPOSE 67/udp
VOLUME $CONFIG_PATH

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
