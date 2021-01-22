# tftp-hpa (tftpd)

A lightweight tftp-server (tftp-hpa)

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/tftp-hpa)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/tftp-hpa)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/tftp-hpa)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20tftp-hpa)

GitHub: https://github.com/3x3cut0r/docker/tree/main/tftp-hpa

DockerHub: https://hub.docker.com/r/3x3cut0r/tftp-hpa

### Usage

```shell
docker run -d \
    --name tftp-hpa \
    -v /path/of/some/file:/tftpboot/file:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest
```

#### Environment Variables

* `USER` `tftp` - Username who owns the in.tftpd process
* `UID` `9069`- User-ID of the USER
* `GID` `9069`- Group-ID of the USER
* `TFTP_ROOT` `"/tftpboot"` - Path of the tftp-root

#### Volumes

* `/tftpboot` - TFTP_ROOT

#### Ports

* `69/udp` - TFTP Port

## Find Me

* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
