#!/bin/sh
ls -la .
# download RPi OS image
if [ ! -f *.zip ] && [ ! -f *.img ]; then echo "download raspios.zip ..." && wget $IMG; fi
# unzip RPi OS image
if [ -f *.zip ]; then echo "unzip raspios.zip ..." && unzip *.zip; fi
# rename RPi OS image
if [ -f *.img ]; then echo "rename raspios.img ..." && mv *raspios*.img raspios.img; fi
set -e
# split image to have both partitions reparate
echo "get raspios.img info ..."
mkdir fat32
mkdir ext4
UNITS=$(fdisk -l raspios.img | grep 'Units\|Einheiten' | cut -d = -f 2 | cut -d ' ' -f 2 | cut -d ' ' -f 1)
SKIP_PART_1=$(fdisk -l raspios.img | grep raspios.img1 | awk '{gsub(/[ ]+/," ")}1' | cut -d ' ' -f 4 | cut -d ' ' -f 1)
SKIP_PART_2=$(fdisk -l raspios.img | grep raspios.img2 | awk '{gsub(/[ ]+/," ")}1' | cut -d ' ' -f 4 | cut -d ' ' -f 1)
COUNT_PART_1=$(fdisk -l raspios.img | grep raspios.img1 | awk '{gsub(/[ ]+/," ")}1' | cut -d ' ' -f 6 | cut -d ' ' -f 1)
COUNT_PART_2=$(fdisk -l raspios.img | grep raspios.img2 | awk '{gsub(/[ ]+/," ")}1' | cut -d ' ' -f 6 | cut -d ' ' -f 1)
echo "UNITS=$UNITS"
echo "START OF FIRST PARTITION=$SKIP_PART_1"
echo "START OF SECOND PARTITION=$SKIP_PART_2"
echo "LENGTH OF FIRST PARTITION=$COUNT_PART_1"
echo "LENGTH OF SECOND PARTITION=$COUNT_PART_2"
echo "split image ..."
dd if=raspios.img of=raspios.img1 bs=$UNITS skip=$SKIP_PART_1 count=$COUNT_PART_1
dd if=raspios.img of=raspios.img2 bs=$UNITS skip=$SKIP_PART_2 count=$COUNT_PART_2
ls -la
# make tftpboot
echo "mount raspios.img1 ..."
mount -v -t vfat -o loop raspios.img1 fat32
echo "rsync raspios.img1 to /netboot/tftpboot ..."
rsync -rq --exclude=boot fat32/ tftpboot/
echo "mount raspios.img1 ..."
umount fat32
echo "remove raspios.img1 ..."
rm -rf raspios.img1
echo "setup cmdline.txt for NFS-boot ..."
echo "selinux=0 dwc_otg.lpm_enable=0 console=tty1 rootwait rw nfsroot=$NFSIP:$NFSROOT,v4 ip=dhcp root=/dev/nfs elevator=deadline" > tftpboot/cmdline.txt
echo "setup config.txt for NFS-boot ..."
echo "program_usb_boot_mode=1" >> tftpboot/config.txt

# make nfsroot
echo "mount raspios.img2 ..."
mount -v -t ext4 -o loop raspios.img2 ext4
echo "rsync raspios.img2 to /netboot/nfsboot ... (this takes some time)"
rsync -rq --exclude=boot/* ext4/ nfsroot/
echo "unmount raspios.img2 ..."
umount ext4
echo "remove raspios.img2 ..."
rm -rf raspios.img2
echo "setup /etc/fstab for NFS-boot ..."
echo "proc /proc proc defaults 0 0" > $NFSROOT/etc/fstab
echo "DONE"
