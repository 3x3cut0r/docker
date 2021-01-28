#!/bin/sh
set -e
# create and set permissions to TFTPROOT
mkdir -p "${TFTPROOT}"
chown -R "${UID}":"${GID}" "${TFTPROOT}"
chmod -R 0660 "${TFTPROOT}"
# set permissions for MAPFILE
chown "${UID}":"${GID}" "${MAPFILE}"
chmod 0400 "${MAPFILE}"
# if started without args, exec in.tftpd
if [ "$#" = "0" ]; then
    param=""
    if [ "$ADDRESS" != "" ]; then param="${param} --address $ADDRESS"; fi
    if [ "$BLOCKSIZE" != "" ]; then param="${param} --blocksize $BLOCKSIZE"; fi
    if [ "$CREATE" = "1" ]; then param="${param} --create"; fi
    if [ "$FOREGROUND" = "1" ]; then param="${param} --foreground"; fi
    if [ "$IPV4" = "1" ]; then param="${param} --ipv4"; fi
    if [ "$IPV6" = "1" ]; then param="${param} --ipv6"; fi
    if [ "$LISTEN" = "1" ]; then param="${param} --listen"; fi
    if [ "$MAPFILE" != "" ]; then param="${param} --map-file $MAPFILE"; fi
    if [ "$PERMISSIVE" = "1" ]; then param="${param} --permissive"; fi
    if [ "$PIDFILE" != "" ]; then param="${param} --pidfile" $PIDFILE; fi
    if [ "$PORTRANGE" != "" ]; then param="${param} --port-range $PORTRANGE"; fi
    if [ "$REFUSE" != "" ]; then param="${param} --refuse $REFUSE"; fi
    if [ "$RETRANSMIT" != "" ]; then param="${param} --retransmit $RETRANSMIT"; fi
    if [ "$SECURE" = "1" ]; then param="${param} --secure"; fi
    if [ "$TIMEOUT" != "" ]; then param="${param} --timeout $TIMEOUT"; fi
    if [ "$UMASK" != "" ]; then param="${param} --umask $UMASK"; fi
    if [ "$USER" != "" ]; then param="${param} --user $USER"; fi
    if [ "$VERBOSE" = "1" ]; then param="${param} --verbose"; fi
    if [ "$VERBOSITY" = "1" ]; then param="${param} --verbosity $VERBOSITY"; fi
    param="${param} ${TFTPROOT}"
    exec gosu "${UID}":"${GID}" in.tftpd ${param} 2>&1
else
    # if the first arg is "in.tftpd" ...
    if [ "$1" = "in.tftpd" ]; then
        exec gosu "${UID}":"${GID}" $@ 2>&1
    # if first arg looks like a flag, assume we want to run in.tftpd
    elif [ "$( echo "$1" | cut -c1 )" = "-" ]; then
        exec gosu "${UID}":"${GID}" in.tftpd $@ 2>&1
    # if first arg is either 'in.tftpd' or args of 'in.tftpd'
    else
        exec gosu "${UID}":"${GID}" $@ 2>&1
    fi
fi
