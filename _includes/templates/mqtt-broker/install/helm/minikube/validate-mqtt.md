若 minikube tunnel 已运行，您会看到列表中多出一个新服务，用于对外暴露 MQTT 流量：

```text
Status:	
	machine: minikube
	pid: 35528
	route: 10.96.0.0/12 -> 192.168.49.2
	minikube: Running
	services: [nginx-ingress-ingress-nginx-controller, my-tbmq-cluster-mqtt-lb]
```

服务 `my-tbmq-cluster-mqtt-lb` 为用于 MQTT 通信的 LoadBalancer。可使用以下命令获取其 `EXTERNAL-IP`：

```bash
kubectl get svc my-tbmq-cluster-mqtt-lb
```
{: .copy-code}

输出应类似：

```text
NAME                      TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)                                                       AGE
my-tbmq-cluster-mqtt-lb   LoadBalancer   10.101.27.40   *******        1883:31041/TCP,8084:30151/TCP,8883:30188/TCP,8085:32706/TCP   41m
```
{: .copy-code}

使用负载均衡器的 `EXTERNAL-IP` 字段通过 MQTT 协议连接集群。
