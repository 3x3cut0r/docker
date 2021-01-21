FROM alpine:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"

RUN apk add --no-cache tftp-hpa

ENV USER tftp
ENV UID 9069
ENV GID 9069
ENV TFTP_PATH "/tftpboot"

RUN addgroup -g "$GID" -S "$USER" && \
    adduser --disabled-password --gecos "" --home "/home/$USER" \
        --ingroup "$USER" --no-create-home --uid "$UID" "$USER" && \
    mkdir $TFTP_PATH && \
    chown -R $UID:$GID $TFTP_PATH && \
    chmod -R 775 $TFTP_PATH

WORKDIR $TFTP_PATH
USER $USER

EXPOSE 69/udp
VOLUME $TFTP_PATH

ENTRYPOINT ["sh", "-c", "in.tftpd -L -u $USER --secure $TFTP_PATH"]
