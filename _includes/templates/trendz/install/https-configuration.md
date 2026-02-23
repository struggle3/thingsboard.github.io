可使用 HAProxy 配置 HTTPS 访问。
若 Trendz 托管在云端并为实例分配了有效 DNS 名称，即可实现。

### Trendz 与 ThingsBoard 同机部署

若服务器已安装 HAProxy/Let's Encrypt 且 ThingsBoard 已启用 HTTPS，请参考本节。

打开 HAProxy 配置文件
```bash
sudo nano /etc/haproxy/haproxy.cfg
```
{: .copy-code}

找到 **frontend https_in** 段落，添加新的访问列表以按域名匹配流量并转发到 Trendz 后端：
```bash
acl trendz_http hdr(host) -i new-trendz-domain.com
use_backend tb-trendz if trendz_http
```

在同一文件中注册 Trendz 后端：
```bash
backend tb-trendz
  balance leastconn
  option tcp-check
  option log-health-checks
  server tbTrendz1 127.0.0.1:8888 check inter 5s
  http-request set-header X-Forwarded-Port %[dst_port]
```

为新域名生成 SSL 证书：
```bash
sudo certbot-certonly --domain new-trendz-domain.com --email some@email.io
```

刷新 HAProxy 配置：
```bash
sudo haproxy-refresh
```

至此 Trendz UI 的 HTTPS 已配置完成，可通过以下地址访问：
https://new-trendz-domain.com

### 新服务器全新安装

请参阅此[指南](/docs/user-guide/install/pe/add-haproxy-ubuntu)安装 HAProxy 并使用 Let's Encrypt 生成有效 SSL 证书。

### 同一域名下托管 ThingsBoard 与 Trendz

ThingsBoard 与 Trendz 可共享同一域名。此时 ThingsBoard 页面通过以下链接加载：

```bash
https://{my-domain}/
```

Trendz 页面通过以下链接加载

```bash
https://{my-domain}/trendz/
```

启用该配置需更新 HAProxy，将特定请求路由到 Trendz 服务。
打开 HAProxy 配置文件
```bash
sudo nano /etc/haproxy/haproxy.cfg
```
{: .copy-code}

找到 **frontend https_in** 段落，添加新的访问列表以按 URL 路径匹配流量并转发到 Trendz 后端：

```bash
...
acl trendz_acl path_beg /trendz/ path_beg /apiTrendz/
....
use_backend tb-trendz if trendz_acl
```
