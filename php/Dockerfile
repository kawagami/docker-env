# php-fpm.dockerfile
FROM php:8.2-fpm-alpine

RUN set -ex && \
    apk --no-cache add \
        bash \
        postgresql-dev \
        curl \
        nodejs \
        npm \
        yarn

RUN docker-php-ext-install pdo pdo_pgsql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
