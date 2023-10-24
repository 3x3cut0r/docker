# streamlit

**Streamlit - an open-source app framework for Machine Learning and Data Science teams**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/streamlit)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/streamlit)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/streamlit)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/streamlit.yml?branch=main)

`GitHub` - 3x3cut0r/streamlit - https://github.com/3x3cut0r/docker/tree/main/streamlit  
`DockerHub` - 3x3cut0r/streamlit - https://hub.docker.com/r/3x3cut0r/streamlit

## Index

1. [Configuration](#config)  
   1.1 [streamlit_app.py](#streamlit_app.py)  
   1.2 [requirements.txt](#requirements.txt)  
   1.3 [.streamlit/config.toml](#config.toml)
2. [Usage](#usage)  
   2.1 [docker run](#dockerrun)  
   2.2 [docker-compose.yaml](#dockercompose)
3. [Environment Variables](#environment-variables)
4. [Volumes](#volumes)
5. [Ports](#ports)
6. [Find Me](#findme)
7. [License](#license)

## 1 Configuration <a name="config"></a>

### 1.1 streamlit_app.py <a name="streamlit_app.py"></a>

**your streamlit app folder must contain a <ins>'streamlit_app.py'</ins> as the main streamlit app!**

**streamlit_app.py**

```python
import streamlit as st
st.title("This is my Streamlit app")
...
```

### 1.2 requirements.txt <a name="requirements.txt"></a>

**if your streamlit app needs special python dependencies, your streamlit app folder must contain a <ins>'requirements.txt'</ins> with each dependency in one line. e.g.:**

**requirements.txt**

```
tensorflow
uvicorn==0.12.2
fastapi>=0.63.0
```

### 1.3 .streamlit/config.toml <a name="config.toml"></a>

**if your streamlit app needs special configuration options, your streamlit app folder should contain a <ins>'.streamlit'</ins> folder with a <ins>'config.toml'</ins> file. e.g.:**

**.streamlit/config.toml, visit [Streamlit Documentation - Configuration](https://docs.streamlit.io/library/advanced-features/configuration) for more information**

```
[server]
enableCORS=false
enableStaticServing = true
enableXsrfProtection=false

[browser]
gatherUsageStats = false
```

## 2 Usage <a name="usage"></a>

### 2.1 docker run <a name="dockerrun"></a>

**your streamlit app folder must contain a 'streamlit_app.py' as the main streamlit app**

```shell
docker run -d \
    --name streamlit \
    -e TZ="Europe/Berlin" \
    -v /path/of/your/streamlit/app:/app \
    -p 8501:8501/tcp \
    3x3cut0r/streamlit:latest
```

### 2.2 docker-compose.yml <a name="docker-compose"></a>

**your streamlit app folder must contain a 'streamlit_app.py' as the main streamlit app**

```shell
version: '3'

services:
  streamlit:
    image: 3x3cut0r/streamlit
    environment:
        TZ: Europe/Berlin
    volumes:
      - /path/of/your/streamlit/app:/app
    ports:
      - 8501:8501/tcp
```

### 3 Environment Variables <a name="environment-variables"></a>

- `TZ` - Specifies the server timezone - **Default: UTC**
- `PORT` - Specifies port number - **Default: 8501**

### 4 Volumes <a name="volumes"></a>

- `/app` - streamlit app directory -> **your streamlit app folder must contain a 'streamlit_app.py' as the main streamlit app**

### 5 Ports <a name="ports"></a>

- `8501/tcp` - HTTP Port

### 6 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 7 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
