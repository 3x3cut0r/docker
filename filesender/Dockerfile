FROM php:7.4-fpm-alpine3.16
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="FileSender: send large files securely and encrypted (on alpine)"

# build args
ARG REF=2.40
ARG REF_SUM=""
ARG SSP_REF=2.0.3
ARG SSP_SUM="ca06d22d265fb75ee0f91d1e013db167dcc33ee449d03a81bd20160f899273cf"

ENV FILESENDER_VERSION=$REF \
    FILESENDER_SUM=$REF_SUM \
    SSP_VERSION=$SSP_REF \
    SSP_SUM=$SSP_REF_SUM

# install php extensions
COPY --from=mlocati/php-extension-installer:latest /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions pdo_mysql pdo_pgsql

# install dependencies & common tools
RUN apk -U upgrade && \
    apk add --no-cache  bash \
                        msmtp \
                        nano \
                        netcat-openbsd \
                        nginx \
                        patch \
                        runit \
                        vim

# download filesender
RUN cd /opt && \
    curl -kL https://github.com/filesender/filesender/archive/refs/tags/filesender-${FILESENDER_VERSION}.tar.gz | tar xz && \
    mv filesender-master-filesender-${FILESENDER_VERSION} filesender && \
    cd filesender && \
    mkdir -p files tmp log && \
    cp config/config_sample.php config/config.php && \
    cp config-templates/filesender-php.ini /usr/local/etc/php/php.ini

# download simplesamlphp
RUN cd /opt && \
    curl -L https://github.com/simplesamlphp/simplesamlphp/releases/download/v${SSP_VERSION}/simplesamlphp-${SSP_VERSION}.tar.gz | tar xz && \
    mv simplesamlphp-${SSP_VERSION} simplesamlphp && \
    cd simplesamlphp && \
    cp -r config-templates/*.php config/ && \
    cp -r metadata-templates/*.php metadata/ && \
    patch -p1 < /opt/filesender/scripts/simplesamlphp/passwordverify/patch-to-simplesamlphp.patch && \
    cp /opt/filesender/scripts/simplesamlphp/passwordverify/PasswordVerify.php modules/sqlauth/lib/Auth/Source/ && \
    touch data/sqlite.db

# copy config-templates and files
COPY assets /

# create docker specific folders
# /config/filesender
RUN mkdir -p /config/filesender/config /config/filesender/www && \
    cd /config/filesender && \
    cp /opt/filesender/config/config_sample.php config/config.php && \
    mv /opt/filesender/config/* /config/filesender/config/ && \
    rm -Rf /opt/filesender/config && \
    ln -s /config/filesender/config /opt/filesender/config && \
    cp /config/config-templates/filesender/www/favicon.ico www/favicon.ico && \
    ln -s /config/filesender/www/favicon.ico /opt/filesender/www/favicon.ico

# /config/simplesamlphp
RUN mkdir -p /config/simplesamlphp/config /config/simplesamlphp/metadata && \
    cd /config/simplesamlphp && \
    mv -f /opt/simplesamlphp/config/*.php config/ && \
    mv -f /opt/simplesamlphp/metadata/*.php metadata/ && \
    rm -rf /opt/simplesamlphp/config && \
    ln -s /config/simplesamlphp/config /opt/simplesamlphp/config && \
    rm -rf /opt/simplesamlphp/metadata && \
    ln -s /config/simplesamlphp/metadata /opt/simplesamlphp/metadata

# /config/fpm
RUN mkdir -p /config/fpm /run/php && \
    cd /config/fpm && \
    mv -f /usr/local/etc/php-fpm.d/www.conf filesender.conf && \
    echo "include=/config/fpm/*.conf" >> /usr/local/etc/php-fpm.conf

# /config/msmtp
RUN mkdir -p /config/msmtp/ssl/certs && \
    cd /config/msmtp && \
    cp /config/config-templates/msmtp/msmtprc .

# /data
RUN mkdir -p /data && \
    cd /data && \
    mkdir -p certs files tmp/simplesamlphp log data && \
    cd /opt/filesender && \
    rm -Rf certs files tmp log && \
    ln -s /data/certs /opt/filesender/certs && \
    ln -s /data/files /opt/filesender/files && \
    ln -s /data/tmp /opt/filesender/tmp && \
    ln -s /data/log /opt/filesender/log && \
    cd /opt/simplesamlphp && \
    rm -Rf certs files tmp log && \
    ln -s /data/certs /opt/simplesamlphp/certs && \
    ln -s /data/files /opt/simplesamlphp/files && \
    ln -s /data/tmp /opt/simplesamlphp/tmp && \
    ln -s /data/log /opt/simplesamlphp/log && \
    rm -Rf /opt/simplesamlphp/data && \
    touch /data/data/sqlite.db && \
    ln -s /data/data /opt/simplesamlphp/data

# /etc/nginx
RUN rm -rf /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# php-fpm
RUN rm -rf /usr/local/sbin/php-fpm-env && \
    ln -s /usr/local/lib/php-fpm-env/PhpFpmEnvironment.php /usr/local/sbin/php-fpm-env

# clean up
RUN apk del patch && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

VOLUME ["/config", "/data", "/opt/filesender", "/opt/simplesamlphp"]
EXPOSE 80 443

WORKDIR /config
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

ARG BUILD_DATE=$(date +"%Y-%m-%d")
ARG VCS_REF
LABEL maintainer="Julian Reith <JulianReith@gmx.de>" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.docker.dockerfile="/filesender/Dockerfile" \
      org.label-schema.license="BSD3" \
      org.label-schema.name="Filesender and SimpleSamlPHP on php7-fpm-alpine" \
      org.label-schema.vendor="filesender" \
      org.label-schema.url="https://filesender.org" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/filesender/filesender.git" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.version="${REF}" \
      org.label-schema.schema-version="1.0"
