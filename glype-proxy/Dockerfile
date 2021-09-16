FROM nginx:alpine
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="glype - a web-based proxy on nginx:alpine"

VOLUME /usr/share/nginx/html
RUN apk add --no-cache git && \
    git clone https://github.com/vincentclee/glype.git . && \
    apk del --no-network git
