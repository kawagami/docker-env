# 客製的 laravel 環境

## 用法
* clone 此專案後 cd 至專案下
* 執行下列指令後會生成全新的 laravel 專案並設定成適用此環境的狀態
```
sh init.sh
```
* init 指令完成後使用下列指令啟動 & 關閉專案環境
```
sh up.sh
sh down.sh
```
* 可使用下列指令執行如 php artisan、composer、npm、yarn 等等的指令
```
# example
docker-compose exec app php artisan migrate
docker-compose exec app composer update
docker-compose exec app yarn install
```

## 專案環境
* php:8.2-fpm-alpine
* postgres:latest
* nginx:latest