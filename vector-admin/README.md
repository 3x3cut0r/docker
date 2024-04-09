# Vector Admin

**Vector Admin - The universal UI and tool suite for managing vector databases at scale.**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/vector-admin)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/vector-admin)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/vector-admin)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/vector-admin.yml?branch=main)

`GitHub` - 3x3cut0r/vector-admin - https://github.com/3x3cut0r/docker/tree/main/vector-admin  
`DockerHub` - 3x3cut0r/vector-admin - https://hub.docker.com/r/3x3cut0r/vector-admin

![vector-admin](https://github.com/3x3cut0r/docker/assets/1408580/4a71e799-82f8-4802-8a1f-d9361adb1bfd)

## Documentation

`GitHub` - Mintplex-Labs/vector-admin - https://github.com/Mintplex-Labs/vector-admin  
`Docs - Docker` - Mintplex-Labs/vector-admin/docker - https://github.com/Mintplex-Labs/vector-admin/blob/master/docker/DOCKER.md  
`Docs` - docs.vector-admin.dev - https://docs.vectoradmin.com/

## Index

1. [Usage](#usage)  
   1.1 [docker-compose.yaml](#docker-compose)
2. [Environment Variables](#environment-variables)
3. [Volumes](#volumes)
4. [Ports](#ports)
5. [Find Me](#findme)
6. [License](#license)

## 1 Usage <a name="usage"></a>

### 1.1 docker-compose.yml <a name="docker-compose"></a>

**replace `<POSTGRES_PASSWORD>`, `<JWT_SECRET>` and `<INNGEST_SIGNING_KEY>` with `random strings`**

```shell
version: '3.9'

# https://github.com/Mintplex-Labs/vector-admin
services:
  # https://hub.docker.com/r/3x3cut0r/vector-admin
  # https://github.com/Mintplex-Labs/vector-admin/tree/master/docker
  vector-admin:
    container_name: vector-admin
    image: 3x3cut0r/vector-admin:latest
    restart: unless-stopped
    ports:
      - '2138:3001'
      - '3355:3355'
      - '8288:8288'
    environment: # https://github.com/Mintplex-Labs/vector-admin/blob/master/docker/.env.example
      SERVER_PORT: 3001
      DATABASE_CONNECTION_STRING: 'postgresql://vectoradmin:<POSTGRES_PASSWORD>@postgres:5432/vectoradmin'
      JWT_SECRET: '<JWT_SECRET>'
      INNGEST_EVENT_KEY: 'background_workers'
      INNGEST_SIGNING_KEY: '<INNGEST_SIGNING_KEY>'
      INNGEST_LANDING_PAGE: 'true'
    volumes:
      #   - "./.env:/app/backend/.env"
      - vector-admin-data:/app/backend/storage
      - vector-admin-hotdir:/app/document-processor/hotdir
    depends_on:
      - postgres

  # https://hub.docker.com/_/postgres
  postgres:
    container_name: postgres
    image: postgres:16-alpine
    restart: always
    # ports:
    #   - 5432:5432
    volumes:
      - vector-admin-postgres:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: 'vectoradmin'
      POSTGRES_PASSWORD: '<POSTGRES_PASSWORD>'
      POSTGRES_DB: 'vectoradmin'

volumes:
  vector-admin-postgres:
    name: vector-admin-postgres
  vector-admin-data:
    name: vector-admin-data
  vector-admin-hotdir:
    name: vector-admin-hotdir

```

### 2 Environment Variables <a name="environment-variables"></a>

**you can also provide a .env file, see [.env.example](https://github.com/Mintplex-Labs/vector-admin/blob/master/docker/.env.example)**

- `SERVER_PORT` - Port of the vector-admin dashboard. Keep it default - **Default: 3001**
- `DATABASE_CONNECTION_STRING` - specify the connection-string to your postgres database
- `JWT_SECRET` - Specifies the Java Web Token. Choose a random string
- `INNGEST_SIGNING_KEY` - Specifies the inngest signing key. Choose a random string
- `INNGEST_EVENT_KEY` - Specifies the inngest key event - **Default: background_workers**
- `INNGEST_LANDING_PAGE` - Turns the landing page on and off - **Default: true**

### 3 Volumes <a name="volumes"></a>

- `/app/backend/storage` - Directory for the storage
- `/app/document-processor/hotdir` - Directory for document-processor

### 4 Ports <a name="ports"></a>

- `3001/tcp` - HTTP Port

### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-julianreith%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
``
