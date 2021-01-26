#!/bin/sh
set -e

# create $CONFIG_PATH
mkdir $CONFIG_PATH
chown -R $UID:$GID $CONFIG_PATH
chmod -R 775 $CONFIG_PATH


echo "" > $CONFIG_PATH/dhcpd.conf
if [ -z ${OPTION_TEST+x} ]; then echo "OPTION" >> /config/dhcpd.conf ; fi

exec "$@"
