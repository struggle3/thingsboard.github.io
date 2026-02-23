执行以下命令部署 broker：

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

几分钟后，可执行以下命令检查所有 pod 状态。

```bash
kubectl get pods
```
{: .copy-code}

若一切正常，应能看到 `tbmq-0` 和 `tbmq-1` pod，且均处于 `READY` 状态。
