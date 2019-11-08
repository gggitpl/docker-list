FROM alpine:latest

ENV DNSMASQ_VERSION=2.80

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add --update --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
    make \
    linux-headers \
    curl \
    bash \
    git

RUN wget http://www.thekelleys.org.uk/dnsmasq/dnsmasq-${DNSMASQ_VERSION}.tar.gz \
    && tar zxvf dnsmasq-${DNSMASQ_VERSION}.tar.gz \
    && cd dnsmasq-${DNSMASQ_VERSION} \
    && make \
    && make install \
    && mkdir -p /etc/dnsmasq.d \
    && rm /dnsmasq-${DNSMASQ_VERSION}.tar.gz

RUN wget https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/install.sh \
    && chmod +x /install.sh && /install.sh \
    && apk del .build-deps

EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq", "--no-daemon"]
