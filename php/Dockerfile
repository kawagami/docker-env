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

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

USER $user