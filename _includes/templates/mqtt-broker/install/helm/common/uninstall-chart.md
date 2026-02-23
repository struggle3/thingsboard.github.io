要卸载 TBMQ Helm chart，请运行以下命令：

```bash
helm delete my-tbmq-cluster
```
{: .copy-code}

此命令将从当前 Kubernetes 上下文中设置的命名空间内移除与该 release 关联的所有 TBMQ 组件。

`helm delete` 命令仅移除 TBMQ 集群的逻辑资源。
要完全清理所有持久化数据，卸载后可能还需手动删除关联的 Persistent Volume Claims (PVCs)：

```bash
kubectl delete pvc -l app.kubernetes.io/instance=my-tbmq-cluster
```
{: .copy-code}
