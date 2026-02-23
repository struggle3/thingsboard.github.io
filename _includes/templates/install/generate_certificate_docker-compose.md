### 生成 HTTPS 证书
我们使用 HAproxy 将流量代理至容器，Web UI 默认使用 80 和 443 端口。要为 HTTPS 使用有效证书，请执行以下命令：
```
docker exec haproxy-certbot certbot-certonly --domain your_domain --email your_email
docker exec haproxy-certbot haproxy-refresh
```

**注意**：仅当通过 URL 中的域名访问 Web UI 时才使用有效证书。若通过 IP 地址访问 UI，将使用自签名证书。 