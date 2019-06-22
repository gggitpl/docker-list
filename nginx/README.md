# 创建挂载目录

```bash
mkdir -p /root/docker/nginx \
&& cd /root/docker/nginx \
&& wget https://github.com/h5bp/server-configs-nginx/archive/master.zip \
&& unzip master.zip \
&& mv server-configs-nginx-master/* . \
&& mkdir -p /root/docker/nginx/html \
&& mkdir -p /root/docker/nginx/log \
&& mkdir -p /root/docker/nginx/acmeout \
&& rm -r README.md CHANGELOG.md LICENSE.txt master.zip server-configs-nginx-master/
&& sed -i 's/www-data/nginx/g' nginx.conf \
&& sed -i 's/default.crt/gggitpl.com\/full.pem/g' h5bp/ssl/certificate_files.conf \
&& sed -i 's/default.key/gggitpl.com\/key.pem/g' h5bp/ssl/certificate_files.conf \
&& sed -i 's/8192/65535/g' nginx.conf
```

# 启动容器


# 颁发证书

```bash
docker  exec \
    -e CF_Email=gggitpl@gmail.com \
    -e CF_Key=gggitpl  \
    -e Ali_Key= \
    -e Ali_Secret= \
    acme.sh --issue --dns dns_ali -d gggitpl.com -d *.gggitpl.com
```

# 部署证书

```bash
docker  exec \
    -e DEPLOY_DOCKER_CONTAINER_LABEL=sh.acme.autoload.domain=gggitpl.com \
    -e DEPLOY_DOCKER_CONTAINER_KEY_FILE=/etc/nginx/certs/gggitpl.com/key.pem \
    -e DEPLOY_DOCKER_CONTAINER_CERT_FILE="/etc/nginx/certs/gggitpl.com/cert.pem" \
    -e DEPLOY_DOCKER_CONTAINER_CA_FILE="/etc/nginx/certs/gggitpl.com/ca.pem" \
    -e DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="/etc/nginx/certs/gggitpl.com/full.pem" \
    -e DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="service nginx force-reload" \
    acme.sh --deploy -d gggitpl.com  --deploy-hook docker
```
