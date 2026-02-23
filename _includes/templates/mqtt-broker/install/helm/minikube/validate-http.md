```bash
kubectl get ingress my-tbmq-cluster-http-lb
```
{: .copy-code}

输出应类似：

```text
NAME                      CLASS   HOSTS   ADDRESS         PORTS   AGE
my-tbmq-cluster-http-lb   nginx   *       10.111.137.85   80      47m
```

使用 `my-tbmq-cluster-http-lb` 的 `ADDRESS` 字段连接集群。

{% include templates/mqtt-broker/login.md %}
