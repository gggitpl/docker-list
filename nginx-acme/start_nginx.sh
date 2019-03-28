#!/bin/bash

# nginx 已经启动,直接重启
docker-compose ps | grep nginx | grep Up
if [ $? -eq 0 ] ;then
    docker-compose restart nginx 
fi
# nginx 已经停止,直接启动
docker-compose ps | grep nginx | grep Off
if [ $? -eq 0 ] ;then
    docker-compose start nginx 
fi
# 容器不存在,直接构建并启动
docker-compose ps | grep nginx
if [ $? -ne 0]
    docker-compose up -d --build
    docker cp nginx:/etc/nginx/conf.d ./conf.d
    docker cp nginx:/etc/nginx/h5bp ./h5bp
    docker cp nginx:/etc/nginx/nginx.conf ./nginx.conf
    docker cp nginx:/usr/share/nginx/html ./html
    docker cp nginx:/var/log/nginx ./log
    sed -i 's/# //g' ./docker-compose.yml 
    docker-compose stop && echo 'y' | docker-compose rm && docker-compose up -d --build
fi