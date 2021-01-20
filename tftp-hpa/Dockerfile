FROM alpine:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"

RUN apk add --no-cache tftp-hpa

ENV USER=tftp
ENV UID=69
ENV GID=69
RUN addgroup -g "$GID" -S "$USER" && \
    adduser --disabled-password --gecos "" --home "/home/$USER" \
        --ingroup "$USER" --no-create-home --uid "$UID" "$USER"
USER "$USER"

EXPOSE 69/udp
VOLUME /tftpboot

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "-u", "tftp", "--secure", "/tftpboot"]
