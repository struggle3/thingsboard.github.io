配置 MQTT 负载均衡器以支持通过 MQTT 协议连接设备。

执行以下命令创建 TCP 负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

负载均衡器将转发 1883 和 8883 端口的所有 TCP 流量。

#### MQTT over SSL

按照 [此指南](https://thingsboard.io/docs/user-guide/mqtt-over-ssl/) 创建包含 SSL 证书的 .pem 文件。将文件以 _server.pem_ 保存在工作目录中。

需创建包含 PEM 文件的 config-map，可执行以下命令：

```bash
kubectl create configmap tbmq-mqtts-config \
 --from-file=server.pem=YOUR_PEM_FILENAME \
 --from-file=mqttserver_key.pem=YOUR_PEM_KEY_FILENAME \
 -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

* **YOUR_PEM_FILENAME** 为**服务器证书文件**名称。
* **YOUR_PEM_KEY_FILENAME** 为**服务器证书私钥文件**名称。

然后，取消 tbmq.yml 文件中标记为「Uncomment the following lines to enable two-way MQTTS」的所有节的注释。

执行以下命令应用更改：

```bash
kubectl apply -f tbmq.yml
```
{: .copy-code}
