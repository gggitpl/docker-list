FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
&& apk add --no-cache dnsmasq wget\
&& wget -P /etc/dnsmasq.d/ https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf \
&& wget -P /etc/dnsmasq.d/ https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf \
&& wget -P /etc/dnsmasq.d/ https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/bogus-nxdomain.china.conf
VOLUME /etc/
VOLUME /etc/dnsmasq.d/
VOLUME /var/log/
EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq","-k"]
