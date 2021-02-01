#!/bin/sh
set -e
# if started without args, exec in.tftpd
if [ "$#" = "0" ]; then
    param=""
    if [ "$BLOCKSIZE" != "" ]; then param="${param} --blocksize $BLOCKSIZE"; fi
    if [ "$CREATE" = "1" ]; then param="${param} --create"; fi
    if [ "$PORTRANGE" != "" ]; then param="${param} --port-range $PORTRANGE"; fi
    if [ "$MAPFILE" != "" ]; then param="${param} --map-file $MAPFILE"; fi
    if [ "$PERMISSIVE" = "1" ]; then param="${param} --permissive"; fi
    if [ "$REFUSE" != "" ]; then param="${param} --refuse $REFUSE"; fi
    if [ "$RETRANSMIT" != "" ]; then param="${param} --retransmit $RETRANSMIT"; fi
    if [ "$SECURE" = "1" ]; then param="${param} --secure"; fi
    if [ "$TIMEOUT" != "" ]; then param="${param} --timeout $TIMEOUT"; fi
    if [ "$UMASK" != "" ]; then param="${param} --umask $UMASK"; fi
    if [ "$VERBOSE" = "1" ]; then param="${param} --verbose"; fi
    if [ "$VERBOSITY" != "" ]; then param="${param} --verbosity $VERBOSITY"; fi
    param="--foreground --address 0.0.0.0:9069 --user tftp ${param} /tftpboot"
    printf "\nINFO: in.tftpd ${param}\n\n"
    exec in.tftpd ${param}
else
    # if first arg looks like a flag, assume we want to run in.tftpd
    if [ "$( echo "$1" | cut -c1 )" = "-" ]; then
        printf "\nINFO: in.tftpd --foreground --address 0.0.0.0:9069 --user tftp $@\n\n"
        exec in.tftpd --foreground --address 0.0.0.0:9069 --user tftp $@
    # if the first arg is "in.tftpd" ...
    elif [ "$1" = "in.tftpd" ]; then
        exec in.tftpd --foreground --address 0.0.0.0:9069 --user tftp "${@:9}"
    # if first arg doesn't looks like a flag
    else
        printf "\nINFO: $@\n\n"
        exec $@
    fi
fi
