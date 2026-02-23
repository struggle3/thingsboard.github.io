默认情况下，在 Kubernetes 上安装 TBMQ 时，Helm chart 会为标准 NGINX Ingress Controller 部署 HTTP 和 MQTT 流量配置。

```yaml
loadbalancer:
  type: "nginx"
```

由于您在 AWS EKS 上部署 TBMQ 集群，需将此值改为：

```yaml
loadbalancer:
  type: "aws"
```

这将自动配置：

- 通过 AWS Application Load Balancer (ALB) 暴露明文 HTTP 流量；
- 通过 AWS Network Load Balancer (NLB) 暴露明文 MQTT 流量。

#### HTTPS 访问

使用 [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) 创建或导入 SSL 证书。记录证书 ARN。

接下来，需将 `loadbalancer.http.ssl.enabled` 设为 `true`，
并将 `loadbalancer.http.ssl.certificateRef` 更新为之前配置的 ACM 证书 ARN。

参见以下示例：

```yaml
loadbalancer:
  type: "aws"
  http:
    enabled: true
    ssl:
      enabled: true
      certificateRef: "<your-acm-certificate-arn-for-alb>"
```

#### MQTTS 访问

##### TLS 终止（单向 TLS）

配置 MQTTS 的最简单方式是让 MQTT 负载均衡器（AWS NLB）充当 TLS 终止点。
这样可建立单向 TLS 连接：设备与负载均衡器之间的流量加密，负载均衡器与 TBMQ 之间的流量未加密。
由于 ALB/NLB 在您的 VPC 内运行，应无安全问题。
此方案的主要不足是无法使用「X.509 certificate」MQTT 客户端凭据，
因为客户端证书信息不会从负载均衡器传递到 TBMQ。

使用 [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) 创建或导入 SSL 证书。记录证书 ARN。

接下来，需将 `loadbalancer.mqtt.tlsTermination.enabled` 设为 `true`，
并将 `loadbalancer.mqtt.tlsTermination.certificateRef` 更新为之前配置的 ACM 证书 ARN。

参见以下示例：

```yaml
loadbalancer:
  type: "aws"
  mqtt:
    enabled: true
    tlsTermination:
      enabled: true
      certificateRef: "<your-acm-certificate-arn-for-nlb>"
```

##### Mutual TLS（双向 TLS 或 mTLS）

启用 MQTTS 的另一种更复杂方式是获取有效（已签名）TLS 证书并在 TBMQ 中配置。
此方案的主要优势是可以与「X.509 certificate」MQTT 客户端凭据结合使用。

有关配置双向 TLS 的详情，请参阅 TBMQ Helm chart 文档 [此处](https://artifacthub.io/packages/helm/tbmq-helm-chart/tbmq-cluster#configuring-mutual-tls-mtls-for-mqtt)。

{% capture tls-termination %}

若 `loadbalancer.mqtt.mutualTls.enabled` 设为 `true`，TLS 终止配置将被忽略。

{% endcapture %}
{% include templates/info-banner.md content=tls-termination %}
