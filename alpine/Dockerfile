# App-Stage
ARG IMAGE=alpine:latest
FROM ${IMAGE}

LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="official alpine linux with gosu, libcap installed"

WORKDIR /

# Add gosu
ENV GOSU_VERSION 1.16
RUN set -eux; \
    \
    apk add --no-cache --virtual .gosu-deps \
        ca-certificates \
        dpkg \
        gnupg \
    ; \
    \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
    \
# Verify the signature
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    command -v gpgconf && gpgconf --kill all || :; \
    rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    \
# Clean up fetch dependencies
    apk del --no-network .gosu-deps; \
    \
    chmod +x /usr/local/bin/gosu; \
# Verify that the binary works
    gosu --version; \
    gosu nobody true

# Add dependencies for all images
RUN apk add --no-cache tzdata \
    libcap

# Store versions in /VERSION
RUN touch /VERSION && \
    echo "alpine=$(cat /etc/alpine-release)" > /VERSION && \
    echo "gosu=$GOSU_VERSION" >> /VERSION
