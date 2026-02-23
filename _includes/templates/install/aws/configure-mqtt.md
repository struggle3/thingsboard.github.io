若计划使用 MQTT 协议连接设备，请配置 MQTT 负载均衡器。

使用以下命令创建 TCP 负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

该负载均衡器将转发端口 1883 和 8883 的所有 TCP 流量。

#### 单向 TLS

配置 MQTTS 的最简单方式是让 MQTT 负载均衡器（AWS NLB）作为 TLS 终止点。
这样我们建立单向 TLS 连接：设备与负载均衡器之间的流量被加密，负载均衡器与 MQTT 传输服务之间的流量不加密。
由于 ALB/NLB 在您的 VPC 内运行，不应存在安全问题。
此方案的主要缺点是无法使用「X.509 证书」类 MQTT 客户端凭据，因为客户端证书信息不会从负载均衡器传递到 ThingsBoard MQTT 传输服务。

要启用 **单向 TLS**：

使用 [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) 创建或导入 SSL 证书。记下证书 ARN。

编辑负载均衡器配置，将 *YOUR_MQTTS_CERTIFICATE_ARN* 替换为您的证书 ARN：

```bash
nano receipts/mqtts-load-balancer.yml
```
{: .copy-code}

执行以下命令部署纯 HTTPS 负载均衡器：

```bash
kubectl apply -f receipts/mqtts-load-balancer.yml
```
{: .copy-code}

#### 双向 TLS

启用 MQTTS 的更复杂方式是获取有效（已签名）的 TLS 证书并在 MQTT 传输中配置。此方案的主要优势是可与「X.509 证书」类 MQTT 客户端凭据配合使用。

要启用 **双向 TLS**：

按照 [本指南](/docs/user-guide/mqtt-over-ssl/) 创建包含 SSL 证书的 **.pem** 文件。
将文件以 *server.pem* 保存在工作目录中。

需要创建包含 PEM 文件的 config-map，可执行：

```
kubectl create configmap tb-mqtts-config \
 --from-file=server.pem=YOUR_PEM_FILENAME \
 --from-file=mqttserver_key.pem=YOUR_PEM_KEY_FILENAME \
 -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

* **YOUR_PEM_FILENAME** 为 **服务器证书文件** 名称。
* **YOUR_PEM_KEY_FILENAME** 为 **服务器证书私钥文件** 名称。

然后，取消 '{{tbServicesFile}}' 文件中所有标有「Uncomment the following lines to enable two-way MQTTS」的段落注释。

执行以下命令使更改生效：

```
kubectl apply -f {{tbServicesFile}}
```
{: .copy-code}

最后，部署「透明」负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}


