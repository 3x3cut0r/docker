# tftp-hpa (tftpd)

A lightweight tftp-server (tftp-hpa)

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/tftp-hpa)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/tftp-hpa)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/tftp-hpa)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20tftp-hpa)

GitHub: https://github.com/3x3cut0r/docker/tree/main/tftp-hpa

DockerHub: https://hub.docker.com/r/3x3cut0r/tftp-hpa

## Usage

### docker run

**Example 1 - run without arguments (environment variables will be used):**  
**This is the recommended way to use this container !!!**
```shell
docker run -d \
    --name tftp-hpa \
    -v /path/of/some/files:/srv/tftp:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest
```

**Example 2 - run with specified environment variables:**  
```shell
docker run -d \
    --name tftp-hpa \
    -e CREATE=1 \
    -v /path/of/some/files:/srv/tftp:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest
```

**Example 3 - run with arguments (environment variables will be ignored):**  
```shell
docker run -d \
    --name tftp-hpa \
    -v /path/of/some/files:/srv/tftp:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest \
    -L -u tftp -c --secure --verbose /srv/tftp
```

**Example 4 - run with arguments with optional 'in.tftpd' as first argument:**  
```shell
docker run -d \
    --name tftp-hpa \
    -v /path/of/some/files:/srv/tftp:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest \
    in.tftp -L -u tftp -c --secure --verbose /srv/tftp
```

**Example 5 - run with arguments and custom path for TFTPROOT:**  
you need to specify TFTPROOT if you want to use a custom tftp-root-dir
```shell
docker run -d \
    --name tftp-hpa \
    -e TFTPROOT=/tftpboot \
    -v /path/of/some/files:/tftpboot:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest \
    -L -u tftp -c --secure --verbose /tftpboot
```

**Example 6 - run without arguments and custom MAPFILE:**  
you need to VOLUME your MAPFILE if you want to use a custom MAPFILE
```shell
docker run -d \
    --name tftp-hpa \
    -e MAPFILE=/srv/mapfile \
    -v /path/of/some/files:/srv/tftp:ro \
    -v /path/of/your/mapfile:/srv/mapfile:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest
```

### docker-compose.yaml

```shell
version: '3'

services:
  tftp-hpa:
    image: 3x3cut0r/tftp-hpa
    volumes:
      - /path/of/some/files:/srv/tftp
    ports:
      - 69:69/udp
```

### Environment Variables
**for more information, see https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html**

* `ADDRESS` - Address and Port to listen to - Default: "" (all local addresses)
* `BLOCKSIZE` - Specifies the maximum permitted block size
* `CREATE` - Allow new files to be created - Default: 0 (only upload files, if they already exist)
* `FOREGROUND` - Similar to --listen but do not detach from the foreground process - **Default: 1**
* `IPV4` - Connect with IPv4 only - Default: 0
* `IPV6` - Connect with IPv6 only - Default: 0
* `LISTEN` - Run the server in standalone (listen) mode - Default: 0 (use FOREGROUND instead!)
* `MAPFILE` - Specify the use of filename remapping - **Default: /srv/mapfile**
* `PERMISSIVE` - Perform no additional permissions checks - Default: 0
* `PIDFILE` - When run in standalone mode, write the process ID of the listening server into pidfile - Default: ""
* `PORTRANGE` - Force the server port number (the Transaction ID) to be in the specified range of port numbers
* `REFUSE` - Indicate that a specific RFC 2347 TFTP option should never be accepted
* `RETRANSMIT` - Determine the default timeout, in microseconds, before the first packet is retransmitted - Default: 1000000 (1 second)
* `SECURE` - Change root directory on startup - **Default: 1**
* `TFTPROOT` - TFTP-Root-Directory - **Default: /srv/tftp**
* `TIMEOUT` - This specifies how long, in seconds, to wait for a second connection before terminating the server - Default: 900
* `UMASK` - Sets the umask for newly created files
* `USER` - Specify the username which tftpd will run as - **Default: tftp**
* `VERBOSE` - Increase the logging verbosity of tftpd - **Default: 1**
* `VERBOSITY` - Set the verbosity value from 0 to 7

### Volumes

* `/srv/tftp` - tftp root directory
* `/srv/mapfile` - map-file for tftp-hpa

### Ports

* `69/udp` - TFTP Port

## Find Me

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
