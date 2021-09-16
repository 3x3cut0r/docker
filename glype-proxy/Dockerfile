FROM alpine:latest as build
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="glype - a web-based proxy on php:fpm-alpine3.13"

WORKDIR /app

# install dependencies
RUN apk add --no-cache --virtual .git-deps \
    ca-certificates \
    dpkg \
    git \
    gnupg \
    less \
    openssh

# clone app
RUN git clone https://github.com/vincentclee/glype.git .


# copy app into container
FROM php:fpm-alpine3.13
COPY --from=build /app/* /var/www/html
VOLUME /var/www/html
