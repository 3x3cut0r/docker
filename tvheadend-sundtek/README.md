# tvheadend-sundtek

**tvheadend from linuxserver/tvheadend with Sundtek SkyTV Ultimate drivers**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/tvheadend-sundtek)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/tvheadend-sundtek)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/tvheadend-sundtek)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/3x3cut0r/docker/build%20tvheadend-sundtek)

`GitHub` - 3x3cut0r/tvheadend-sundtek - https://github.com/3x3cut0r/docker/tree/main/tvheadend-sundtek  
`DockerHub` - 3x3cut0r/tvheadend-sundtek - https://hub.docker.com/r/3x3cut0r/tvheadend-sundtek  

## Documentation

`GitHub` - linuxserver/docker-tvheadend - https://github.com/linuxserver/docker-tvheadend  
`DockerHub` - linuxserver/tvheadend - https://hub.docker.com/r/linuxserver/tvheadend  

## Usage for Synology Users

### docker run

```shell
docker container run -d --restart unless-stopped \
    --name tvheadend \
    --network tvheadend-net \
    -e PUID=1024 \
    -e PGID=100 \
    -e TZ=Europe/Berlin \
    -p 9981:9981 \
    -p 9982:9982 \
    -v /volume1/video/recordings/tvheadend:/recordings \
    -v /volume1/docker/tvheadend/config:/config \
    -v /volume1/docker/tvheadend/picons:/picons \
    -v /etc/localtime:/etc/localtime:ro \
    --device /dev/dri:/dev/dri \
    --device /dev/dvb:/dev/dvb \
    --device=/dev/bus/usb \
    3x3cut0r/tvheadend-sundtek:latest
```

## Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)
