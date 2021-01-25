FROM 3x3cut0r/alpine:3.13.0
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="TFTP-HPA Server on Alpine Linux"

# add app
RUN apk add --no-cache tftp-hpa

ENV UID=9069
ENV GID=9069

RUN addgroup -g "$GID" -S "tftp" && \
    adduser --disabled-password --gecos "" --shell "/sbin/nologin" \
            --home "/home/tftp" --no-create-home --ingroup "tftp" \
            --uid "$UID" "tftp"

RUN mkdir /tftpboot && \
    chown -R $UID:$GID /tftpboot && \
    chmod -R 0744 /tftpboot

WORKDIR /tftpboot

ENV USE_MAPFILE 1

EXPOSE 69/udp
VOLUME /tftpboot

COPY mapfile /mapfile

COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--verbose", "-c", "-m", "/mapfile"]
