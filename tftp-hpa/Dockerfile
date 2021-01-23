FROM alpine:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="TFTP-HPA Server on Alpine Linux"

RUN apk add --no-cache tftp-hpa

ARG UID=9069
ARG GID=9069

RUN addgroup -g "$GID" -S "tftp" && \
    adduser --disabled-password --gecos "" --shell "/sbin/nologin" \
            --home "/home/tftp" --no-create-home --ingroup "tftp" \
            --uid "$UID" "tftp"

RUN mkdir /tftpboot && \
    chown -R $UID:$GID /tftpboot && \
    chmod -R 0666 /tftpboot

WORKDIR /tftpboot

EXPOSE 69/udp
VOLUME /tftpboot

COPY mapfile /mapfile
ENTRYPOINT ["in.tftpd", "-L", "-u", "tftp", "--secure"]
CMD ["--verbose", "-m", "/mapfile", "/tftpboot"]
