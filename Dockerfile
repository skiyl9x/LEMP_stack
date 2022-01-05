# syntax=docker/dockerfile:1
FROM mariadb:10.7.1 as img1

FROM nginx:1.21 as img2
COPY ./conf/nginx/wordpress.conf /etc/nginx/conf.d/wordpress.conf

FROM php:7-fpm as img3
RUN apt-get update && \
    apt-get install zlib1g-dev libpng-dev libcurl4-openssl-dev libxml2-dev libonig-dev libzip-dev -y && \
    docker-php-ext-install mysqli gd curl dom exif fileinfo json mbstring xml zip && \
    docker-php-ext-enable mysqli gd curl dom exif fileinfo json mbstring xml zip


