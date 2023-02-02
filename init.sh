#!/bin/sh

# install laravel project
docker run --user 1000:1000 --rm -v $PWD:/app -w /app composer create-project laravel/laravel && \
    # update laravel .env settings
    cd laravel && \
    sed -e "s/DB_CONNECTION=.*/DB_CONNECTION=pgsql/" -i ./.env && \
    sed -e "s/DB_HOST=.*/DB_HOST=database/" -i ./.env && \
    sed -e "s/DB_DATABASE=.*/DB_DATABASE=kawa/" -i ./.env && \
    sed -e "s/DB_USERNAME=.*/DB_USERNAME=kawa/" -i ./.env && \
    sed -e "s/DB_PASSWORD=.*/DB_PASSWORD=kawa/" -i ./.env
