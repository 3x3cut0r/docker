# tftp-hpa (tftpd)

A lightweight tftp-server (tftp-hpa)

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/tftp-hpa)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/tftp-hpa)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/tftp-hpa)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20tftp-hpa)

GitHub: https://github.com/3x3cut0r/docker/tree/main/tftp-hpa

DockerHub: https://hub.docker.com/r/3x3cut0r/tftp-hpa

## Usage

#### run
Example:
```shell
docker run -d \
    --name tftp-hpa \
    -v /path/of/some/files:/tftpboot:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest
```

#### Specify custom arguments:
(see https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html)

Example:
```shell
docker run -d \
    --name tftp-hpa \
    -v /path/of/some/files:/tftpboot:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest \
    -m /mapfile
    --ipv4 \
    --umask 0022 \
    /tftpboot
```

#### docker-compose.yaml

```shell
version: '3'

services:
  tftp-hpa:
    image: 3x3cut0r/tftp-hpa
    volumes:
      - /path/of/some/files:/tftpboot
    ports:
      - 69:69/udp
```

#### Volumes

* `/tftpboot` - TFTP_ROOT

#### Ports

* `69/udp` - TFTP Port

## Find Me

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
