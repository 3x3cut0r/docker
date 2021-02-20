#!/bin/bash
# Author:   3x3cut0r <executor55@gmx.de>
# Version:  1.0
# Date:     2021-02-20
#
# Description:
#  this script installs a rootless docker-host on a debian 10 virtualbox
#

# Virtualbox Settings:
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

# set up static ip address in /etc/network/interfaces
#
# auto lo
# iface lo inet loopback
# iface enp0s3 inet static
#   address 192.168.15.254/24
#   gateway 192.168.15.1
#   dns-servers 8.8.8.8 8.8.4.4
#
# The primary network interface
# This is an autoconfigured IPv6 interface
# allow-hotplug enp0s3
# iface enp0s3 inet6 auto
#


DOCKER_USERNAME="docker"
DOCKER_UID="1000"

# change username
function username () {
    echo ""
    read -p "Enter the username under which the docker service should run. ($DOCKER_USERNAME): "
    if [ ! -z $REPLY ]; then
        if [ $(id -u $REPLY 2> /dev/null ) ]; then
            DOCKER_USERNAME=$REPLY
            DOCKER_UID="$(id -u $DOCKER_USERNAME)"
        else
            printf '\e[1;31m%-6s\e[m\n'  "username: $REPLY does not exits "
            echo "using $DOCKER_USERNAME instead"
        fi
    fi
    echo "DOCKER_USERNAME: $DOCKER_USERNAME (uid=$DOCKER_UID)"
}

# first run as root
function prepare () {
    printf '\n\e[1;31m%-6s\e[m\n\n' " ==> Step 1/2: prepare environment "

    # check first run
    read -p "Do you want to continue with Step 1? (y/N): "
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "exited by user\n"
        exit 1
    fi

    # check root
    if [ $UID -ne 0 ]; then
        printf '\e[1;31m%-6s\e[m\n\n' "run as root (uid=0) to install prerequisites"
        echo -e "If you want do install docker rootless, do:\n ./docker_rootless.sh install\n"
        exit 1
    fi

    # APT: prerequisites
    printf '\n\e[0;33m%-6s\e[m\n' " ==> APT: install prerequisites ... \n"
    apt update && apt upgrade -y
    apt install \
            build-essential \
            curl \
            dkms \
            linux-headers-$(uname -r) \
            openssh-server \
            sudo \
            uidmap \
            unzip \
            wget \
            -y

    # VI: arrow key fix
    printf '\n\e[0;33m%-6s\e[m\n' " ==> VI: arrow key fix ... \n"
    sed -i s/set\ compatible/set\ nocompatible/g /etc/vim/vimrc.tiny

    # SSH: PermitRootLogin (optional)
    printf '\n\e[0;33m%-6s\e[m\n' " ==> SSH: PermitRootLogin ... \n"
    read -p "Do you want to permit root login via ssh? (y/N): "
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sed -i s/#PermitRootLogin\ prohibit-password/PermitRootLogin\ yes/g /etc/ssh/sshd_config
        # systemctl restart sshd
    fi

    # SUDO: add docker to sudo group
    printf '\n\e[0;33m%-6s\e[m\n' " ==> SUDO: add docker to sudo group ... \n"
    read -p "Do you want to add docker to sudo group? (y/N): "
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        usermod -aG sudo $DOCKER_USERNAME
    fi

    # docker: prerequisites
    echo -e "# docker rootless mode prerequisites:\nkernel.unprivileged_userns_clone=1" > /etc/sysctl.d/docker_rootless.conf
    sysctl --system
    modprobe overlay permit_mounts_in_userns=1

    # VBoxGuestTools: attach virtualbox guest tools to /dev/cdrom
    printf '\n\e[0;33m%-6s\e[m\n' " ==> VBoxGuestTools: attach virtualbox guest tools to /dev/cdrom ... \n"
    read -p "Do you want to install VirtualBox Guest Tools via CD/DVD Optical-Drive? (y/N): "
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        read -n 1 -s -r -p "Attach virtualbox guest tools -> then press any key to continue ..."
        mount /dev/cdrom /mnt
        /mnt/VBoxLinuxAdditions.run
        umount /mnt
    fi

    # reboot
    printf '\n\e[0;33m%-6s\e[m\n' " ==> reboot, then login (via ssh) as $DOCKER_USERNAME (uid=$DOCKER_UID) to continue with './docker_rootless.sh --install'\n"
    read -n 1 -s -r -p "press any key to continue ..."
    reboot
}

# second run as docker
function install () {
    printf '\n\e[1;31m%-6s\e[m\n\n'  " ==> Step 2/2: install docker rootless "

    # check second run
    read -p "Do you want to continue with Step 2? (y/N): "
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "exited by user\n"
        exit 1
    fi

    # check docker already installed
    printf '\n\e[0;33m%-6s\e[m\n' " ==> Docker: install rootless docker ... \n"
    if  [[ -f /home/"$DOCKER_USERNAME"/bin/docker ]] || [[ -f /usr/local/bin/docker ]] || [[ -f /usr/bin/docker.io ]]; then
        which docker
        printf '\e[1;31m%-6s\e[m\n\n' "Docker is already installed. Abort"
        exit 1
    fi

    # install rootless docker
    if [ $UID -eq 0 ]; then echo "You need to login (via ssh) as $DOCKER_USERNAME (uid=$DOCKER_UID) to install rootless docker!"; exit 1; fi
    curl -fsSL https://get.docker.com/rootless | sh
    if [ $(sudo ls) ]; then
        sudo loginctl enable-linger docker
    else
        echo "enter 'loginctl enable-linger docker' as root"
        echo "to start docker daemon on system start automatically"
        echo "OR:"
        echo "systemctl --user start docker"
        echo "to start docker manually"
    fi
    echo -e "\n# Docker environment variables" >> ~/.bashrc
    echo "export PATH=/home/$DOCKER_USERNAME/bin:$PATH" >> ~/.bashrc
    echo "export DOCKER_HOST=unix:///run/user/$DOCKER_UID/docker.sock" >> ~/.bashrc

    # reboot
    printf '\n\e[0;33m%-6s\e[m\n' " ==> reboot ... login with docker ... and use 'docker ...'\n"
    if [ $(sudo ls) ]; then
        read -n 1 -s -r -p "press any key to reboot ..."
        reboot
    fi
}

function help () {
    printf "USAGE:\n"
    printf "  ./docker-rootless.sh [OPTIONS]\n\n"
    printf "OPTIONS:\n"
    printf "  --prepare\trun as root (uid=0) to install prerequisites\n\n"
    printf "  --install\trun as $DOCKER_USERNAME (uid=$DOCKER_UID) to install docker rootless-mode\n\n"
}

case "$1" in
    --first|--first-run|--prepare|first|first-run|1|prepare)
    username
    prepare
    ;;
    --second|--second-run|--install|second|second-run|2|install)
    username
    install
    ;;
esac
help
