# syntax=docker/dockerfile:1
FROM mariadb:10.7.1 as img1

FROM nginx:1.21 as img2
COPY ./conf/nginx/wordpress.conf /etc/nginx/conf.d/wordpress.conf

FROM php:7-fpm as img3

