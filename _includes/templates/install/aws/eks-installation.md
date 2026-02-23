执行以下命令运行数据库的初始设置。该命令将启动短生命周期的 ThingsBoard Pod 以配置必要的数据库表、索引等。
```
 ./k8s-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载额外的演示数据。

此命令完成后，您应在控制台看到以下输出：

```
Installation finished successfully!
```
{% capture aws-rds %}

否则，请检查是否在 `tb-node-db-configmap.yml` 中正确设置了 PostgreSQL URL 和 PostgreSQL 密码。

{% endcapture %}
{% include templates/info-banner.md content=aws-rds %}
