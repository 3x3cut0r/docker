#!/bin/bash

# setup environment

# user data
USER='www-data'
USER_ID="$(cat /etc/passwd | grep www-data | cut -d ':' -f 3)"
GROUP_ID="$(cat /etc/passwd | grep www-data | cut -d ':' -f 4)"
USER_UID=${USER_UID:-$USER_ID}
USER_GID=${USER_GID:-$GROUP_ID}



# Check if www-data's uid:gid has been requested to be changed
NEW_UID=${CHOWN_WWW%%:*}
NEW_GID=${CHOWN_WWW##*:}

if [ "$NEW_GID" = "" ]; then
    NEW_GID=$NEW_UID
fi

if [ "$NEW_UID" != "" ]; then
    # Change old $USER_ID to $NEW_UID, similarly old $GROUP_ID->$NEW_GID
    groupmod -g $NEW_GID $USER
    usermod -u $NEW_UID $USER
    find / -type d -path /proc -prune -o -group $GROUP_ID -exec chgrp -h $USER {} \;
    find / -type d -path /proc -prune -o -user $USER_ID -exec chown -h $USER {} \;
fi
