#!/bin/sh
# check RPi OS image
printf '\n\e[0;33m%-6s\e[m\n' " ==> check if image is mounted ... "
ls -la .

# download RPi OS image
if [ ! -f *.zip ] && [ ! -f *.img ]; then
    printf '\n\e[0;33m%-6s\e[m\n' " ==> no image found ... download raspios.zip ... " && wget --progress=bar:force:noscroll -O raspios.zip $IMG && touch /tmp/downloaded
else
    printf '\n\e[0;33m%-6s\e[m\n' " ==> image found ... "
fi

# unzip RPi OS image
if [ -f *.zip ]; then printf '\n\e[0;33m%-6s\e[m\n' " ==> unzip image ... " && unzip *.zip; fi

# rename RPi OS image
if [ -f *.img ]; then printf '\n\e[0;33m%-6s\e[m\n' " ==> rename image to raspios.img ... " && echo "mv *.img raspios.img" && mv *.img raspios.img; fi
set -e

# split image to have both partitions separate
mkdir fat32
mkdir ext4
printf '\n\e[0;33m%-6s\e[m\n' " ==> get raspios.img info ... " && echo "fdisk -l raspios.img" && echo ""
fdisk -l raspios.img
UNITS=$(fdisk -l raspios.img | grep 'Units\|Einheiten' | cut -d = -f 2 | cut -d ' ' -f 2 | cut -d ' ' -f 1)
SKIP_PART_1=$(fdisk -l raspios.img | grep raspios.img1 | awk '{gsub(/[ ]+/," ")}1' | cut -d ' ' -f 4 | cut -d ' ' -f 1)
SKIP_PART_2=$(fdisk -l raspios.img | grep raspios.img2 | awk '{gsub(/[ ]+/," ")}1' | cut -d ' ' -f 4 | cut -d ' ' -f 1)
COUNT_PART_1=$(fdisk -l raspios.img | grep raspios.img1 | awk '{gsub(/[ ]+/," ")}1' | cut -d ' ' -f 6 | cut -d ' ' -f 1)
COUNT_PART_2=$(fdisk -l raspios.img | grep raspios.img2 | awk '{gsub(/[ ]+/," ")}1' | cut -d ' ' -f 6 | cut -d ' ' -f 1)
echo "" && echo "UNITS=$UNITS" && echo "START OF FIRST PARTITION=$SKIP_PART_1" && echo "START OF SECOND PARTITION=$SKIP_PART_2" && echo "LENGTH OF FIRST PARTITION=$COUNT_PART_1" && echo "LENGTH OF SECOND PARTITION=$COUNT_PART_2"
printf '\n\e[0;33m%-6s\e[m\n' " ==> split image ... " && echo "first partition:" && echo "dd if=raspios.img of=raspios.img1 bs=$UNITS skip=$SKIP_PART_1 count=$COUNT_PART_1"
dd if=raspios.img of=raspios.img1 bs=$UNITS skip=$SKIP_PART_1 count=$COUNT_PART_1
echo "" && echo "second partition:" && echo "dd if=raspios.img of=raspios.img2 bs=$UNITS skip=$SKIP_PART_2 count=$COUNT_PART_2"
dd if=raspios.img of=raspios.img2 bs=$UNITS skip=$SKIP_PART_2 count=$COUNT_PART_2
sleep 10
echo "" && echo "ls -la raspios.img*" && ls -la raspios.img*

# make tftpboot
printf '\n\e[0;33m%-6s\e[m\n' " ==> mount raspios.img1 to fat32/ ... " && echo "mount -v -t vfat -o loop raspios.img1 fat32"
mount -v -t vfat -o loop raspios.img1 fat32
printf '\n\e[0;33m%-6s\e[m\n' " ==> rsync raspios.img1 to /netboot/tftpboot ... " && echo "rsync -rq --exclude=boot fat32/ tftpboot/"
rsync -rq --exclude=boot fat32/ tftpboot/
printf '\n\e[0;33m%-6s\e[m\n' " ==> umount raspios.img1 ... " && echo "umount fat32"
umount fat32
printf '\n\e[0;33m%-6s\e[m\n' " ==> setup cmdline.txt for NFS-boot ... " && echo "echo \"selinux=0 dwc_otg.lpm_enable=0 console=tty1 rootwait rw nfsroot=$NFS_IP:$NFS_ROOT,v$NFS_VERSION ip=dhcp root=/dev/nfs elevator=deadline\" > tftpboot/cmdline.txt"
echo "selinux=0 dwc_otg.lpm_enable=0 console=tty1 rootwait rw nfsroot=$NFS _IP:$NFS _ROOT,v$NFS_VERSION ip=dhcp root=/dev/nfs elevator=deadline" > tftpboot/cmdline.txt
printf '\n\e[0;33m%-6s\e[m\n' " ==> setup config.txt for NFS-boot ... " && echo "echo \"program_usb_boot_mode=1\" >> tftpboot/config.txt"
echo "program_usb_boot_mode=1" >> tftpboot/config.txt

# make nfsroot
printf '\n\e[0;33m%-6s\e[m\n' " ==> mount raspios.img2 to ext4/ ... " && echo "mount -v -t ext4 -o loop raspios.img2 ext4"
mount -v -t ext4 -o loop raspios.img2 ext4
printf '\n\e[0;33m%-6s\e[m\n' " ==> rsync raspios.img2 to /netboot/nfsboot ... (this may take some time) " && echo "rsync -rq --exclude=boot/* ext4/ nfsroot/"
rsync -rq --exclude=boot/* ext4/ nfsroot/
printf '\n\e[0;33m%-6s\e[m\n' " ==> umount raspios.img2 ... " && echo "umount ext4"
umount ext4
printf '\n\e[0;33m%-6s\e[m\n' " ==> setup /etc/fstab to not boot from SD-Card ... " && echo "echo \"proc /proc proc defaults 0 0\" > nfsroot/etc/fstab"
echo "proc /proc proc defaults 0 0" > nfsroot/etc/fstab
sleep 3

# clean environment
printf '\n\e[0;33m%-6s\e[m\n' " ==> clean environment... "
if [ -f /tmp/downloaded ]; then echo "rm -rf raspios.zip" && rm -rf raspios.zip; fi
echo "rm -rf raspios.img*" && rm -rf raspios.img*
echo "rm -rf fat32" && rm -rf fat32
echo "rm -rf ext4" && rm -rf ext4
printf '\n\e[0;33m%-6s\e[m\n\n' " ==> DONE "
