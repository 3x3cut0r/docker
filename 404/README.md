# 404 Not Found - by uiswarup

**a nginx based 404 Not Found error page - based on https://codepen.io/uiswarup/pen/dyoyLOp**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/404)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/404)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/404)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/404.yml?branch=main)

`GitHub` - 3x3cut0r/404 - https://github.com/3x3cut0r/docker/tree/main/404  
`DockerHub` - 3x3cut0r/404 - https://hub.docker.com/r/3x3cut0r/404

`CodePen` - uiswarup/pen/dyoyLOp - https://codepen.io/uiswarup/pen/dyoyLOp

## Example

![404.gif](https://github.com/3x3cut0r/docker/raw/main/404/404.gif)

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

**Example 2 - specify title and link:**

```shell
docker run -d \
    --name 404 \
    -e TITLE="404 Not Found" \
    -e LINK="https://404.example.com" \
    -p 80:80 \
    3x3cut0r/404:latest
```

**Example 3 - override favicon:**

```shell
docker run -d \
    --name 404 \
    -p 80:80 \
    -v /path/to/your/favicon.ico:/usr/share/nginx/html/logo/favicon.ico \
    3x3cut0r/404:latest
```

**Example 4 - change some colors:**

```shell
docker run -d \
    --name 404 \
    -e BG_PRIMARY="red" \
    -p 80:80 \
    3x3cut0r/404:latest
```

### 1.2 docker-compose.yaml <a name="docker-compose"></a>

```shell
version: '3'

services:
  '404':
    image: 3x3cut0r/404:latest
    environment:
        TZ: "Europe/Berlin"
        TITLE: "404 Not Found"
        LINK: "https://404.example.com"
    ports:
      - 80:80
```

### 2 Environment Variables <a name="environment-variables"></a>

- `TZ` - Specifies the server timezone - **Default: UTC**
- `TITLE` - Specifies the website title - **Default: 404 Not Found**
- `LINK` - Hyper-Link to a Website on click **Default: https://404.3x3cut0r.de**
- `BG` - Background Color, has no effect by default - **Default: #141019**
- `BG_PRIMARY` - Color - **Default: #908392**
- `BG_SECONDARY` - Color - **Default: #0d060e**
- `GROUND_TOP` - Color - **Default: #2F1829**
- `GROUND_BOTTOM` - Color - **Default: #2F1829**
- `GROUND_RIGHT` - Color - **Default: #2F1829**
- `GROUND_LEFT` - Color - **Default: #2F1829**
- `NUMBER_LEFT_TOP` - Color - **Default: #3B223C**
- `NUMBER_LEFT_BOTTOM` - Color - **Default: #2F1829**
- `NUMBER_LEFT_REFLECTION` - Color - **Default: white**
- `NUMBER_MIDDLE_TOP` - Color - **Default: #3B223C**
- `NUMBER_MIDDLE_BOTTOM` - Color - **Default: #2F1829**
- `NUMBER_MIDDLE_LEAF_TOP` - Color - **Default: #2F1829**
- `NUMBER_MIDDLE_LEAF_BOTTOM` - Color - **Default: #3B223C**
- `NUMBER_RIGHT_TOP` - Color - **Default: #3B223C**
- `NUMBER_RIGHT_BOTTOM` - Color - **Default: #2F1829**
- `NUMBER_RIGHT_REFLECTION` - Color - **Default: white**
- `SHRUB_MIDDLE` - Color - **Default: #982245**
- `SHRUB_RIGHT` - Color - **Default: #982245**
- `SHRUB_LEFT` - Color - **Default: #982245**
- `LEAF_1` - Color - **Default: #FFADAE**
- `LEAF_2` - Color - **Default: #F3475C**
- `LEAF_3` - Color - **Default: #FFCA51**
- `LEAF_RIGHT` - Color - **Default: #2F1829**
- `LEAF_MIDDLE` - Color - **Default: #black**
- `LEAF_MIDDLE_RIGHT` - Color - **Default: #2F1829**
- `LEAF_MIDDLE_LEFT` - Color - **Default: #2F1829**
- `LEAF_LEFT` - Color - **Default: #black**
- `CLOUD_BG_TOP` - Color - **Default: #FEF5DA**
- `CLOUD_BG_BOTTOM` - Color - **Default: #E8D197**
- `CLOUD_BG_RIGHT` - Color - **Default: #FEF5DA**
- `CLOUD_BG_RIGHT_SHADOW` - Color - **Default: #E8D197**
- `CLOUD_BG_LEFT` - Color - **Default: #FEF5DA**
- `CLOUD_BG_LEFT_SHADOW` - Color - **Default: #E8D197**
- `CLOUD_RIGHT_TOP` - Color - **Default: white**
- `CLOUD_RIGHT_BOTTOM` - Color - **Default: white**
- `CLOUD_RIGHT_TOP-SHADOW` - Color - **Default: white**
- `CLOUD_LEFT_TOP` - Color - **Default: white**
- `CLOUD_LEFT_BOTTOM` - Color - **Default: white**
- `CLOUD_LEFT_TOP-SHADOW` - Color - **Default: white**
- `MAN_HAIR` - Color - **Default: #2F172B**
- `MAN_SHIRT` - Color - **Default: #FFCA51**
- `MAN_SLEEVE-LEFT` - Color - **Default: #2F1829**
- `MAN_SLEEVE-RIGHT` - Color - **Default: #2F1829**
- `MAN_PANTS` - Color - **Default: #2F1829**
- `MAN_PANTS-LEFT` - Color - **Default: #4C3146**
- `MAN_PANTS-RIGHT` - Color - **Default: #4C3146**
- `MAN_SHOE_LEFT` - Color - **Default: #1F3247**
- `MAN_SHOE_LEFT_TOP` - Color - **Default: #122230**
- `MAN_SHOE_RIGHT` - Color - **Default: #1F3247**
- `MAN_FLASHLIGHT` - Color - **Default: #2F1829**
- `MAN_FLASHLIGHT_NEAR` - Color - **Default: white**
- `MAN_FLASHLIGHT_FAR` - Color - **Default: white**
- `MAN_FLASHLIGHT_SHADOW` - Color - **Default: white**
- `WOMAN_HAIR` - Color - **Default: #2F1829**
- `WOMAN_PONY` - Color - **Default: #2F1829**
- `WOMAN_SHIRT` - Color - **Default: #F5B539**
- `WOMAN_PANTS` - Color - **Default: #2F1829**
- `WOMAN_SHOE_LEFT` - Color - **Default: #1F3247**
- `WOMAN_SHOE_RIGHT` - Color - **Default: #1F3247**
- `WOMAN_SHOE_RIGHT_TOP` - Color - **Default: white**
- `WOMAN_FLASHLIGHT` - Color - **Default: #2F1829**
- `WOMAN_FLASHLIGHT_NEAR` - Color - **Default: white**
- `WOMAN_FLASHLIGHT_FAR` - Color - **Default: white**

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
