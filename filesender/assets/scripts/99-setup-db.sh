#!/bin/bash

# setup environment

# filesender
FILESENDER_DIR="/opt/filesender"
FILESENDER_CONFIG_DIR="/config/filesender"

# database
DB_HOST=${DB_HOST:-"none"}
DB_NAME=${DB_NAME:-"filesender"}
DB_USER=${DB_USER:-"filesender"}
DB_PASSWORD=${DB_PASSWORD:-"filesender"}
DB_TYPE=${DB_TYPE:-"mysql"}
if [ "$DB_TYPE" = "mysql" ]; then
  # default port for mysql
  DB_PORT=${DB_PORT:-3306}
else
  # default port for postgresql
  DB_PORT=${DB_PORT:-5432}
fi

# misc
DB_STATUS_FILE=${FILESENDER_CONFIG_DIR}/.setup-db
TEMPLATE_DIR="/config/config-templates"



# setup database
if [ ! -f ${DB_STATUS_FILE} ] && ( [ "${DB_HOST}" != "none" ] && [ "${DB_HOST}" != "" ] ); then

    if [ "`which nc`" != "" ]; then

        RESULT=`nc -z -w1 ${DB_HOST} ${DB_PORT} && echo 1 || echo 0`

        while [ $RESULT -ne 1 ]; do
            echo " **** Database at ${DB_HOST}:${DB_PORT} is not responding, waiting... **** "
            sleep 5
            RESULT=`nc -z -w1 ${DB_HOST} ${DB_PORT} && echo 1 || echo 0`
        done

        php ${FILESENDER_DIR}/scripts/upgrade/database.php

        if [ "xx$SELENIUM_HOST" != "xx" ]; then
            export PGPASSWORD=$DB_PASSWORD
            psql -c 'create database filesenderdataset;' -h $DB_HOST -U $DB_USER
            bzcat ${FILESENDER_DIR}/scripts/dataset/dumps/filesender-2.0beta1.pg.bz2 | psql -h $DB_HOST -U $DB_USER -d filesenderdataset
        fi

        touch "$DB_STATUS_FILE"

    fi

fi
