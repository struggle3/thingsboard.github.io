执行以下命令部署资源：

```
./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后可运行 `kubectl get pods`。若一切正常，应能看到 `tb-node-0` Pod 处于 `READY` 状态。