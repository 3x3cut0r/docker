FROM alpine:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="glype - a web-based proxy on nginx:alpine"

WORKDIR /app

RUN apk add --no-cache --virtual .git-deps \
    git \
    less \
    openssh

# clone glype
RUN git clone https://github.com/vincentclee/glype.git .


FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /app/* /usr/share/nginx/html
