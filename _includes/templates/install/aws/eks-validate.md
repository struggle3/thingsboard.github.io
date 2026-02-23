### 验证 Web UI 访问

现在您可以在浏览器中使用负载均衡器的 DNS 名称打开 ThingsBoard Web 界面。

您可以使用以下命令查看 HTTP 负载均衡器的 DNS 名称（`ADDRESS` 列）：

```bash
kubectl get ingress
```
{: .copy-code}

您应该看到类似的输出：

![image](/images/install/cloud/aws-application-loadbalancers.png)

使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin

如果使用 `--loadDemo` 标志安装了带演示数据的数据库，您还可以使用以下凭据：

- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

### 验证 MQTT/CoAP 访问

要通过 MQTT 或 COAP 连接集群，需要获取对应的服务，可使用以下命令：

```bash
kubectl get service
```
{: .copy-code}

您应该看到类似的输出：

![image](/images/install/cloud/aws-network-loadbalancers.png)


有两个负载均衡器：
- tb-mqtt-loadbalancer-external - 用于 MQTT 协议
- tb-coap-loadbalancer-external - 用于 COAP 协议

使用负载均衡器的 `EXTERNAL-IP` 字段连接集群。

### 故障排除

如遇问题，可以检查服务日志以查找错误。
例如，要查看 ThingsBoard 节点日志，请执行以下命令：

```bash
kubectl logs -f tb-node-0
```
{: .copy-code}

或使用 `kubectl get pods` 查看 Pod 状态。
或使用 `kubectl get services` 查看所有服务状态。
或使用 `kubectl get deployments` 查看所有部署状态。
详见 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 命令参考。
