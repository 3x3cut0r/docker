#!/bin/bash
set -e

# exec scripts
chmod +x /scripts/*.sh
cd /scripts
for script in $(ls | grep '.sh$' ); do
    echo "exec: /scripts/$script"
    /bin/bash ./"$script"
done
echo ""

# exec /usr/local/sbin/runsvdir-init
exec /usr/local/sbin/runsvdir-init
