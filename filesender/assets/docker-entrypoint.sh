#!/bin/sh
set -e
# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# change file permissions
chown -R www-data:www-data /opt /config /data

# exec /usr/local/sbin/runsvdir-init
exec /usr/local/sbin/runsvdir-init
