**说明：** 升级数据库时，可选择使用以下命令停止 TBMQ pods：

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

这将导致服务中断，但可确保更新后 DB 状态一致。
多数更新不需要停止 TBMQ。

完成后，再次执行资源部署。这将触发 TBMQ 使用最新版本进行 rollout restart。

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}
