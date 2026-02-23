要通过 MQTT 连接集群，需获取对应服务的 IP。可使用以下命令：

```bash
kubectl get services
```
{: .copy-code}

输出应类似：

```text
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP              PORT(S)                         AGE
my-tbmq-cluster-mqtt-lb       LoadBalancer   10.100.119.170   *******                  1883:30308/TCP,8883:31609/TCP   6m58s
```

使用负载均衡器的 `EXTERNAL-IP` 字段通过 MQTT 协议连接集群。
