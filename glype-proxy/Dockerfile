FROM nginx:alpine
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="glype - a web-based proxy on nginx:alpine"

VOLUME /usr/share/nginx/html

RUN apk --no-cache --virtual .git-deps \
    git \
    less \
    openssh

# clone glype
RUN git clone https://github.com/vincentclee/glype.git . && \

# clean up dependencies
RUN apk del --no-network .git-deps && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*
