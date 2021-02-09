# raspberrypi-netboot

**extract files from a RaspiOS.img into the tftpboot and nfsroot directory for RPi pxe-boot**  

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/raspberrypi-netboot)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/raspberrypi-netboot)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/raspberrypi-netboot)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20raspberrypi-netboot)

`GitHub` - 3x3cut0r/raspberrypi-netboot - https://github.com/3x3cut0r/docker/tree/main/raspberrypi-netboot  
`DockerHub` - 3x3cut0r/raspberrypi-netboot - https://hub.docker.com/r/3x3cut0r/raspberrypi-netboot

## Usage

### docker run

**Example 1 - without mounting a custom RaspiOS.img**  
**(image will be downloaded from given url)**  
```shell
docker container run --rm \
    --privileged \
    --name raspberrypi-netboot \
    -e IMG="https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-01-12/2021-01-11-raspios-buster-armhf-lite.zip" \
    -e NFS_IP=192.168.0.200 \
    -e NFS_ROOT=/nfsroot/raspberrypi \
    -e NFS_VERSION=4 \
    -v /path/to/some/folder/nfsroot:/netboot/nfsroot \
    -v /path/to/some/folder/tftpboot:/netboot/tftpboot \
    3x3cut0r/raspberrypi-netboot:latest
```

**Example 2 - with mounting a custom RaspiOS.img**  
**download your image from https://downloads.raspberrypi.org**  
**(this will perform a lot faster !!!)**  
```shell
docker container run --rm \
    --privileged \
    --name raspberrypi-netboot \
    -e NFS_IP=192.168.0.200 \
    -e NFS_ROOT=/nfsroot/raspberrypi \
    -e NFS_VERSION=4 \
    -v /path/to/your/2021-01-11-raspios-buster-armhf-lite.zip:/netboot/raspios.zip \
    -v /path/to/some/folder/nfsroot:/netboot/nfsroot \
    -v /path/to/some/folder/tftpboot:/netboot/tftpboot \
    3x3cut0r/raspberrypi-netboot:latest
```

### docker-compose.yaml

```shell
version: '3'

services:
  raspberrypi-netboot:
    privileged: true
    image: 3x3cut0r/raspberrypi-netboot
    environment:
      IMG: "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-01-12/2021-01-11-raspios-buster-armhf-lite.zip"
      NFS_IP=192.168.0.200
      NFS_ROOT=/nfsroot/raspberrypi
      NFS_VERSION=4
    volumes:
      - /path/to/some/folder/nfsroot:/netboot/nfsroot
      - /path/to/some/folder/tftpboot:/netboot/tftpboot
```

### Environment Variables

* `NFS_IP` - NFS-Server IP-Address to be written in the boot/cmdline.txt  
* `NFS_ROOT` - NFS-Root-Directory to be written in the boot/cmdline.txt and /etc/fstab  
* `NFS_VERSION` - NFS-Version to be written in the boot/cmdline.txt

### Volumes

* `/netboot/nfsroot` - nfsroot directory. should be mapped or copied to your nfs-servers nfsroot directory
* `/netboot/tftpboot`  - tftpboot directory. should be mapped or copied to your tftp-servers tftproot directory.

## Find Me

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
