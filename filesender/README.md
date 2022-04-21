# filesender-phpfpm

- [Introduction](#introduction)
- [Dependencies](#dependencies)
- [Environment Variables](#environment-variables)
- [Deployment](#deployment)
  - [simplesamlphp](#simplesamlphp)

## Introduction
[Docker](https://www.docker.com/what-docker) image of [filesender](https://filesender.org) ran within [php-fpm](https://php-fpm.org/), especially tuned for consumption into Kubernetes. All images are based off of [debian](https://www.debian.org/) stable.

This is a follow-up of [ualibraries](https://github.com/ualibraries/filesender-phpfpm). Automated builds will be available at Docker hub.

This [release](https://github.com/filesender/filesender) of filesender can use [simplesamlphp](https://simplesamlphp.org/) or [shibboleth-sp](https://www.shibboleth.net/products/service-provider) for authentication. Questions directly related on using or configuring filesender should get posted to it's [mailinglist](https://sympa.uninett.no/lists/filesender.org/lists). This image pre-installs simplesamlphp. If you need shibboleth-sp, you can use this image as a base to install shibboleth. Please note all default configuration files assume simplesamlphp.

This docker image is not meant to run on its own, as it has some dependencies missing. Especially, this image only provides PHP-FPM with nginx, simplesamlphp and filesender installed.

## Dependencies
This container image of filesender requires the following dependencies:

###  Environmental dependencies
1. An (external) IP address
2. A (public) DNS entry
3. Sufficient storage capacity to store uploaded files for their lifetime`

### External services
1. An [smtp](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol) server to send emails. For example a third party SMTP service or a company email server could be used.
2. (optional) A [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy) that can handle FPM. Haproxy or Nginx would be suitable candidates
3. An [SSL certificate](https://nl.wikipedia.org/wiki/Transport_Layer_Security) to make the service available via https/ssl
4. A [database engine](https://en.wikipedia.org/wiki/Database_engine) to store application data in. Currently supported is mysql/pgsql.

All dependencies are provided using the [helm](https://helm.sh/) chart located in TODO

## Environment Variables

The following environment variables control the container setup:

## TODO: Make the following actually work
### Configuration

The following table lists the configurable parameters of the container and their default values.

|           Environment             |              Description                 |                          Default                        | 
| --------------------------------- | ---------------------------------------- | ------------------------------------------------------- |
| `FILESENDER_URL`                  | full URL to filesender service           | `https://localhost/`                                    |
| `FILESENDER_AUTHTYPE`             | Authentication for filesender, possible  |                                                         |
|                                   | values: shibboleth / saml / fake         | `saml`                                                  |
| `FILESENDER_AUTHSAML`             | Authentication type for simplesaml       |                                                         |
| `MAIL_ATTR`                       | Attributes. Value varies per AUTHTYPE    |                                                         |
| `NAME_ATTR`                       | simplesaml: SAML attribute               |                                                         |
| `UID_ATTR`                        | shibboleth: ENV variable name            |                                                         |
|                                   | fake: actual value                       |                                                         |
| `FILESENDER_STORAGE`              | Filesystem: Local fs storage             | `Filesystem`                                            |
|                                   | FilesystemChunked: File chunks locally   |                                                         |
|                                   | FilesystemPreserveName: Original filename|                                                         |
|                                   | on local fs                              |                                                         |
|                                   | FilesystemAzure: Azure blob *alpha*      |                                                         |
|                                   | FilesystemS3: AWS S3 storage *alpha*     |                                                         |
| `DB_TYPE`                         | Database type. Supports mysql or pgsql   | `pgsql`                                                 |
| `DB_HOST`                         | Database hostname to connect to          |                                                         |
| `DB_NAME`                         | Database name to use                     | `filesender`                                            |
| `DB_PORT`                         | Database port to connect to              | `3306 for mysql, 5432 for pgsql`                        |
| `DB_USER`                         | Database user to connect to the database | `filesender`                                            |
| `DB_PASSWORD`                     | Password for DB_USER                     |                                                         |
| `PHP_FPM_LISTEN`                  | Port for PHP FPM to listen to            | `9000`                                                  |
| `SMTP_SERVER`                     | SMTP server to send e-mail through       |                                                         |
| `SMTP_TLS`                        | SMTP server uses encrypted communication | `True`                                                  |
| `SMTP_USER`                       | optional user account for SMTP           |                                                         |
| `SMTP_PASSWORD`                   | optional password for SMTP               |                                                         |
| `CHOWN_WWW`                       | optional uid:gid value to run as         |                                                         |
| `ADMIN_EMAIL`                     | e-mail address for filesender admin      |                                                         |
| `ADMIN_USERS`                     | set of user identifiers that are admin   |                                                         |
| `ADMIN_PASSWORD`                  | Admin account password                   |                                                         |
| `SIMPLESAML_MODULES`              | Space seperated list of enabled modules  |                                                         |
| `SIMPLESAML_SALT`                 | optional simplesaml salt                 | auto-generated on first run if missing                  |

These variables are set using the [setup.sh](https://github.com/AvesIT/filesender-phpfpm/blob/master/docker/setup.sh) script, which runs in the filesender-phpfpm docker container the first time it starts up from the location /setup.sh.


