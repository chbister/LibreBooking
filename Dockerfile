FROM webdevops/php-apache:8.4-alpine

#ENV WEB_DOCUMENT_ROOT=/app/Web \
#    WEB_DOCUMENT_INDEX=index.php

WORKDIR /app

COPY . /app

RUN apk add --no-cache git \
    && mkdir -p /config \
    && cp config/config.dist.php /config/config.dist.php \
    && composer install \
         --no-dev \
         --no-interaction \
         --optimize-autoloader \
         --working-dir=/app \
    && mkdir -p Web/uploads/images Web/uploads/reservation tpl_c \
    && chown -R application:application /app /config

RUN mkdir -p /var/log/librebooking/log \
    && chown -R application:application /var/log/librebooking

VOLUME ["/config", "/app/Web/uploads/images", "/app/Web/uploads/reservation"]

#USER application
