#!/bin/bash

# setup environment

# filesender
FILESENDER_DIR="/opt/filesender"
FILESENDER_CONFIG_DIR="/config/filesender"



# change permissions and ownership of filesender to www-data
chown -R www-data:www-data  /data/* \
                            /opt/*

chown -R root:www-data      /opt/simplesamlphp/data

# chown -R root:root        /config/fpm/* \
#                           /config/simplesamlphp/*

chmod -R 775    /opt/* \
                /config/* \
                /data/* \
                /usr/local/sbin/* \
                /etc/service/*/run \
                /etc/nginx/sites-*

chmod -R o-rwx  /data/* \
                /config/filesender/config/*

# chown -R root:www-data      /config/filesender

# chmod 664       /etc/nginx/fastcgi_params \
#                 /etc/nginx/sites-available/default

# chmod -R 644    /config/fpm \
#                 /config/simplesamlphp
