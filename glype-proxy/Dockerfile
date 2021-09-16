FROM alpine:latest as build
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="glype - a web-based proxy on nginx:alpine"

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
FROM nginx-unprivileged:alpine
COPY --from=build /app/* /usr/share/nginx/html
VOLUME /usr/share/nginx/html
