#!/bin/sh
set -e
# if started without args, exec in.tftpd
if [ "$#" = "0" ]; then
    param=""
    if [ "$BLOCKSIZE" != "" ]; then param="${param} --blocksize $BLOCKSIZE"; fi
    if [ "$CREATE" = "1" ]; then param="${param} --create"; fi
    if [ "$MAPFILE" != "" ]; then param="${param} --map-file $MAPFILE"; fi
    if [ "$PERMISSIVE" = "1" ]; then param="${param} --permissive"; fi
    if [ "$PORTRANGE" != "" ]; then param="${param} --port-range $PORTRANGE"; fi
    if [ "$REFUSE" != "" ]; then param="${param} --refuse $REFUSE"; fi
    if [ "$RETRANSMIT" != "" ]; then param="${param} --retransmit $RETRANSMIT"; fi
    if [ "$SECURE" = "1" ]; then param="${param} --secure"; fi
    if [ "$TIMEOUT" != "" ]; then param="${param} --timeout $TIMEOUT"; fi
    if [ "$UMASK" != "" ]; then param="${param} --umask $UMASK"; fi
    if [ "$VERBOSE" = "1" ]; then param="${param} --verbose"; fi
    if [ "$VERBOSITY" = "1" ]; then param="${param} --verbosity $VERBOSITY"; fi
    param="--foreground --address 0.0.0.0:9069 --user tftp ${param} /tftpboot"
    echo "INFO: in.tftpd ${param}"
    exec in.tftpd ${param}
else
    # if first arg looks like a flag, assume we want to run in.tftpd
    if [ "$( echo "$1" | cut -c1 )" = "-" ]; then
        echo "INFO: in.tftpd $@"
        exec in.tftpd $@
    # if first arg is either 'in.tftpd' or args of 'in.tftpd'
    else
        echo "INFO: $@"
        exec $@
    fi
fi
