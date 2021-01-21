# tftp-hpa (tftpd)

A lightweight tftp-server (tftp-hpa)

GitHub: https://github.com/3x3cut0r/docker/tree/main/tftp-hpa

DockerHub: https://hub.docker.com/r/3x3cut0r/tftp-hpa

### Usage

```shell
docker run -d \
    --name tftp-hpa \
    -v /path/of/some/file:/tftpboot/file:ro \
    -p 69:69/udp \
    3x3cut0r/tftp-hpa:latest
```

#### Environment Variables

* `USER` `tftp` - Username who owns the in.tftpd process
* `UID` `9069`- User-ID of the USER
* `GID` `9069`- Group-ID of the USER
* `TFTP_ROOT` `"/tftpboot"` - Path of the tftp-root

#### Volumes

* `/tftpboot` - TFTP_ROOT

#### Ports

* `69/udp` - TFTP Port

## Find Me

* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

## License

This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
