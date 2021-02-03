# UNDER DEVELOPMENT, DONT USE !!!

# nfs

**A lightweight and secure nfs-server (NFSv4 only)**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/nfs-server)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/nfs-server)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/nfs-server)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20nfs-server)
![run as](https://img.shields.io/badge/run%20as-non--root-red)

`GitHub` - 3x3cut0r/nfs-server - https://github.com/3x3cut0r/docker/tree/main/nfs-server  
`DockerHub` - 3x3cut0r/nfs-server - https://hub.docker.com/r/3x3cut0r/nfs-server  

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
**This is the recommended way to use this container !!!**
```shell
docker run -d \
    --name nfs-server \
    -v /path/of/some/files:/nfsroot \
    -v /path/of/your/exports:/etc/exports:ro \
    -p 2049:2049 \
    3x3cut0r/nfs-server:latest
```

### Environment Variables <a name="environment-variables"></a>
**for more information, see https://manpages.debian.org/stretch/manpages-de/nfs.5.de.html**

* `COMING_SOON` - coming soon  

### Volumes <a name="volumes"></a>

* `/nfsroot` - nfs root directory -> **your directory needs to be at least 0770 (rwxrwx---), owned by uid=9049, gid=9049**   

### Ports <a name="ports"></a>

* `2049` - NFSv4 Port

## Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
