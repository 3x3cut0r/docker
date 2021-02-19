# rootless docker

**install docker in rootless mode on debian 10 vm in virtualbox**

## Usage

**run first time: install prerequisites as root**  
ssh docker@docker-host  
su -  
```shell
apt install wget -y
wget https://raw.githubusercontent.com/3x3cut0r/docker/main/.docker_rootless_vbox/docker_rootless.sh
chmod +x docker_rootless.sh
./docker_rootless.sh
```

**run second time: install docker as docker**  
ssh docker@docker-host
```shell
./docker_rootless.sh install
```

## Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)
