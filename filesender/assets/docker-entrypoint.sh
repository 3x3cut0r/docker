#!/bin/sh
set -e
# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# exec /sbin/runsvdir
exec /sbin/runsvdir -P /etc/service
