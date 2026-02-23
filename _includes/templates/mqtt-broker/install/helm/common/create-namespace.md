建议为 TBMQ 集群部署创建专用命名空间：

```bash
kubectl create namespace tbmq
```
{: .copy-code}

```bash
kubectl config set-context --current --namespace=tbmq
```
{: .copy-code}

这将把 tbmq 设为当前上下文的默认命名空间，因此您无需在每个命令中传递 --namespace 参数。
