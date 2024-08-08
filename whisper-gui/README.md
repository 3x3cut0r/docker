# whisper-gui

**whisper-gui - a GUI for OpenAI's Whisper**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/whisper-gui)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/whisper-gui)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/whisper-gui)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/whisper-gui.yml?branch=main)

## Index

1. [Usage](#usage)
2. [Find Me](#findme)
3. [License](#license)

## 1 Usage <a name="usage"></a>

### 1.1 docker-compose.yml <a name="docker-compose"></a>

```shell
version: '3.9'

# https://github.com/Pikurrot/whisper-gui
services:
  # https://hub.docker.com/r/3x3cut0r/whisper-gui
  whisper-gui:
    container_name: whisper-gui
    image: 3x3cut0r/whisper-gui:latest
    restart: unless-stopped
    ports:
      - '7860:7860'
    volumes:
      - whisper-gui-data:/whisper-gui/outputs

volumes:
  whisper-gui-data:
    name: whisper-gui-data

```

### 2 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-julianreith%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 3 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
``
