#/bin/bash

docker-compose stop && echo 'y' | docker-compose rm && docker-compose up -d --build && \
docker cp nginx:/etc/nginx/conf.d ./conf.d && \
docker cp nginx:/etc/nginx/h5bp ./h5bp && \
docker cp nginx:/etc/nginx/test/vhosts ./vhosts && \
docker cp nginx:/etc/nginx/nginx.conf ./nginx.conf && \
docker cp nginx:/usr/share/nginx/html ./html && \
docker cp nginx:/var/log/nginx ./log && \
sed -i 's/# //g' ./docker-compose.yml &&  \
docker-compose stop && echo 'y' | docker-compose rm && docker-compose up -d --build