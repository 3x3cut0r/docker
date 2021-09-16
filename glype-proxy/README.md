# glype-proxy

**glype - a web-based proxy on webdevops/php-nginx:7.4-alpine**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/glype-proxy)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/glype-proxy)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/glype-proxy)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20glype-proxy)

`GitHub` - 3x3cut0r/glype-proxy - https://github.com/3x3cut0r/docker/tree/main/glype-proxy  
`DockerHub` - 3x3cut0r/glype-proxy - https://hub.docker.com/r/3x3cut0r/glype-proxy  

## Documentation

`GitHub` - vincentclee/glype - https://github.com/vincentclee/glype  

## Index

1. [Usage](#usage)  
  1.1 [docker run](#dockerrun)  
2. [admin page](#admin-page)  
3. [Volumes](#volumes)  
4. [Ports](#ports)  
5. [Find Me](#findme)  
6. [License](#license)  

## 1 Usage <a name="usage"></a>

### 1.1 docker run <a name="dockerrun"></a>

**it is highly recommended to use this image behind a reverse proxy!!!**  
```shell
docker container run -d --restart=unless-stopped \
    --name=glype-proxy \
    -p 80:80 \
    3x3cut0r/glype-proxy:latest
```

### 2 admin page <a name="admin-page"></a>
Visit the URL of your Glype Admin Control Panel (i.e. http://www.domain.com/admin.php)  
Set the desired options and save your settings.  

### 3 Volumes <a name="volumes"></a>

* `/var/www/html` - nginx root directory

### 4 Ports <a name="ports"></a>

* `80/tcp` - HTTP Port  

### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
