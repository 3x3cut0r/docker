FROM nginx:stable-alpine
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="404 error page - based on nginx"

# copy html content
COPY ./html /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

# set environment variables
ENV TZ="UTC" \
    TITLE="404 Not Found"

VOLUME /usr/share/nginx/html

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:80 || exit 1