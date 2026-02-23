执行以下命令以运行数据库初始设置。该命令将启动短期存在的 ThingsBoard pod 以创建必要的 DB 表、索引等：
```text
 ./k8s-deploy-trendz.sh
```
{: .copy-code}

命令完成后，控制台应显示：

```
Trendz installed successfully!
```
{% capture trendz-db-install %}

否则，请检查 `trendz-secret.yml` 中的 PostgreSQL URL 和 PostgreSQL 密码是否配置正确。

{% endcapture %}
{% include templates/info-banner.md content=trendz-db-install %}
