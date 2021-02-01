# tftp-hpa (tftpd)

A lightweight and secure dhcp-server (isc-dhcp-server, ipv4 only)

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

**Example 1 - run without arguments (environment variables will be used):**  
```shell
docker run -d \
    --name isc-dhcp-server \
    -p 67:67/udp \
    3x3cut0r/isc-dhcp-server:latest
```

### docker-compose.yaml <a name="docker-compose"></a>

```shell
version: '3'

services:
  tftp-hpa:
    image: 3x3cut0r/isc-dhcp-server
    ports:
      - 67:67/udp
```

### Environment Variables <a name="environment-variables"></a>
**for more information, see https://manpages.debian.org/jessie/isc-dhcp-server/dhcpd.8.en.html**

* `COMING SOON` - coming soon **Default: 1**

### Volumes <a name="volumes"></a>

* `/etc/dhcp/dhcpd.conf` - DHCP-Server configuration file -> **no need to mount if you configure your dhcp-server via environment variables**

### Ports <a name="ports"></a>

* `67/udp` - DHCP-Server IPv4 Port

## Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
