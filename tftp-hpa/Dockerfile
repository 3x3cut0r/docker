FROM alpine:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="TFTP-HPA Server on Alpine Linux"

RUN apk add --no-cache tftp-hpa

ENV USER tftp
ENV UID 9069
ENV GID 9069
ENV TFTP_ROOT "/tftpboot"

RUN addgroup -g "$GID" -S "$USER" && \
    adduser --disabled-password --gecos "" --home "/home/$USER" \
        --ingroup "$USER" --no-create-home --uid "$UID" "$USER" && \
    mkdir $TFTP_ROOT && \
    chown -R $UID:$GID $TFTP_ROOT && \
    chmod -R 775 $TFTP_ROOT

WORKDIR $TFTP_ROOT
USER $USER

EXPOSE 69/udp
VOLUME $TFTP_ROOT

ENTRYPOINT ["sh", "-c", "in.tftpd -L -u $USER --secure $TFTP_ROOT"]
