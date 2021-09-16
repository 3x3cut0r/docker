# tftpd-hpa (tftpd)

**A lightweight tftp-server (tftpd-hpa)**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/tftpd-hpa)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/tftpd-hpa)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/tftpd-hpa)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20tftpd-hpa)

`GitHub` - 3x3cut0r/tftpd-hpa - https://github.com/3x3cut0r/docker/tree/main/tftpd-hpa  
`DockerHub` - 3x3cut0r/tftpd-hpa - https://hub.docker.com/r/3x3cut0r/tftpd-hpa  

## Index

1. [Usage](#usage)  
  1.1 [docker run](#dockerrun)  
  2.2 [docker-compose.yaml](#dockercompose)  
2. [Environment Variables](#environment-variables)  
3. [Volumes](#volumes)  
4. [Ports](#ports)  
5. [Find Me](#findme)  
6. [License](#license)  

## 1 Usage <a name="usage"></a>

### 1.1 docker run <a name="dockerrun"></a>

**Example 1 - run without arguments (environment variables will be used):**  
**This is the recommended way to use this container !!!**
```shell
docker run -d \
    --name tftpd-hpa \
    -e TZ="Europe/Berlin" \
    -v /path/of/some/files:/tftpboot \
    -p 69:69/udp \
    3x3cut0r/tftpd-hpa:latest
```

**Example 2 - run with specified environment variables:**  
**CREATE=1: allow uploads, even if file doesn't exist**
**MAPFILE="": do not use the mapfile**
```shell
docker run -d \
    --name tftpd-hpa \
    -e TZ="Europe/Berlin" \
    -e CREATE=1 \
    -e MAPFILE="" \
    -v /path/of/some/files:/tftpboot \
    -p 69:69/udp \
    3x3cut0r/tftpd-hpa:latest
```

**Example 3 - run with arguments (environment variables will be ignored):**  
**in.tftpd --foreground --address 0.0.0.0:69 --user tftp <your arguments>**
```shell
docker run -d \
    --name tftpd-hpa \
    -e TZ="Europe/Berlin" \
    -v /path/of/some/files:/tftpboot \
    -p 69:69/udp \
    3x3cut0r/tftpd-hpa:latest \
    -c --secure --verbose /tftpboot
```

**Example 4 - run with arguments with optional 'in.tftpd' as first argument:**  
**in.tftpd --foreground --address 0.0.0.0:69 --user tftp <your arguments>**
```shell
docker run -d \
    --name tftpd-hpa \
    -e TZ="Europe/Berlin" \
    -v /path/of/some/files:/tftpboot \
    -p 69:69/udp \
    3x3cut0r/tftpd-hpa:latest \
    in.tftpd -c --secure --verbose /tftpboot
```

**Example 5 - run without arguments and custom MAPFILE:**  
**you need to VOLUME your MAPFILE**
```shell
docker run -d \
    --name tftpd-hpa \
    -e TZ="Europe/Berlin" \
    -e MAPFILE=/mapfile \
    -v /path/of/some/files:/tftpboot \
    -v /path/of/your/mapfile:/mapfile \
    -p 69:69/udp \
    3x3cut0r/tftpd-hpa:latest
```

### 1.2 docker-compose.yaml <a name="docker-compose"></a>

```shell
version: '3'

services:
  tftpd-hpa:
    image: 3x3cut0r/tftpd-hpa
    environment:
        TZ: Europe/Berlin
        CREATE: 1
        VERBOSE: 1
    volumes:
      - /path/of/some/files:/tftpboot
    ports:
      - 69:69/udp
```

### 2 Environment Variables <a name="environment-variables"></a>
**for more information, see https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html**

* `TZ` - Specifies the server timezone - **Default: UTC**  
* `BLOCKSIZE` - Specifies the maximum permitted block size  
* `CREATE` - Allow new files to be created - Default: 0 (only upload files, if they already exist)  
* `MAPFILE` - Specify the use of filename remapping - **Default: /mapfile**  
(leave empty, if you don't want to use a mapfile)  
* `PERMISSIVE` - Perform no additional permissions checks - Default: 0  
* `PORTRANGE` - Force the server port number (the Transaction ID) to be in the specified range of port numbers - **Default: 4096:32760**  
* `REFUSE` - Indicate that a specific RFC 2347 TFTP option should never be accepted  
* `RETRANSMIT` - Determine the default timeout, in microseconds, before the first packet is retransmitted - Default: 1000000 (1 second)  
* `SECURE` - Change root directory on startup - **Default: 1**  
* `TIMEOUT` - This specifies how long, in seconds, to wait for a second connection before terminating the server - Default: 900  
* `UMASK` - Sets the umask for newly created files  
* `VERBOSE` - Increase the logging verbosity of tftpd - **Default: 1**  
* `VERBOSITY` - Set the verbosity value from 0 to 4 - **Default: 3**  

### 3 Volumes <a name="volumes"></a>

* `/tftpboot` - tftp root directory -> **your directory needs to be at least 0555 (dr-xr-xr-x), owned by root or uid=9069, gid=9069**  
* `/mapfile`  - mapfile for tftpd-hpa -> your mapfile needs to be at least 0444 (-r--r--r--), owned by root or uid=9069, gid=9069  

### 4 Ports <a name="ports"></a>

* `69/udp` - TFTP Port  



### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
