FROM linuxserver/tvheadend:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="tvheadend from linuxserver/tvheadend with Sundtek drivers"

RUN set -eux; \
    mkdir -p /sundtek; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget ca-certificates; \
    rm -rf /var/lib/apt/lists/*; \
    cd /sundtek; \
    wget http://www.sundtek.de/media/sundtek_netinst.sh; \
    chmod +x sundtek_netinst.sh; \
    yes | ./sundtek_netinst.sh -docker -use-custom-path=/sundtek
