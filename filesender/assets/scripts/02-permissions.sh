#!/bin/bash

# setup environment

# filesender
FILESENDER_DIR="/opt/filesender"
FILESENDER_CONFIG_DIR="/config/filesender"



# change permissions and ownership of filesender to www-data
chown -R www-data:www-data  /opt/*

chown -R www-data:root      /data/* \
                            /config/filesender/config \
                            /config/simplesamlphp/config

chmod -R 775    /opt/* \
                /config/* \
                /data/* \
                /usr/local/sbin/* \
                /etc/service/*/run \
                /etc/nginx/sites-*

chmod -R o-rwx  /data/* \
                /config/filesender/config/* \
                /config/simplesamlphp/config/*

chmod -R 777    /data/tmp

chmod -R o+w    /data/log
