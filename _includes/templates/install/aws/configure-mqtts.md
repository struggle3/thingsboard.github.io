#### 单向 TLS

配置 MQTTS 的最简单方式是让 MQTT 负载均衡器（AWS NLB）作为 TLS 终止点。
这样我们建立单向 TLS 连接：设备与负载均衡器之间的流量被加密，负载均衡器与 MQTT 传输服务之间的流量不加密。
由于 ALB/NLB 在您的 VPC 内运行，不应存在安全问题。
此方案的主要缺点是无法使用「X.509 证书」类 MQTT 客户端凭据，因为客户端证书信息不会从负载均衡器传递到 ThingsBoard MQTT 传输服务。

要启用 **单向 TLS**：

* 使用 [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) 创建或导入 SSL 证书。
* 在「routes.yml」中找到两处标有「Uncomment the following lines to enable one-way MQTTS」的位置，将 **YOUR_MQTTS_CERTIFICATE_ARN** 替换为证书的 ARN。

#### 双向 TLS

启用 MQTTS 的更复杂方式是获取有效（已签名）的 TLS 证书并在 MQTT 传输中配置。此方案的主要优势是可与「X.509 证书」类 MQTT 客户端凭据配合使用。

要启用 **双向 TLS**：

按照 [本指南](/docs/user-guide/mqtt-over-ssl/) 创建包含 SSL 证书的 **.jks** 文件。
之后，需在 `tb-services.yml` 文件中将环境变量 **MQTT_SSL_KEY_STORE_PASSWORD** 和 **MQTT_SSL_KEY_PASSWORD** 设置为对应的 keystore 与证书密钥密码。

需要创建包含 JKS 文件的 config-map，可执行：

```
kubectl create configmap tb-mqtts-config \
             --from-file=server.jks=YOUR_JKS_FILENAME.jks -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

其中 **YOUR_JKS_FILENAME** 为您的 **.jks** 文件名。然后，取消 '{{eksTbServicesFile}}' 文件中所有标有「Uncomment the following lines to enable two-way MQTTS」的段落注释。
同时取消 routes.yml 文件中标有相同「Uncomment the following lines to enable two-way MQTTS」注释的段落。
