默认情况下，在 Kubernetes 上安装 TBMQ 时，Helm chart 会为标准 NGINX Ingress Controller 部署 HTTP 和 MQTT 流量配置。

```yaml
loadbalancer:
  type: "nginx"
```

此配置适用于 Minikube 及其他通用 Kubernetes 环境。

#### HTTPS 访问

目前 NGINX Ingress Controller 在负载均衡器层面的 HTTPS 终止尚未实现。此功能可能在后续版本中添加。

#### MQTTS 访问

NGINX Ingress Controller 不支持基于 TCP 的协议（如 MQTT）的 TLS 终止。
若要保护 MQTT 通信，必须在应用层（TBMQ 侧）直接配置双向 TLS（Mutual TLS 或 mTLS）。
有关配置双向 TLS 的详情，请参阅 TBMQ Helm chart 文档 [此处](https://artifacthub.io/packages/helm/tbmq-helm-chart/tbmq-cluster#configuring-mutual-tls-mtls-for-mqtt)。
