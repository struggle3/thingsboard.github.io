查看集群所有 pods：

```bash
kubectl get pods
```

查看指定 pod 的最新日志：

```bash
kubectl logs -f POD_NAME
```

查看 ThingsBoard 节点日志：

```bash
kubectl logs -f tb-node-0
```

可使用 <b>grep</b> 命令仅显示包含指定字符串的输出。
例如，可用以下命令检查后端是否存在错误：

```bash
kubectl logs -f tb-node-0 | grep ERROR
```

若有多节点，可将各节点日志重定向到本地文件再分析：

```bash
kubectl logs -f tb-node-0 > tb-node-0.log
kubectl logs -f tb-node-1 > tb-node-1.log
```

**注意：** 可随时进入 ThingsBoard 容器内查看日志：

```bash
kubectl exec -it tb-node-0 -- bash
cat /var/log/thingsboard/tb-node-0/thingsboard.log
```
