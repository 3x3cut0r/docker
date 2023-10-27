# tftpd-hpa (tftpd)

**A lightweight tftp-server (tftpd-hpa)**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/tftpd-hpa)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/tftpd-hpa)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/tftpd-hpa)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/tftp-hpa.yml?branch=main)

`GitHub` - 3x3cut0r/tftpd-hpa - https://github.com/3x3cut0r/docker/tree/main/tftpd-hpa  
`DockerHub` - 3x3cut0r/tftpd-hpa - https://hub.docker.com/r/3x3cut0r/tftpd-hpa

## Usage <a name="usage"></a>

### docker run <a name="dockerrun"></a>

**Example 1 - run without arguments (environment variables will be used):**  
**This is the recommended way to use this container !!!**

```shell
docker run --rm \
    --name syslinux \
    -v /path/of/your/tftpboot:/syslinux \
    3x3cut0r/syslinux:latest
```

### Environment Variables <a name="environment-variables"></a>

**for more information, see https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html**

### Volumes <a name="volumes"></a>

- `/syslinux` - directory to save your syslinux files

## Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-julianreith%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
