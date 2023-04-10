# tvheadend-sundtek

**tvheadend from linuxserver/tvheadend with Sundtek drivers**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/tvheadend-sundtek)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/tvheadend-sundtek)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/tvheadend-sundtek)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/tvheadend-sundtek.yml?branch=main)

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
    --network tvheadend \
    -e PUID=1024 \
    -e PGID=100 \
    -e TZ="Europe/Berlin" \
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

### docker compose

**check volumes! these must exist!**

```shell
version: "3.9"

# https://hub.docker.com/r/linuxserver/tvheadend
services:
  # https://hub.docker.com/repository/docker/3x3cut0r/tvheadend-sundtek
    tvheadend:
        container_name: tvheadend
        image: 3x3cut0r/tvheadend-sundtek:latest
        restart: unless-stopped
        ports:
            - "9981:9981"
            - "9982:9982"
        networks:
            tvheadend:
                ipv4_address: 10.24.20.2
        dns:
            - 8.8.8.8
            - 8.8.4.4
            - 2001:4860:4860::8888
            - 2001:4860:4860::8844
        environment:
            TZ: "Europe/Berlin"
            PUID: "1024"
            PGID: "100"
        volumes:
            - /etc/localtime:/etc/localtime:ro
            - /volume1/docker/tvheadend/config:/config
            - /volume1/docker/tvheadend/picons:/picons
            - /volume1/docker/tvheadend/sundtek:/sundtek # for sundtek usb devices only
            - /volume1/video/recordings/tvheadend:/recordings # optional for recordings
        devices:
            - /dev/dri:/dev/dri
            - /dev/dvb:/dev/dvb
            - /dev/bus/usb

networks:
    tvheadend:
        name: tvheadend
        ipam:
            driver: default
            config:
                - subnet: "10.24.20.0/24"
                  gateway: 10.24.20.1

```

## Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)
