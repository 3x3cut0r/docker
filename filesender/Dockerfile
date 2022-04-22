FROM php:7.4-fpm-alpine3.15
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="FileSender: send large files securely and encrypted (on alpine)"

# build args
ARG REF=2.31
ARG REF_SUM=""
ARG SSP_REF=1.19.5
ARG SSP_SUM="ab1a71a4eed2c086774829d47ce72137e4d1a7bd6b8a2535b4a1ddfd6e7da51f"

ENV FILESENDER_VERSION=$REF \
    FILESENDER_SUM=$REF_SUM \
    SSP_VERSION=$SSP_REF \
    SSP_SUM=$SSP_REF_SUM

# Install needed extensions
COPY --from=mlocati/php-extension-installer:1.5.10 /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions pdo_mysql pdo_pgsql

# Get dependencies
RUN apk add --no-cache --virtual .filesender-deps \
    patch

# Get software in
RUN mkdir /opt/filesender && \
    cd /opt/filesender && \
    curl -kL https://github.com/filesender/filesender/archive/master-filesender-${FILESENDER_VERSION}.tar.gz | tar xz && \
    ln -s filesender-master-filesender-${FILESENDER_VERSION} filesender && \
    curl -L https://github.com/simplesamlphp/simplesamlphp/releases/download/v${SSP_VERSION}/simplesamlphp-${SSP_VERSION}.tar.gz | tar xz && \
    ln -s simplesamlphp-${SSP_VERSION} simplesamlphp && \
    rm -f filesender-master-filesender-${FILESENDER_VERSION}.tar.gz simplesamlphp-${SSP_VERSION}.tar.gz

# Run basic install steps from application manual
RUN cd /opt/filesender/filesender && \
    cp config/config_sample.php config/config.php && \
    mkdir -p tmp files log && \
    chmod o-rwx tmp files log config/config.php && \
    chown www-data:www-data tmp files log && \
    chgrp www-data config/config.php && \
    cd /opt/filesender/simplesamlphp && \
    cp -r config-templates/*.php config/ && \
    cp -r metadata-templates/*.php metadata/

# Specialize: Configs are in /config, Data is in /data
RUN mkdir -p /config/fpm /config/filesender /config/simplesamlphp/config /config/simplesamlphp/metadata /data && \
    mv -f /usr/local/etc/php-fpm.d/www.conf /config/fpm/www.conf && \
    mv -f /opt/filesender/filesender/config /config/filesender && \
    rm -Rf /opt/filesender/filesender/files /opt/filesender/filesender/tmp /opt/filesender/filesender/log && \
    mv -f /opt/filesender/simplesamlphp/config/*.php /config/simplesamlphp/config/ && \
    mv -f /opt/filesender/simplesamlphp/metadata/*.php /config/simplesamlphp/metadata/ && \
    ln -s /config/fpm/www.conf /usr/local/etc/php-fpm.d/filesender.conf && \
    ln -s /config/filesender/config /opt/filesender/filesender/config && \
    ln -s /config/simplesamlphp/config/acl.php /opt/filesender/simplesamlphp/config/acl.php && \
    ln -s /config/simplesamlphp/config/authsources.php /opt/filesender/simplesamlphp/config/authsources.php && \
    ln -s /config/simplesamlphp/config/config.php /opt/filesender/simplesamlphp/config/config.php && \
    mkdir /data/files /data/tmp /data/log && \
    ln -s /data/files /opt/filesender/filesender/files && \
    ln -s /data/tmp /opt/filesender/filesender/tmp && \
    ln -s /data/log /opt/filesender/filesender/log && \
    chown -R www-data:www-data /data/tmp /data/log /data/files && \
    ln -s /config/simplesamlphp/metadata/active.php /opt/filesender/simplesamlphp/metadata/active.php && \
    cp /opt/filesender/filesender/scripts/simplesamlphp/passwordverify/PasswordVerify.php /opt/filesender/simplesamlphp/modules/sqlauth/lib/Auth/Source/ && \
    cd /opt/filesender/simplesamlphp && patch -p1 < /opt/filesender/filesender/scripts/simplesamlphp/passwordverify/patch-to-simplesamlphp.patch && cd -

# Get common tools
RUN apk -U upgrade && \
    apk add --no-cache nginx runit netcat-openbsd msmtp vim nano && \
    apk del --no-network .filesender-deps && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

COPY --chown=root:root --chmod=0755 assets /

RUN chown -R www-data:www-data /opt/filesender && \
    chmod -R a+x \
      /etc/nginx \
      /etc/service \
      /usr/local/ \
      /setup.sh \
      /docker-entrypoint.sh

VOLUME ["/opt/filesender"]
VOLUME ["/config"]
VOLUME ["/data"]

EXPOSE 80 443 9000

ENTRYPOINT ["/docker-entrypoint.sh"]

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer="Julian Reith <JulianReith@gmx.de>" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.docker.dockerfile="/docker/Dockerfile" \
      org.label-schema.license="BSD3" \
      org.label-schema.name="Filesender and SimpleSamlPHP on php7-fpm-alpine" \
      org.label-schema.vendor="filesender" \
      org.label-schema.url="https://filesender.org" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/filesender/filesender.git" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.version="${REF}" \
      org.label-schema.schema-version="1.0"
