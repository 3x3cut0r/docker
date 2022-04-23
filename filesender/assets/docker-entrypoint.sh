#!/bin/sh
set -e
# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# exec /sbin/runsvdir-init
ln -s /etc/service/* /etc/sv/
exec /sbin/runsvdir-init
