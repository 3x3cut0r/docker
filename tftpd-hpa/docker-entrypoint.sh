#!/bin/sh
set -e

############################
# setup user environment   #
############################

# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# print version
cat /VERSION

############################
# run app                  #
############################

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
    param="--foreground --address 0.0.0.0:69 --user tftp ${param} /tftpboot"

    echo -e "\nINFO: /usr/sbin/in.tftpd ${param}\n"
    echo -e "#!/bin/sh\n/usr/sbin/in.tftpd ${param}" > /runit-services/tftpd-hpa/run

else
    # if first arg looks like a flag, assume we want to run in.tftpd
    if [ "$( echo "$1" | cut -c1 )" = "-" ]; then
        echo -e "\nINFO: /usr/sbin/in.tftpd --foreground --address 0.0.0.0:69 --user tftp $@\n"
        echo -e "#!/bin/sh\n/usr/sbin/in.tftpd --foreground --address 0.0.0.0:69 --user tftp $@" > /runit-services/tftpd-hpa/run

    # if the first arg is "in.tftpd" ...
    elif [ "$1" = "in.tftpd" ]; then
        echo -e "\nINFO: /usr/sbin/in.tftpd --foreground --address 0.0.0.0:69 --user tftp $@\n"
        echo -e "#!/bin/sh\n/usr/sbin/in.tftpd --foreground --address 0.0.0.0:69 --user tftp ${@}" > /runit-services/tftpd-hpa/run

    # if first arg doesn't looks like a flag
    else
        exec "$@"
        exit 0
    fi
fi

exec runsvdir /runit-services
