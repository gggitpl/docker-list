FROM nginx:1.14.2-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk update -f \
    && apk --no-cache add -f \
    git \
    tree \
    && rm -rf /var/cache/apk/*

RUN git clone https://github.com/h5bp/server-configs-nginx.git \
    && tree server-configs-nginx \
    && mv server-configs-nginx/conf.d/* /etc/nginx/conf.d \
    && mv server-configs-nginx/h5bp /etc/nginx/h5bp \
    && mv server-configs-nginx/mime.types /etc/nginx/mime.types \
    && mv server-configs-nginx/nginx.conf /etc/nginx/nginx.conf \
    && rm -rf server-configs-nginx \
    && sed -i 's/www-data/nginx/g' /etc/nginx/nginx.conf