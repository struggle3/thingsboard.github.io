配置 HTTP(S) 负载均衡器以访问 ThingsBoard 实例的 Web 界面。主要有 3 种配置选项：

   - http - 不支持 HTTPS 的负载均衡器。适用于开发环境。唯一优势是配置简单、成本最低。适合开发服务器，但不适合生产环境。
   - https - 支持 HTTPS 的负载均衡器。适用于生产环境。作为 SSL 终止点。可轻松配置以签发和维护有效的 SSL 证书。自动将所有非安全（HTTP）流量重定向到安全（HTTPS）端口。
   
请参阅下方链接/说明了解如何配置每种建议选项。

### HTTP 负载均衡器

{% include templates/install/cloud-cluster-common/http-lb.md %}

现在，您可以使用该地址（命令输出中替代 34.111.24.134 的地址）通过端口 80 访问 HTTP Web UI，并通过 HTTP API 连接设备。使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin
- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

### HTTPS 负载均衡器

使用 SSL 证书时，可通过以下命令直接在 Azure ApplicationGateWay 中添加证书：
```
az network application-gateway ssl-cert create \
   --resource-group $(az aks show --name $TB_CLUSTER_NAME --resource-group $AKS_RESOURCE_GROUP --query nodeResourceGroup | tr -d '"') \
   --gateway-name $AKS_GATEWAY\
   --name ThingsBoardHTTPCert \
   --cert-file YOUR_CERT \
   --cert-password YOUR_CERT_PASS
```
{: .copy-code}

将证书添加到应用程序负载均衡器后可执行：
```
kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}

负载均衡器预置可能需要一些时间。您可以使用以下命令定期检查负载均衡器状态：

```
kubectl get ingress
```
{: .copy-code}

预置完成后，您应看到类似输出：
```text
NAME                   CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-https-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```


{% capture https_lb_device_api_warn %}
**注意**：负载均衡器会将所有 HTTP 流量重定向到 HTTPS。不支持 HTTPS 的设备将无法连接 ThingsBoard。
如需支持此类设备，您可以部署单独的 HTTP 传输负载均衡器（推荐）
或在 *https-load-balancer.yml* 文件中修改 *appgw.ingress.kubernetes.io/ssl-redirect* 设置以禁用重定向行为。

{% endcapture %}
{% include templates/warn-banner.md content=https_lb_device_api_warn %}
