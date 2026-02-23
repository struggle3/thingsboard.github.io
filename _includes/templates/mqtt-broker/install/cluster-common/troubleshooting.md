若遇问题，可查看服务日志排查错误。例如，查看 TBMQ 日志可执行：

```bash
kubectl logs -f tbmq-0
```
{: .copy-code}

使用以下命令查看所有 StatefulSet 的状态：

```bash
kubectl get statefulsets
```
{: .copy-code}

更多命令说明请参阅 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)。
