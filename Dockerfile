FROM webdevops/php-nginx:8.2-alpine

ENV WEB_DOCUMENT_ROOT=/var/www/html/Web \
    WEB_DOCUMENT_INDEX=index.php

WORKDIR /var/www/html

COPY . /var/www/html

RUN apk add --no-cache git \
    && mkdir -p /config \
    && cp config/config.dist.php /config/config.dist.php \
    && composer install \
         --no-dev \
         --no-interaction \
         --optimize-autoloader \
         --working-dir=/var/www/html \
    && mkdir -p Web/uploads/images Web/uploads/reservation \
    && chown -R application:application /var/www/html /config \
    && chown -R application:application /var/www/html /tpl_c

RUN mkdir -p /var/log/librebooking/log \
    && chown -R application:application /var/log/librebooking

VOLUME ["/config", "/var/www/html/Web/uploads/images", "/var/www/html/Web/uploads/reservation"]

#USER application
