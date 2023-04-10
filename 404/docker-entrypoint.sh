#!/bin/sh
set -e
# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# setup environment
sed -i "s/<title>.*<\/title>/<title>${TITLE}<\/title>/g" /usr/share/nginx/html/index.html

# Führe NGINX im Vordergrund aus
nginx -g "daemon off;"