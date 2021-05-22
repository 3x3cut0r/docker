FROM linuxserver/tvheadend:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="tvheadend from linuxserver/tvheadend with Sundtek SkyTV Ultimate drivers"

RUN mkdir /sundtek && \
    cd /sundtek && \
    wget http://www.sundtek.de/media/sundtek_netinst.sh && \
    chmod 777 sundtek_netinst.sh && \
    yes | ./sundtek_netinst.sh -docker -use-custom-path=/sundtek
