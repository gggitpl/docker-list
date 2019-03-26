#/bin/bash

docker-compose up -d --build && \
docker cp lanmp:/www/web ./web && \
docker cp lanmp:/www/wdlinux/mysql/data ./mysql && \
docker cp lanmp:/www/wdlinux/nginx/logs ./log && \
sed -i 's/# //g' ./docker-compose.yml &&  \
docker-compose stop && \
echo 'y' | docker-compose rm && \
docker-compose up -d --build && \
sudo chmod -R 777 ./mysql ./web ./log