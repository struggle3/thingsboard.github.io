编辑 "tb-node-db-configmap.yml"，将 **YOUR_DB_IP_ADDRESS** 和 **YOUR_DB_PASSWORD** 替换为在 [步骤 5](#step-5-provision-google-cloud-sql-postgresql-instance) 中获取的值。

```bash
nano tb-node-db-configmap.yml
```
{: .copy-code}

执行以下命令运行安装：

```bash
./k8s-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载额外演示数据。

此命令执行完成后，控制台应显示以下行：

```
Installation finished successfully!
```

