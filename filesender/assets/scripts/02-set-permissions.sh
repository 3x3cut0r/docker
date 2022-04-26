#!/bin/bash

# setup environment

# filesender
FILESENDER_DIR="/opt/filesender"
FILESENDER_CONFIG_DIR="/config/filesender"



# change permissions and ownership of filesender to www-data
chown -R www-data:www-data  /opt/* \
                            /config/* \
                            /data/*

chmod -R 755    /opt/* \
                /config/* \
                /data/* \
                /usr/local/sbin/runsvdir-init \
                /etc/service/*

chmod -R o-rwx  /data/*
