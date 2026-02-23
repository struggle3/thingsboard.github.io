现在您可以在浏览器中使用负载均衡器的 IP 地址打开 ThingsBoard Web 界面。

您可以使用以下命令查看 HTTP 负载均衡器的 DNS 名称（`ADDRESS` 列）：
```
kubectl get ingress
```

您应该看到类似的输出：

![image](/images/install/cloud/application-loadbalancers.png)

要通过 MQTT 或 COAP 连接集群，需要获取对应的服务，可使用以下命令：

```
kubectl get service
```
{: .copy-code}

您应该看到类似的输出：

![image](/images/install/cloud/network-loadbalancers.png)

有两个负载均衡器：
- tb-mqtt-loadbalancer - 用于 TCP（MQTT）协议
- tb-udp-loadbalancer - 用于 UDP（COAP/LwM2M）协议

使用负载均衡器的 `EXTERNAL-IP` 字段连接集群。

使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin

如果使用 `--loadDemo` 标志安装了带演示数据的数据库，您还可以使用以下凭据：

- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

如遇问题，可以检查服务日志以查找错误。例如，要查看 ThingsBoard 节点日志，请执行以下命令：

```
kubectl logs -f tb-node-0
```

或使用 `kubectl get pods` 查看 Pod 状态。
或使用 `kubectl get services` 查看所有服务状态。
或使用 `kubectl get deployments` 查看所有部署状态。
详见 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 命令参考。

执行以下命令删除 **tb-node** 和**负载均衡器**：

```
./k8s-delete-resources.sh
```

执行以下命令删除所有数据（包括数据库）：

```
./k8s-delete-all.sh
```
