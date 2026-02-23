执行以下命令部署纯 HTTP 负载均衡器：

```bash
kubectl apply -f receipts/http-load-balancer.yml
```
{: .copy-code}

负载均衡器配置可能需要一些时间。可使用以下命令定期检查负载均衡器状态：

```bash
kubectl get ingress
```
{: .copy-code}

配置完成后，您应能看到类似输出：

```text
NAME                     CLASS    HOSTS   ADDRESS         PORTS   AGE
tbmq-http-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```
