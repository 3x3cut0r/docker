# tftp-hpa (tftpd)

A lightweight and secure dhcp-server (isc-dhcp-server)

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/isc-dhcp-server)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/isc-dhcp-server)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/isc-dhcp-server)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20isc-dhcp-server)
![run as](https://img.shields.io/badge/run%20as-non--root-red)

GitHub: https://github.com/3x3cut0r/docker/tree/main/isc-dhcp-server

DockerHub: https://hub.docker.com/r/3x3cut0r/isc-dhcp-server

## Index

1. [Usage](#usage)
    1. [docker run](#dockerrun)
    2. [docker-compose.yaml](#dockercompose)
2. [Environment Variables](#environment-variables)
3. [Volumes](#volumes)
4. [Ports](#ports)
5. [Find Me](#findme)
6. [License](#license)

## Usage <a name="usage"></a>

### docker run <a name="dockerrun"></a>

**Example 1 - IPV4 - run with custom dhcpd.conf**  
**This is the recommended way to use this container,**  
**otherwise you will not be able to use all options that dhcpd.conf supports**  
**Note: IFACE have to fit with your host-interface !!!**  
```shell
docker run -d \
    --name isc-dhcp-server \
    --network=host \
    -e IFACE=eth0 \
    -v /path/to/your/dhcpd.conf:/etc/dhcp/dhcpd.conf:ro \
    3x3cut0r/isc-dhcp-server:latest
```

**Example 2 - IPV4 - run with specified environment variables**  
**Note: IFACE+SUBNET have to fit with your host-interface !!!**  
```shell
docker run -d \
    --name isc-dhcp-server \
    --network=host \
    -e IFACE=eth0 \
    -e SUBNET=192.168.0.0 \
    -e NETMASK=255.255.255.0 \
    -e RANGE_BEGIN=192.168.0.100 \
    -e RANGE_END=192.168.0.200 \
    -e OPTION_ROUTERS=192.168.0.1 \
    -e OPTION_DOMAIN_NAME_SERVERS="8.8.8.8, 8.8.4.4" \
    3x3cut0r/isc-dhcp-server:latest
```

**Example 3 - IPV6 - run with custom dhcpd.conf**   
**Note: IFACE have to fit with your host-interface !!!**  
```shell
docker run -d \
    --name isc-dhcp-server \
    --network=host \
    -e IFACE=eth0 \
    -e PROTOCOL=6 \
    -v /path/to/your/dhcpd.conf:/etc/dhcp/dhcpd.conf:ro \
    3x3cut0r/isc-dhcp-server:latest
```

**Example 4 - IPV6 - run with specified environment variables**  
**Note: IFACE+SUBNET6 have to fit with your host-interface !!!**  
```shell
docker run -d \
    --name isc-dhcp-server \
    --network=host \
    -e IFACE=eth0 \
    -e PROTOCOL=6 \
    -e SUBNET6="fe80::0/64" \
    -e RANGE6_BEGIN="fe80::1" \
    -e RANGE6_END="fe80::ffff" \
    -e OPTION_DHCP6_NAME_SERVERS="2001:4860:4860::8888, 2001:4860:4860::8844" \
    3x3cut0r/isc-dhcp-server:latest
```

### docker-compose.yaml <a name="docker-compose"></a>

```shell
version: '3'

services:
  isc-dhcp-server:
    network_mode: host
    environment:
        IFACE: eth0
        PROTOCOL: 4
    volumes:
        - /path/to/your/dhcpd.conf:/etc/dhcp/dhcpd.conf
    image: 3x3cut0r/isc-dhcp-server:latest

```

### Environment Variables <a name="environment-variables"></a>
**for more information, see https://manpages.debian.org/jessie/isc-dhcp-server/dhcpd.8.en.html**

* `IFACE` - Interface to listen on. **Have to fit with your host-interface! Default: eth0**
* `PROTOCOL` - IP Protocol. (IPv4=4, IPv6=6) **Default: 4**
* `QUIET` - Be quiet at startup. **Default: 0**

### Volumes <a name="volumes"></a>

* `/etc/dhcp/dhcpd.conf` - DHCP-Server configuration file - **recommended, otherwise configure your dhcp-server via environment variables**

### Ports <a name="ports"></a>

* No need for Port-Bindings because of network=host!

## Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
