
当需要升级数据库时，执行以下命令：

```
 ./k8s-delete-resources.sh
 ./k8s-upgrade-tb.sh --fromVersion=[FROM_VERSION]
 ./k8s-deploy-resources.sh
```

其中：

- `FROM_VERSION` - 升级起始版本。有关有效 `fromVersion` 值请参阅 [升级说明](/docs/user-guide/install/upgrade-instructions)。注意，必须逐个版本升级（例如 3.6.1 -> 3.6.2 -> 3.6.3 等）。
