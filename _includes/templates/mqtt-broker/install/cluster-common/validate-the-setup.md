现在可在浏览器中使用负载均衡器的 DNS 名称打开 TBMQ Web 界面。

可执行以下命令获取负载均衡器的 DNS 名称：

```bash
kubectl get ingress
```
{: .copy-code}

输出应类似：

```text
NAME                     CLASS    HOSTS   ADDRESS         PORTS   AGE
tbmq-http-loadbalancer   <none>   *       34.111.24.134   80      3d1h
```

使用 tbmq-http-loadbalancer 的 `ADDRESS` 字段连接集群。

{% include templates/mqtt-broker/login.md %}
