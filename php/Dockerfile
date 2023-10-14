# php-fpm.dockerfile
FROM php:8.2-fpm-alpine

# Arguments defined in docker-compose.yml
ARG user
ARG uid

RUN set -ex && \
    apk --no-cache add \
        bash \
        postgresql-dev \
        curl \
        nodejs \
        npm \
        shadow \
        yarn

RUN docker-php-ext-install pdo pdo_pgsql

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 在此將設置的 php.ini 檔案放入 image 中
# 或是用 volume 的方式放進 container
# COPY php.ini-development /usr/local/etc/php/php.ini
# COPY php.ini /usr/local/etc/php8/php.ini

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

USER $user