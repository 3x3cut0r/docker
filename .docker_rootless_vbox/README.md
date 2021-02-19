# docker rootless mode

**script to install docker in rootless mode on debian 10 in virtualbox**  

## Index

1. [VirtualBox](#virtualbox)
    1. [Create new VirtualMachine in VirtualBox](#create_vm)
    2. [Install Debian 10 in VirtualBox](#install_debian)
    3. [Set static ip address in /etc/network/interfaces](#set_ip)
2. [Usage](#usage)
    1. [first-run: install prerequisites](#first_run)
    2. [second-run: install docker](#second_run)
    3. [use docker](#use_docker)
3. [Find Me](#findme)
4. [License](#license)

## 1. VirtualBox <a name="virtualbox"></a>

### Create new VirtualMachine in VirtualBox <a name="create_vm"></a>
```shell
# VirtualBox Settings:
#
# VM Name:          docker-host
# VM Typ:           Linux
# VM Version:       Debian (64-bit)
# VM optical img:   e.g.: debian-10.8.0-amd64-netinst.iso
# VM Boot-order:    optical, hard disk
# VM RAM:           4 GB
# VM CPU-Cores:     2
# VM CPU-Options:   PAE/NX activated
# VM GPU-RAM:       32MB
# VM Netwerk:       network-bridge
#
```

### Install Debian 10 in VirtualBox <a name="install_debian"></a>
```shell
# Debian 10 Installation:
#
# Graphical install (Debian 10)
# language:         <choose your own>
# hostname:         docker-host
# root username:    root
# root password:    root
# username:         docker
# password:         docker
# ip:               dhcp
#
# Software to install:
# x SSH server
# x Standard-Systemtools
#
```

### Set static ip address in /etc/network/interfaces <a name="set_ip"></a>
```shell
# auto lo
# iface lo inet loopback
# iface enp0s3 inet static
#   address 192.168.0.254/24
#   gateway 192.168.0.1
#   dns-servers 8.8.8.8 8.8.4.4
#
# The primary network interface
# This is an autoconfigured IPv6 interface
# allow-hotplug enp0s3
# iface enp0s3 inet6 auto
#
```

## 2. Usage <a name="usage"></a>

### download and run script first time as root <a name="first_run"></a>
login (via ssh) on your guest as docker:
```shell
ssh docker@192.168.0.254
```
on your guest:
```shell
su -
apt install wget -y
wget -q https://raw.githubusercontent.com/3x3cut0r/docker/main/.docker_rootless_vbox/docker_rootless.sh -O docker_rootless.sh
chmod +x docker_rootless.sh
./docker_rootless.sh
...
reboot
```

### run script second time as docker <a name="second_run"></a>
login (via ssh) on your guest as docker:
```shell
ssh docker@192.168.0.254
```
on your guest:
```shell
./docker_rootless.sh install
...
reboot
```

### use docker only with user docker <a name="use_docker"></a>
login (via ssh) on your guest as docker:
```shell
ssh docker@192.168.0.254
```
on your guest:
```shell
docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

## Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)
