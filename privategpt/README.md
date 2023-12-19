# PrivateGPT

**PrivateGPT is a production-ready AI project that allows you to ask questions about your documents using the power of Large Language Models (LLMs), even in scenarios without an Internet connection. 100% private, no data leaves your execution environment at any point.**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/privategpt)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/privategpt)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/privategpt)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/privategpt.yml?branch=main)

`GitHub` - 3x3cut0r/privategpt - https://github.com/3x3cut0r/docker/tree/main/privategpt  
`DockerHub` - 3x3cut0r/privategpt - https://hub.docker.com/r/3x3cut0r/privategpt

![privategpt](https://github.com/3x3cut0r/docker/assets/1408580/39d4e5ed-4a5c-4ea5-8b78-83a8c4c2df9b)

## Documentation

`GitHub` - imartinez/privateGPT - https://github.com/imartinez/privateGPT  
`Docs` - docs.privategpt.dev - https://docs.privategpt.dev/

## Index

1. [Usage](#usage)  
   1.1 [docker run](#dockerrun)  
   1.2 [docker-compose.yaml](#docker-compose)  
   1.3 [docker-compose.yaml with custom model](#docker-compose-custom)
2. [Environment Variables](#environment-variables)
3. [Volumes](#volumes)
4. [Ports](#ports)
5. [Find Me](#findme)
6. [License](#license)

## 1 Usage <a name="usage"></a>

### 1.1 docker run <a name="dockerrun"></a>

```shell
docker run -d \
    --name privategpt \
    -p 8080:8080/tcp \
    3x3cut0r/privategpt:latest
```

### 1.2 docker-compose.yml <a name="docker-compose"></a>

```shell
version: '3.9'

services:
  # https://hub.docker.com/r/3x3cut0r/privategpt
  privategpt:
    image: 3x3cut0r/privategpt:latest
    container_name: privategpt
    ports:
      - 8080:8080/tcp
```

### 1.3 docker-compose.yml with custom model <a name="docker-compose-custom"></a>

```shell
version: '3.9'

services:
  # https://hub.docker.com/r/3x3cut0r/privategpt
  privategpt:
    image: 3x3cut0r/privategpt:latest
    container_name: privategpt
    environment:
      PGPT_HF_MODEL_FILE: "dolphin-2.2.1-mistral-7b.Q4_K_M.gguf"
    volumes:
      - /path/to/your/model/dolphin-2.2.1-mistral-7b.Q4_K_M.gguf:/home/worker/app/models/dolphin-2.2.1-mistral-7b.Q4_K_M.gguf
    ports:
      - 8080:8080/tcp
```

### 2 Environment Variables <a name="environment-variables"></a>

- `KEEP_FILES` - Specifies if the server should keep uploaded files after restarting the container - **True /False, Default: False**
- `PGPT_HF_MODEL_FILE` - Specifies the llm model. If set, you need to mount your own llm to /home/worker/app/models - **Default: mistral-7b-instruct-v0.2.Q4_K_M.gguf**
- `LOGO_BG_COLOR` - Specifies the logo background color - **Default: #C7BAFF**
- `LOGO_HEIGHT` - Specifies the logo height - **Default: 25%**
- `LOGO_SVG_BASE64` - Specifies the logo file (.svg) in base64 format. Provide your own file (.svg) in base64 format using an [image to base64 converter](https://base64.guru/converter/encode/image) - **Default: \<privategpt svg logo\>**

### 3 Volumes <a name="volumes"></a>

- `/home/worker/app/local_data` - directory for uploaded files. contains private data! will be deleted if KEEP_FILES=False
- `/home/worker/app/models` - directory for custom llm models. mount your own model here and set environment variable PGPT_HF_MODEL_FILE

### 4 Ports <a name="ports"></a>

- `8080/tcp` - HTTP Port

### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-julianreith%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
