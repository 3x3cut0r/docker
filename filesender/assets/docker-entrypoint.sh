#!/bin/bash
set -e

# exec scripts
chmod +x /scripts/*.sh
cd /scripts
for script in $(ls); do
    echo "run /scripts/$script"
    /bin/bash ./"$script"
done

# exec /usr/local/sbin/runsvdir-init
exec /usr/local/sbin/runsvdir-init
