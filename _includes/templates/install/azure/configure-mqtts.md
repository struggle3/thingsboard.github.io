#### 双向 TLS

启用 MQTTS 的较复杂方式是获取有效（已签名）的 TLS 证书并在 MQTT Transport 中配置。此选项的主要优势是可与“X.509 证书”MQTT 客户端凭据配合使用。

要启用**双向 TLS**：

按照[此指南](/docs/user-guide/mqtt-over-ssl/)创建包含 SSL 证书的 **.jks** 文件。
然后，需要在 `tb-services.yml` 或 `tb-node.yaml` 文件中设置 **MQTT_SSL_KEY_STORE_PASSWORD** 和 **MQTT_SSL_KEY_PASSWORD** 环境变量
为对应的 key-store 和证书密钥密码。

需要创建包含 JKS 文件的 config-map，可通过以下命令调用：

```
kubectl create configmap tb-mqtts-config \
             --from-file=server.jks=YOUR_JKS_FILENAME.jks -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

其中 **YOUR_JKS_FILENAME** 为您的 **.jks** 文件名。然后，取消注释 '{{eksTbServicesFile}}' 文件中标有“取消注释以下行以启用双向 MQTTS”的所有部分。
同时，取消注释 'routes.yml' 文件中标有相同“取消注释以下行以启用双向 MQTTS”注释的部分。
