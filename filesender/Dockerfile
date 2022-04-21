FROM php:7.4-fpm-buster

ENV FILESENDER_VERSION=2.31 \
    FILESENDER_SUM="ef6da83e7ac46303e5f8d620f6858565fd746d7c4b054a12439a561d79b515a2" \
    SSP_VERSION=1.19.1 \
    SSP_SUM="19e3860eff63f2367579b9ee5c2b7b609d7d17daacacd3e04823ddf599124747"

# Install needed extensions
COPY --from=mlocati/php-extension-installer:1.2.23 /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions pdo_mysql pdo_pgsql

# Get software in
RUN cd /opt && mkdir filesender && \
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

# Specialise: Configs are in /config, Data is in /data
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

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends nginx runit netcat-traditional msmtp-mta && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/service

COPY assets /

VOLUME ["/opt/filesender"]
VOLUME ["/config/fpm", "/config/filesender", "/config/simplesamlphp/config", "/config/simplesamlphp/metadata"]
VOLUME ["/data"]

EXPOSE 80 443 9000

RUN chmod 755 /usr/local/sbin/runsvdir-init

CMD ["/usr/local/sbin/runsvdir-init"]

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer="Nils Vogels <n.vogels@aves-it.nl>" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.docker.dockerfile="/docker/Dockerfile" \
      org.label-schema.license="BSD3" \
      org.label-schema.name="Filesender and SimpleSamlPHP on php7-fpm" \
      org.label-schema.vendor="Aves IT" \
      org.label-schema.url="https://filesender.org" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/filesender/filesender.git" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.version="2.22" \
      org.label-schema.schema-version="1.0"
