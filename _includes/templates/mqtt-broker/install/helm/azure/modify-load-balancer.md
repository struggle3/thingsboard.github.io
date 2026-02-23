默认情况下，在 Kubernetes 上安装 TBMQ 时，Helm chart 会为标准 NGINX Ingress Controller 部署 HTTP 和 MQTT 流量配置。

```yaml
loadbalancer:
  type: "nginx"
```

由于您在 Azure AKS 上部署 TBMQ 集群，需将此值改为：

```yaml
loadbalancer:
  type: "azure"
```

这将自动配置：

- 通过 Azure Application Gateway 暴露明文 HTTP 流量；
- 通过 Azure Load Balancer 暴露明文 MQTT 流量。

#### HTTPS 访问

要为 HTTP 流量启用 TLS，
需将 `loadbalancer.http.ssl.enabled` 设为 `true`，
并将 `loadbalancer.http.ssl.certificateRef` 更新为已配置在 Azure Application Gateway 中的 SSL 证书名称。

参见以下示例：

```yaml
loadbalancer:
  type: "azure"
  http:
    enabled: true
    ssl:
      enabled: true
      certificateRef: "<your-appgw-ssl-certificate-name>"
```

#### MQTTS 访问

Azure Load Balancer 不支持 MQTT 流量的 TLS 终止。
若要保护 MQTT 通信，必须在应用层（TBMQ 侧）直接配置双向 TLS（Mutual TLS 或 mTLS）。
有关配置双向 TLS 的详情，请参阅 TBMQ Helm chart 文档 [此处](https://artifacthub.io/packages/helm/tbmq-helm-chart/tbmq-cluster#configuring-mutual-tls-mtls-for-mqtt)。
