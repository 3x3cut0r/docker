#!/bin/bash

# setup environment

# filesender
FILESENDER_DIR="/opt/filesender"
FILESENDER_CONFIG_DIR="/config/filesender"



# change permissions and ownership of filesender to www-data
chown -R root:www-data      /config/filesender

chown -R www-data:www-data  /data/* \
                            /config/filesender/www


# chown -R root:root        /config/fpm/* \
#                           /config/simplesamlphp/*

chmod -R 755    /opt/* \
                /config/* \
                /data/* \
                /usr/local/sbin/*

chmod 775       /etc/service/*/run \
                /etc/nginx/sites-*

chmod 664       /etc/nginx/fastcgi_params \
                /etc/nginx/sites-available/default

chmod -R 644    /config/fpm \
                /config/simplesamlphp


chmod -R o-rwx  /data/* \
                /config/filesender/config/*
