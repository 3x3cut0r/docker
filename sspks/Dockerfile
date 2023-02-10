FROM composer:2.5.1
LABEL maintainer="Julian Reith <julianreith@gmx.de>"

USER root

RUN mkdir -p /var/www/localhost/htdocs \
 && wget https://github.com/jdel/sspks/archive/refs/heads/master.tar.gz \
 && tar -xvf master.tar.gz --strip 1 -C /var/www/localhost/htdocs \
 && rm master.tar.gz

RUN apk update && apk add --no-cache ca-certificates curl apache2 php81-apache2 php81-phar php81-ctype php81-json \
 && apk add --virtual=.build-dependencies openssl php81 php81-openssl php81-iconv php81-mbstring git \
 && ln -sf /usr/bin/php81 /usr/local/bin/php \
 && rm -f /var/www/localhost/htdocs/index.html \
 && curl -sSL https://getcomposer.org/download/2.5.1/composer.phar -o /usr/local/bin/composer \
 && chmod +x /usr/local/bin/composer \
 && cd /var/www/localhost/htdocs \
 && composer install --no-dev \
 && rm -f /usr/local/bin/composer \
 && apk del .build-dependencies \
 && rm -rf /var/cache/apk/* \
 && mkdir -p /run/apache2 \
 && sed -i 's/Listen 80/Listen 8080/' /etc/apache2/httpd.conf \
 && sed -i 's/^variables_order = "GPCS"/variables_order = "EGPCS"/' /etc/php81/php.ini \
 && ln -sf /dev/stdout /var/log/apache2/access.log \
 && ln -sf /dev/stderr /var/log/apache2/error.log \
 && ln -sf /var/www/localhost/htdocs/packages /packages \
 && ln -sf /var/www/localhost/htdocs/cache /cache

EXPOSE 8080
VOLUME "/packages"
VOLUME "/cache"
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
