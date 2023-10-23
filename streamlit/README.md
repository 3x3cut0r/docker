# streamlit

**Streamlit - an open-source app framework for Machine Learning and Data Science teams**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/streamlit)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/streamlit)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/streamlit)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/streamlit.yml?branch=main)

`GitHub` - 3x3cut0r/streamlit - https://github.com/3x3cut0r/docker/tree/main/streamlit  
`DockerHub` - 3x3cut0r/streamlit - https://hub.docker.com/r/3x3cut0r/streamlit

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

**your streamlit app folder must contain a 'streamlit_app.py' as the main streamlit app**

```shell
docker run -d \
    --name streamlit \
    -e TZ="Europe/Berlin" \
    -v /path/of/your/streamlit/app/folder:/app \
    -p 8501:8501/tcp \
    3x3cut0r/streamlit:latest
```

### 1.2 docker-compose.yml <a name="docker-compose"></a>

**your streamlit app folder must contain a 'streamlit_app.py' as the main streamlit app**

```shell
version: '3'

services:
  streamlit:
    image: 3x3cut0r/streamlit
    environment:
        TZ: Europe/Berlin
    volumes:
      - /path/of/your/streamlit/app/folder:/app
    ports:
      - 8501:8501/tcp
```

### 2 Environment Variables <a name="environment-variables"></a>

**for more information, see https://manpages.debian.org/testing/streamlit/tftpd.8.en.html**

- `TZ` - Specifies the server timezone - **Default: UTC**
- `PORT` - Specifies port number - **Default: 8501**

### 3 Volumes <a name="volumes"></a>

- `/app` - streamlit app directory -> **your streamlit app folder must contain a 'streamlit_app.py' as the main streamlit app**

### 4 Ports <a name="ports"></a>

- `8501/tcp` - HTTP Port

### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
