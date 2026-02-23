查看集群中所有 pods：

```bash
kubectl get pods
```
{: .copy-code}

查看指定 pod 的最新日志：
 
```bash
kubectl logs -f POD_NAME
```
{: .copy-code}

查看 TBMQ 日志：

```bash
kubectl logs -f tb-broker-0
```
{: .copy-code}

可使用 <b>grep</b> 仅显示包含指定字符串的输出。
例如，检查 backend 侧是否有错误：

```bash
kubectl logs -f tb-broker-0 | grep ERROR
```
{: .copy-code}

若有多节点，可将各节点日志重定向到本机文件再分析：

```bash
kubectl logs -f tb-broker-0 > tb-broker-0.log
kubectl logs -f tb-broker-1 > tb-broker-1.log
```
{: .copy-code}

**说明：** 也可进入 TBMQ 容器内查看日志：

```bash
kubectl exec -it tb-broker-0 -- bash
cat /var/log/thingsboard-mqtt-broker/thingsboard-mqtt-broker.log
```
{: .copy-code}
