#!/bin/sh

# install laravel project
# docker run --user 1000:1000 --rm -v $PWD:/app -w /app composer create-project laravel/laravel && \
#     # update laravel .env settings
#     cd laravel && \
#     sed -e "s/DB_CONNECTION=.*/DB_CONNECTION=pgsql/" -i ./.env && \
#     sed -e "s/DB_HOST=.*/DB_HOST=database/" -i ./.env && \
#     sed -e "s/DB_DATABASE=.*/DB_DATABASE=kawa/" -i ./.env && \
#     sed -e "s/DB_USERNAME=.*/DB_USERNAME=kawa/" -i ./.env && \
#     sed -e "s/DB_PASSWORD=.*/DB_PASSWORD=kawa/" -i ./.env

# clone laravel project
git clone https://github.com/kawagami/first-deploy-laravel.git laravel && \
    cd laravel && \
    cp .env.example .env && \
    sed -e "s/DB_CONNECTION=.*/DB_CONNECTION=pgsql/" -i .env && \
    sed -e "s/DB_HOST=.*/DB_HOST=database/" -i .env && \
    sed -e "s/DB_PORT=.*/DB_HOST=5432/" -i .env && \
    sed -e "s/DB_DATABASE=.*/DB_DATABASE=kawa/" -i .env && \
    sed -e "s/DB_USERNAME=.*/DB_USERNAME=kawa/" -i .env && \
    sed -e "s/DB_PASSWORD=.*/DB_PASSWORD=kawa/" -i .env && \
    # up services
    cd ../docker-env && \
    docker-compose up -d && \
    docker-compose exec app composer install && \
    docker-compose exec app php artisan key:generate