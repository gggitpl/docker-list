#!/bin/sh

set -v
PASSWORD=abc123
# 生成CA私钥和公钥
openssl genrsa -aes256 -passout pass:$PASSWORD -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -passin "pass:$PASSWORD" -out ca.pem
# 现在您已拥有CA，您可以创建服务器密钥和证书签名请求（CSR）
openssl genrsa -out server-key.pem 4096
#查看主机DNS信息
dig
read -p "请输入Docker守护程序主机的DNS: " HOST
openssl req -subj "/CN=$HOST" -sha256 -new -key server-key.pem -out server.csr
# 使用我们的CA签署公钥
read -p "请输入Docker守护程序主机的IP: " IP
echo subjectAltName = DNS:$HOST,IP:$IP,IP:127.0.0.1 >> extfile.cnf
echo extendedKeyUsage = serverAuth >> extfile.cnf
# 生成签名证书
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -passin "pass:$PASSWORD" -CAcreateserial -out server-cert.pem -extfile extfile.cnf
# 创建客户端密钥和证书签名请求
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth > extfile-client.cnf
# 生成签名证书
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -passin "pass:$PASSWORD" -CAcreateserial -out cert.pem -extfile extfile-client.cnf
# 删除两个证书签名请求和扩展配置文件
rm -v client.csr server.csr extfile.cnf extfile-client.cnf
# 保护您的密钥免受意外损坏，请删除其写入权限
chmod -v 0400 ca-key.pem key.pem server-key.pem
# 删除写访问以防止意外损坏
chmod -v 0444 ca.pem server-cert.pem cert.pem
# 使Docker守护程序仅接受来自提供CA信任的证书的客户端的连接
sudo service docker stop && \
sudo dockerd --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem -H=0.0.0.0:2376 -H unix:///var/run/docker.sock &