#!/bin/sh
set -e
# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# show available interfaces:
printf "\nINFO: available interfaces:\n\n"
ls /sys/class/net/
# (re-)generate /var/lib/dhcp/dhcpd.conf
FILE=/var/lib/dhcp/dhcpd.conf
echo "#" > $FILE
echo "# dhcpd.conf" >> $FILE
echo "#" >> $FILE
echo "# configuration file for ISC dhcpd" >> $FILE
echo "#" >> $FILE
# global declaration
if [ "$DEFAULT_LEASE_TIME" -gt "0" ]; then echo "default-lease-time $DEFAULT_LEASE_TIME;" >> $FILE; else echo "default-lease-time 600;" >> $FILE; fi
if [ "$MAX_LEASE_TIME" -gt "0" ]; then echo "max-lease-time $MAX_LEASE_TIME;" >> $FILE; else echo "max-lease-time 7200;" >> $FILE; fi
if [ "$AUTHORITATIVE" = "1" ]; then echo "authoritative;" >> $FILE; fi
if [ "$LOGFACILITY" != "" ]; then echo "log-facility $LOGFACILITY;" >> $FILE; fi
echo "" >> $FILE
if [ $PROTOCOL = "4" ]; then
    # subnet declaration ipv4 (envirionment variables)
    echo "subnet $SUBNET netmask $NETMASK {" >> $FILE
    echo "  range $RANGE_BEGIN $RANGE_END;" >> $FILE
    if [ "$BROADCAST" != "" ]; then echo "  option broadcast-address $BROADCAST;" >> $FILE; fi
    if [ "$ROUTERS" != "" ]; then echo "  option routers $ROUTERS;" >> $FILE; fi
    if [ "$DOMAIN_NAME" != "" ]; then echo "  option domain-name \"$DOMAIN_NAME\";" >> $FILE; fi
    if [ "$DOMAIN_NAME_SERVERS" != "" ]; then echo "  option domain-name-servers $DOMAIN_NAME_SERVERS;" >> $FILE; fi
    if [ "$DOMAIN_SEARCH" != "" ]; then echo "  option domain-search \"$DOMAIN_SEARCH\";" >> $FILE; fi
    if [ "$NEXT_SERVER" != "" ]; then echo "  next-server $NEXT_SERVER;" >> $FILE; fi
    if [ "$TFTP_SERVER_NAME" != "" ]; then echo "  option tftp-server-name \"$TFTP_SERVER_NAME\";" >> $FILE; fi
    if [ "$BOOTFILE_NAME" != "" ]; then echo "  option bootfile-name \"$BOOTFILE_NAME\";" >> $FILE; fi
    if [ "$NTP_SERVERS" != "" ]; then echo "  option ntp-servers $NTP_SERVERS;" >> $FILE; fi
    if [ "$ROOT_PATH" != "" ]; then echo "  option root-path \"$ROOT_PATH\";" >> $FILE; fi
    if [ "$VENDOR_ENCAPSULATED_OPTIONS" != "" ]; then echo "  option vendor-encapsulated-options \"$VENDOR_ENCAPSULATED_OPTIONS\";" >> $FILE; fi
    echo "}" >> $FILE

    # subnet declaration ipv4 (docker subnet)
    echo "" >> $FILE
    echo "# docker subnet to prevent \"No subnet declaration for eth0 (172.x.x.x) error\"" >> $FILE
    echo "subnet 172.0.0.0 netmask 255.0.0.0 {" >> $FILE
    echo "}" >> $FILE
elif [ $PROTOCOL = "6" ]; then
    # subnet declaration ipv6 (envirionment variables)
    echo "subnet6 $SUBNET6 {" >> $FILE
    echo "  range6 $RANGE6_BEGIN $RANGE6_END;" >> $FILE
    if [ "$DHCP6_NAME_SERVERS" != "" ]; then echo "  option dhcp6.name-servers $DHCP6_NAME_SERVERS;" >> $FILE; fi
    if [ "$DHCP6_DOMAIN_SEARCH" != "" ]; then echo "  option dhcp6.domain-search \"$DHCP6_DOMAIN_SEARCH\";" >> $FILE; fi
    if [ "$PREFIX6" != "" ]; then echo "  prefix6 $PREFIX6;" >> $FILE; fi
    echo "}" >> $FILE
fi

# if started without args, exec dhcpd
if [ "$#" = "0" ]; then
    CONFIG_FILE=/etc/dhcp/dhcpd.conf
    LEASE_FILE=/etc/dhcp/dhcpd.leases
    if [ "$QUIET" = "1" ]; then param="${param} -f -q"; else param="${param} -d"; fi
    if [ -f "$CONFIG_FILE" ]; then param="${param} -cf /etc/dhcp/dhcpd.conf"; else param="${param} -cf /var/lib/dhcp/dhcpd.conf"; fi
    if [ -f "$LEASE_FILE" ]; then param="${param} -lf /etc/dhcp/dhcpd.leases"; else param="${param} -lf /var/lib/dhcp/dhcpd.leases"; fi
    param="${param} -${PROTOCOL} --no-pid -user dhcp -group dhcp ${IFACE}"
    printf "\nINFO: dhcpd ${param}\n\n"
    exec dhcpd ${param}
else
    printf "\nINFO: $@\n\n"
    exec $@
fi
