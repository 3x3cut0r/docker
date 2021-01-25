#!/bin/sh
set -e
exec /usr/local/bin/gosu "$UID":"$GID" in.tftpd -L -u tftp "$@" --secure /tftpboot
