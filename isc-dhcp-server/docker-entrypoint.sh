#!/bin/sh
set -e
# (re-)generate /var/lib/dhcp/dhcpd.conf
FILE=/var/lib/dhcp/dhcpd.conf
echo "#" > $FILE
echo "# dhcpd.conf" >> $FILE
echo "#" >> $FILE
echo "# configuration file for ISC dhcpd" >> $FILE
echo "#" >> $FILE
if [ "$DEFAULT_LEASE_TIME" -gt "0" ]; then
    echo "default-lease-time $DEFAULT_LEASE_TIME;" >> $FILE
else
    echo "default-lease-time 600;" >> $FILE
fi
if [ "$MAX_LEASE_TIME" -gt "0" ]; then
    echo "max-lease-time $MAX_LEASE_TIME;" >> $FILE
else
    echo "max-lease-time 7200;" >> $FILE
fi
if [ "$AUTHORITATIVE" = "1" ]; then echo "authoritative;" >> $FILE; fi
if [ "$LOGFACILITY" != "" ]; then echo "log-facility $LOGFACILITY;" >> $FILE; fi
echo "" >> $FILE

echo "subnet $SUBNET netmask $NETMASK {" >> $FILE
echo "  range $RANGE_BEGIN $RANGE_END;" >> $FILE
if [ "$OPTION_BROADCAST" != "" ]; then echo "  option broadcast-address $OPTION_BROADCAST;" >> $FILE; fi
if [ "$OPTION_ROUTERS" != "" ]; then echo "  option routers $OPTION_ROUTERS;" >> $FILE; fi
if [ "$OPTION_DOMAIN_NAME" != "" ]; then echo "  option domain-name \"$OPTION_DOMAIN_NAME\";" >> $FILE; fi
if [ "$OPTION_DOMAIN_NAME_SERVERS" != "" ]; then echo "  option domain-name-servers $OPTION_DOMAIN_NAME_SERVERS;" >> $FILE; fi
if [ "$NEXT_SERVER" != "" ]; then echo "  option next-server $NEXT_SERVER;" >> $FILE; fi
if [ "$OPTION_TFTP_SERVER_NAME" != "" ]; then echo "  option tftp-server-name $OPTION_TFTP_SERVER_NAME;" >> $FILE; fi
if [ "$OPTION_BOOTFILE_NAME" != "" ]; then echo "  option bootfile-name $OPTION_BOOTFILE_NAME;" >> $FILE; fi
if [ "$OPTION_NTP_SERVERS" != "" ]; then echo "  option ntp-servers $OPTION_NTP_SERVERS;" >> $FILE; fi
echo "}" >> $FILE

# Docker subnet
echo "" >> $FILE
echo "# docker subnet to prevent \"No subnet declaration for eth0 (172.x.x.x) error\"" >> $FILE
echo "subnet 172.0.0.0 netmask 255.0.0.0 {" >> $FILE
echo "}" >> $FILE


# if started without args, exec dhcpd
if [ "$#" = "0" ]; then
    param=""
    if [ "$QUIET" = "1" ]; then
        param="${param} -f -q"
    else
        param="${param} -d"
    fi
    CONFIG_FILE=/etc/dhcp/dhcpd.conf
    if [ -f "$CONFIG_FILE" ]; then
        param="${param} -cf /etc/dhcp/dhcpd.conf"
    else
        param="${param} -cf /var/lib/dhcp/dhcpd.conf"
    fi
    LEASE_FILE=/etc/dhcp/dhcpd.leases
    if [ -f "$LEASE_FILE" ]; then
        param="${param} -lf /etc/dhcp/dhcpd.leases"
    else
        param="${param} -lf /var/lib/dhcp/dhcpd.leases"
    fi
    param="${param} -user dhcp -group dhcp eth0"
    echo "INFO: dhcpd ${param}"
    exec dhcpd ${param}
else
    echo "INFO: $@"
    exec $@
fi
