将本地修改与 [步骤 1](#step-1-clone-thingsboard-ce-k8s-scripts-repository) 所用仓库的最新发布分支合并。


如需升级数据库，请执行以下命令：

```bash
 ./k8s-upgrade-tb.sh --fromVersion=[FROM_VERSION]
```
{: .copy-code}

其中：

- `FROM_VERSION` - 从哪个版本开始升级。有效 `fromVersion` 值请参见 [升级说明](/docs/user-guide/install/upgrade-instructions)。注意，需按顺序逐版本升级（例如 3.6.1 -> 3.6.2 -> 3.6.3）。 

注意：升级数据库时，可选择停止 tb-node  pods。这将导致停机，但能确保更新后数据库状态一致。
大多数更新无需停止 tb-nodes。

完成后，再次执行资源部署。这将触发 thingsboard 组件的滚动重启并更新到最新版本。

```yaml
./k8s-deploy-resources.sh
```

