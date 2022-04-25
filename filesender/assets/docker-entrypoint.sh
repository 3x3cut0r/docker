#!/bin/sh
set -e
# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# exec /usr/local/sbin/runsvdir-init
exec /usr/local/sbin/runsvdir-init
