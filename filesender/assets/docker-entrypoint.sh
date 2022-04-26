#!/bin/sh
set -e

# exec scripts
chmod +x /scripts/*.sh
for script in /scripts/*.sh; do
    exec "$script"
done

# exec /usr/local/sbin/runsvdir-init
exec /usr/local/sbin/runsvdir-init
