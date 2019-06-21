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
    -e DEPLOY_DOCKER_CONTAINER_KEY_FILE=/etc/nginx/ssl/gggitpl.com/key.pem \
    -e DEPLOY_DOCKER_CONTAINER_CERT_FILE="/etc/nginx/ssl/gggitpl.com/cert.pem" \
    -e DEPLOY_DOCKER_CONTAINER_CA_FILE="/etc/nginx/ssl/gggitpl.com/ca.pem" \
    -e DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="/etc/nginx/ssl/gggitpl.com/full.pem" \
    -e DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="service nginx force-reload" \
    acme.sh --deploy -d gggitpl.com  --deploy-hook docker
```