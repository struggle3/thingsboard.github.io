如遇问题，可查看服务日志中的错误。例如，要查看 TBMQ 日志，请执行以下命令：

```bash
kubectl logs -f my-tbmq-cluster-tbmq-node-0
```
{: .copy-code}

使用以下命令查看所有 statefulsets 的状态：

```bash
kubectl get statefulsets
```
{: .copy-code}

更多详情请参阅 [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/quick-reference/) 命令参考。
