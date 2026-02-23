默认情况下，在 Kubernetes 上安装 TBMQ 时，Helm chart 会为标准 NGINX Ingress Controller 部署 HTTP 和 MQTT 流量配置。

```yaml
loadbalancer:
  type: "nginx"
```

由于您在 GCP GKE 上部署 TBMQ 集群，需将此值改为：

```yaml
loadbalancer:
  type: "gcp"
```

这将自动配置：

- 通过 HTTP Load Balancer 暴露明文 HTTP 流量；
- 通过 TCP Load Balancer 暴露明文 MQTT 流量。

#### HTTPS 访问

使用 Google 托管 SSL 证书配置负载均衡器的过程请参阅官方 [文档页面](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs)。
以下说明摘自官方文档。继续前请仔细阅读前置条件。

 - 预留静态全局 IP 地址：

```bash
gcloud compute addresses create tbmq-http-lb-address --global
```
{: .copy-code}

 - 获取预留的静态 IP 地址：

```bash
gcloud compute addresses describe tbmq-http-lb-address --global --format="get(address)"
```
{: .copy-code}

- 配置 DNS：

必须至少配置一个完全限定域名（FQDN）指向预留的静态 IP 地址。
这是托管证书成功颁发的必要条件。

 - 更新 `values.yaml` 文件：

```yaml
loadbalancer:
  type: "gcp"
  http:
    enabled: true
    ssl:
      enabled: true
      # 这将是由 Helm chart 自动创建的 ManagedCertificate 资源的名称
      certificateRef: "<your-managed-certificate-resource-name>"
      domains:
      # 必须指向预留的静态 IP
      - <your-domain-name> 
      # GCP HTTP(S) 负载均衡器的静态 IP 地址
      staticIP: "tbmq-http-lb-address"
```

这将通过 Helm chart 创建的 ManagedCertificate 资源自动颁发并管理 SSL 证书，并通过 HTTPS 安全暴露 TBMQ。

#### MQTTS 访问

GCP Load Balancer 不支持 MQTT 流量的 TLS 终止。
若要保护 MQTT 通信，必须在应用层（TBMQ 侧）直接配置双向 TLS（Mutual TLS 或 mTLS）。
有关配置双向 TLS 的详情，请参阅 TBMQ Helm chart 文档 [此处](https://artifacthub.io/packages/helm/tbmq-helm-chart/tbmq-cluster#configuring-mutual-tls-mtls-for-mqtt)。
