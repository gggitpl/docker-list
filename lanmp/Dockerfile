FROM ubuntu:16.04

ARG LANMP_VERSION=v3.1

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get clean && apt-get update \
    && apt-get install -y build-essential software-properties-common byobu curl git htop man unzip vim wget \
    make cmake gcc g++ perl bison libaio-dev libncurses5 libncurses5-dev libnuma-dev libssl-dev \
    libxml2-dev libcurl4-gnutls-dev libjpeg-dev libpng-dev libtool-bin bison libfreetype6-dev autoconf \
    && rm -rf /var/lib/apt/lists/* \
    #ubuntu的dash兼容性不好，而编译常用的是bash
    && echo 'no' | dpkg-reconfigure dash

RUN cd ~ && wget http://dl.wdlinux.cn/files/lanmp_${LANMP_VERSION}.tar.gz && tar zxvf lanmp_${LANMP_VERSION}.tar.gz && echo 4 | sh lanmp.sh

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chmod -R 777 /www/wdlinux/mysql-5.5.62/data

EXPOSE 8080 80 3306

VOLUME /www/web /www/wdlinux/mysql/data /www/wdlinux/nginx/logs

ENTRYPOINT ["/entrypoint.sh"]