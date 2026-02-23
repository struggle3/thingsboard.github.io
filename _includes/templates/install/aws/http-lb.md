
配置 HTTP(S) 负载均衡器以访问 ThingsBoard 实例的 Web 界面。主要有 2 种配置选项：

* http - 不支持 HTTPS 的负载均衡器。**适用于开发环境**。
  唯一优势是配置简单、成本最低。适合开发服务器，但不适合生产环境。
* https - 支持 HTTPS 的负载均衡器。**适用于生产环境。** 作为 SSL 终止点。
  可轻松配置以签发和维护有效的 SSL 证书。自动将所有非安全（HTTP）流量重定向到安全（HTTPS）端口。

请参阅下方链接/说明了解如何配置每种建议选项。

#### HTTP 负载均衡器

{% include templates/install/cloud-cluster-common/http-lb.md %}

现在，您可以使用该地址（命令输出中替代 34.111.24.134 的地址）访问 HTTP Web UI（端口 80）并通过 [HTTP API](/docs/{{docsPrefix}}reference/http-api/) 连接设备
使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin
- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

#### HTTPS 负载均衡器

使用 [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) 创建或导入 SSL 证书。记下证书 ARN。

编辑负载均衡器配置，将 *YOUR_HTTPS_CERTIFICATE_ARN* 替换为您的证书 ARN：

```bash
nano receipts/https-load-balancer.yml
```
{: .copy-code}

执行以下命令部署纯 HTTPS 负载均衡器：

```bash
kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}
