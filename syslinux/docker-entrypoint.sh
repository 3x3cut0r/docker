#!/bin/sh
set -e
mkdir -p /tmp/syslinux && cd /tmp/syslinux
wget -q https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-"$SYSLINUX_VERSION".tar.gz
tar -xzf syslinux-"$SYSLINUX_VERSION".tar.gz
chown -R $SYSLINUX_UID:$SYSLINUX_GID .

# root section
mkdir -p /syslinux/pxelinux.cfg
mkdir -p /syslinux/images
cp -f ./bios/core/pxelinux.0 /syslinux
cp -f ./efi32/efi/syslinux.efi /syslinux/pxelinuxEFI32.efi
cp -f ./efi64/efi/syslinux.efi /syslinux/pxelinuxEFI64.efi
cp -f ./bios/com32/elflink/ldlinux/ldlinux.c32 /syslinux
cp -f ./bios/memdisk/memdisk /syslinux
cp -f ./efi32/com32/elflink/ldlinux/ldlinux.e32 /syslinux
cp -f ./efi64/com32/elflink/ldlinux/ldlinux.e64 /syslinux

# bios section
mkdir -p /syslinux/bios
BIOS_FILES=$(find ./bios -name *c32)
for f in $BIOS_FILES; do cp -f "$f" /syslinux/bios; done

# efi32 section
mkdir -p /syslinux/efi32
EFI32_FILES=$(find ./efi32 -name *c32)
for f in $EFI32_FILES; do cp -f "$f" /syslinux/efi32; done

# efi64 section
mkdir -p /syslinux/efi32
EFI64_FILES=$(find ./efi64 -name *c32)
for f in $EFI64_FILES; do cp -f "$f" /syslinux/efi64; done

# dhcpd section
cd /etc/dhcpd
chown -R $DHCPD_UID:$DHCPD_GID dhcpd-pxe.conf
sed -i s/192.168.178.254/$TFTPD_ADDRESS/g dhcpd-pxe.conf

# clean environment
rm -rf /tmp/syslinux
