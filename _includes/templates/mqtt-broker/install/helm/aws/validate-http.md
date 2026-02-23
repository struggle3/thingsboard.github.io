现在可在浏览器中使用负载均衡器的 DNS 名称打开 TBMQ Web 界面。

可使用以下命令获取负载均衡器的 DNS 名称：

```bash
kubectl get ingress
```
{: .copy-code}

输出应类似：

```text
NAME                          CLASS    HOSTS   ADDRESS                                                            PORTS   AGE
my-tbmq-cluster-http-lb       <none>   *       k8s-tbmq-mytbmq-000aba1305-222186756.eu-west-1.elb.amazonaws.com   80      3d1h
```

使用 `my-tbmq-cluster-http-lb` 的 `ADDRESS` 字段连接集群。

{% include templates/mqtt-broker/login.md %}
