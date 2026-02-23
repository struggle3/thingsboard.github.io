若计划使用 MQTT 协议连接设备，请配置 MQTT 负载均衡器。

使用以下命令创建 TCP 负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

负载均衡器将转发 1883 和 8883 端口的全部 TCP 流量。

#### MQTT over SSL

此类负载均衡器需要您自行准备和维护有效 SSL 证书。
请参阅通用 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl) 指南，
在 *{{tbServicesFile}}* 文件中配置所需环境变量。
