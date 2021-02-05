FROM 3x3cut0r/alpine:3.13.1
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="nfs server on alpine linux"

# set UID/GID for rpc (rpcbind)
ENV UID=9049 \
    GID=9049

# add user rpc
RUN addgroup -g $GID -S rpc && \
    adduser --disabled-password --gecos "" --shell /sbin/nologin \
            --home /var/lib/rpcbind --no-create-home --ingroup rpc \
            --uid $UID rpc

# add nfs + set capabilities
RUN apk add --no-cache nfs-utils && \
    echo "portmap:ALL" > /etc/hosts.deny && \
        echo "lockd:ALL" > /etc/hosts.deny && \
     echo "mountd:ALL" > /etc/hosts.deny && \
     echo "rquotad:ALL" > /etc/hosts.deny && \
     echo "statd:ALL" > /etc/hosts.deny
#&& \
#    setcap CAP_SYS_ADMIN,CAP_SETPCAP=+ep /usr/sbin/exportfs && \
#    setcap CAP_SYS_ADMIN,CAP_SETPCAP=+ep /sbin/rpcbind && \
#    setcap CAP_SYS_ADMIN,CAP_SETPCAP=+ep /usr/sbin/rpc.gssd && \
#    setcap CAP_SYS_ADMIN,CAP_SETPCAP=+ep /usr/sbin/rpc.idmapd && \
#    setcap CAP_SYS_ADMIN,CAP_SETPCAP=+ep /usr/sbin/rpc.mountd && \
#    setcap CAP_SYS_ADMIN,CAP_SETPCAP=+ep /usr/sbin/rpc.svcgssd && \
#    setcap CAP_SYS_ADMIN,CAP_SETPCAP=+ep /usr/sbin/rpc.nfsd && \
#    setcap CAP_SYS_ADMIN,CAP_SETPCAP=+ep /sbin/rpc.statd

# nfs environment variables
# (see: https://manpages.debian.org/stretch/manpages-de/nfs.5.de.html)
#ENV

VOLUME /nfsroot
EXPOSE 111/udp
EXPOSE 2049/tcp

# set permissions for NFSROOT
RUN mkdir -p /nfsroot && \
    chown -R "${UID}":"${GID}" /nfsroot && \
    chmod -R 0750 /nfsroot && \
    chown "${UID}":"${GID}" /etc/exports && \
    chmod 0777 /etc/exports

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

#USER rpc
ENTRYPOINT ["/docker-entrypoint.sh"]

#HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
#    CMD getent services tftp || exit 1
