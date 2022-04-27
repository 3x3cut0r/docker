#!/bin/bash

# setup environment

# filesender
FILESENDER_DIR="/opt/filesender"
FILESENDER_CONFIG_DIR="/config/filesender"



# change permissions and ownership of filesender to www-data
chown root:www-data         /config/filesender/config/*.php \
                            /config/simplesamlphp/config/*.php

chown -R www-data:www-data  /data/* \
                            /opt/filesender/www \
                            /opt/simplesamlphp/www


# chown -R root:root        /config/fpm/* \
#                           /config/simplesamlphp/*

chmod 775       /etc/service/*/run \
                /etc/nginx/sites-*

chmod -R 755    /opt/* \
                /config/* \
                /data/* \
                /usr/local/sbin/*

chmod -R o-rwx  /data/* \
                /config/filesender/config/*

# chown -R root:www-data      /config/filesender

# chmod 664       /etc/nginx/fastcgi_params \
#                 /etc/nginx/sites-available/default

# chmod -R 644    /config/fpm \
#                 /config/simplesamlphp
