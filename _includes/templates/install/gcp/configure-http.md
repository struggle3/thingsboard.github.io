配置 HTTP(S) 负载均衡器以访问 ThingsBoard 实例的 Web 界面。基本上有 3 种配置选项：

* http - 不支持 HTTPS 的负载均衡器。推荐**用于开发环境**。
  唯一优点是配置简单、成本最低。适用于开发服务器，但不适合生产环境。
* https - 支持 HTTPS 的负载均衡器。推荐**用于生产环境**。充当 SSL 终结点。
  可轻松配置以签发和维护有效 SSL 证书。自动将所有非安全 (HTTP) 流量重定向到安全 (HTTPS) 端口。
* transparent - 仅将流量转发到 ThingsBoard 的 http 和 https 端口的负载均衡器。需要您自行准备和维护有效 SSL 证书。
  适用于不能接受负载均衡器作为 SSL 终结点的生产环境。

请参阅以下链接/说明以配置各建议选项。

#### HTTP 负载均衡器

{% include templates/install/cloud-cluster-common/http-lb.md %}

现在，您可使用该地址（命令输出中替代 34.111.24.134 的地址）访问 HTTP Web UI（端口 80）并通过 [HTTP API](/docs/{{docsPrefix}}reference/http-api/) 连接设备。
使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin
- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

#### HTTPS 负载均衡器

{% assign staticIP = "thingsboard-http-lb-address" %}
{% include templates/install/gcp/https-lb.md %}

配置完成后，您可使用域名访问 Web UI（通过 https）并通过 [HTTP API](/docs/{{docsPrefix}}reference/http-api/) 连接设备。

{% capture https_lb_device_api_warn %}
**注意**：负载均衡器会将所有 HTTP 流量重定向到 HTTPS。不支持 HTTPS 的设备将无法连接 ThingsBoard。
如需支持此类设备，可单独部署 HTTP 传输负载均衡器（推荐），
或在 *https-load-balancer.yml* 文件中修改 *redirectToHttps* 设置以禁用重定向行为。

{% endcapture %}
{% include templates/warn-banner.md content=https_lb_device_api_warn %}
