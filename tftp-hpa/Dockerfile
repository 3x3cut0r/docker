FROM alpine:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
RUN apk add --no-cache tftp-hpa
RUN adduser -D tftp
EXPOSE 69/udp
VOLUME /tftpboot
ENTRYPOINT ["in.tftpd"]
CMD ["-L", "-u", "tftp", "--secure", "/tftpboot"]
