# 404 Not Found

**a nginx based 404 Not Found error page**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/404)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/404)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/404)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/404.yml?branch=main)

`GitHub` - 3x3cut0r/404 - https://github.com/3x3cut0r/docker/tree/main/404  
`DockerHub` - 3x3cut0r/404 - https://hub.docker.com/r/3x3cut0r/404

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

**Example 1 - run without arguments:**

```shell
docker run -d \
    --name 404 \
    -p 80:80 \
    3x3cut0r/404:latest
```

**Example 2 - specify timezone and title:**

```shell
docker run -d \
    --name 404 \
    -e TZ="Europe/Berlin" \
    -e TITLE="404 Not Found" \
    -p 80:80 \
    3x3cut0r/404:latest
```

**Example 3 - override favicon:**

```shell
docker run -d \
    --name 404 \
    -e TZ="Europe/Berlin" \
    -e TITLE="404 Not Found" \
    -p 80:80 \
    -v /path/to/your/favicon.ico:/usr/share/nginx/html/logo/favicon.ico \
    3x3cut0r/404:latest
```

**Example 4 - change some colors:**

```shell
docker run -d \
    --name 404 \
    -e BG-PRIMARY="red" \
    -p 80:80 \
    3x3cut0r/404:latest
```

### 1.2 docker-compose.yaml <a name="docker-compose"></a>

```shell
version: '3'

services:
  404:
    image: 3x3cut0r/404:latest
    environment:
        TZ: "Europe/Berlin"
        TITLE: "404 Not Found"
    ports:
      - 80:80
```

### 2 Environment Variables <a name="environment-variables"></a>

**for more information, see https://manpages.debian.org/testing/404/tftpd.8.en.html**

- `TZ` - Specifies the server timezone - **Default: UTC**
- `TITLE` - Specifies the website title - **Default: 404 Not Found**
- `LINK` - Hyper-Link to a Website on click **Default: https://404.3x3cut0r.de**
- `BG` - Background Color, has no effect by default - **Default: #141019**
- `BG-PRIMARY` - Color - **Default: #908392**
- `BG-SECONDARY` - Color - **Default: #0d060e**
- `GROUND-TOP` - Color - **Default: #2F1829**
- `GROUND-BOTTOM` - Color - **Default: #2F1829**
- `GROUND-RIGHT` - Color - **Default: #2F1829**
- `GROUND-LEFT` - Color - **Default: #2F1829**
- `NUMBER-LEFT-TOP` - Color - **Default: #3B223C**
- `NUMBER-LEFT-BOTTOM` - Color - **Default: #2F1829**
- `NUMBER-LEFT-REFLECTION` - Color - **Default: white**
- `NUMBER-MIDDLE-TOP` - Color - **Default: #3B223C**
- `NUMBER-MIDDLE-BOTTOM` - Color - **Default: #2F1829**
- `NUMBER-MIDDLE-LEAF-TOP` - Color - **Default: #2F1829**
- `NUMBER-MIDDLE-LEAF-BOTTOM` - Color - **Default: #3B223C**
- `NUMBER-RIGHT-TOP` - Color - **Default: #3B223C**
- `NUMBER-RIGHT-BOTTOM` - Color - **Default: #2F1829**
- `NUMBER-RIGHT-REFLECTION` - Color - **Default: white**
- `SHRUB-MIDDLE` - Color - **Default: #982245**
- `SHRUB-RIGHT` - Color - **Default: #982245**
- `SHRUB-LEFT` - Color - **Default: #982245**
- `LEAF-1` - Color - **Default: #FFADAE**
- `LEAF-2` - Color - **Default: #F3475C**
- `LEAF-3` - Color - **Default: #FFCA51**
- `LEAF-RIGHT` - Color - **Default: #2F1829**
- `LEAF-MIDDLE` - Color - **Default: #black**
- `LEAF-MIDDLE-RIGHT` - Color - **Default: #2F1829**
- `LEAF-MIDDLE-LEFT` - Color - **Default: #2F1829**
- `LEAF-LEFT` - Color - **Default: #black**
- `CLOUD-BG-TOP` - Color - **Default: #FEF5DA**
- `CLOUD-BG-BOTTOM` - Color - **Default: #E8D197**
- `CLOUD-BG-RIGHT` - Color - **Default: #FEF5DA**
- `CLOUD-BG-RIGHT-SHADOW` - Color - **Default: #E8D197**
- `CLOUD-BG-LEFT` - Color - **Default: #FEF5DA**
- `CLOUD-BG-LEFT-SHADOW` - Color - **Default: #E8D197**
- `CLOUD-RIGHT-TOP` - Color - **Default: white**
- `CLOUD-RIGHT-BOTTOM` - Color - **Default: white**
- `CLOUD-RIGHT-TOP-SHADOW` - Color - **Default: white**
- `CLOUD-LEFT-TOP` - Color - **Default: white**
- `CLOUD-LEFT-BOTTOM` - Color - **Default: white**
- `CLOUD-LEFT-TOP-SHADOW` - Color - **Default: white**
- `MAN-HAIR` - Color - **Default: #2F172B**
- `MAN-SHIRT` - Color - **Default: #FFCA51**
- `MAN-SLEEVE-LEFT` - Color - **Default: #2F1829**
- `MAN-SLEEVE-RIGHT` - Color - **Default: #2F1829**
- `MAN-PANTS` - Color - **Default: #2F1829**
- `MAN-PANTS-LEFT` - Color - **Default: #4C3146**
- `MAN-PANTS-RIGHT` - Color - **Default: #4C3146**
- `MAN-SHOE-LEFT` - Color - **Default: #1F3247**
- `MAN-SHOE-LEFT-TOP` - Color - **Default: #122230**
- `MAN-SHOE-RIGHT` - Color - **Default: #1F3247**
- `MAN-FLASHLIGHT` - Color - **Default: #2F1829**
- `MAN-FLASHLIGHT-NEAR` - Color - **Default: white**
- `MAN-FLASHLIGHT-FAR` - Color - **Default: white**
- `MAN-FLASHLIGHT-SHADOW` - Color - **Default: white**
- `WOMAN-HAIR` - Color - **Default: #2F1829**
- `WOMAN-PONY` - Color - **Default: #2F1829**
- `WOMAN-SHIRT` - Color - **Default: #F5B539**
- `WOMAN-PANTS` - Color - **Default: #2F1829**
- `WOMAN-SHOE-LEFT` - Color - **Default: #1F3247**
- `WOMAN-SHOE-RIGHT` - Color - **Default: #1F3247**
- `WOMAN-SHOE-RIGHT-TOP` - Color - **Default: white**
- `WOMAN-FLASHLIGHT` - Color - **Default: #2F1829**
- `WOMAN-FLASHLIGHT-NEAR` - Color - **Default: white**
- `WOMAN-FLASHLIGHT-FAR` - Color - **Default: white**

### 3 Volumes <a name="volumes"></a>

- `/usr/share/nginx/html` - nginx root directory

### 4 Ports <a name="ports"></a>

- `80/tcp` - HTTP Port

### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
