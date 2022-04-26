#!/bin/sh
set -e
source /usr/local/etc/envvars

# exec scripts
chmod +x /scripts/*.sh
for script in /scripts/*.sh; do
    exec "$script"
done

# exec /usr/local/sbin/runsvdir-init
exec /usr/local/sbin/runsvdir-init
