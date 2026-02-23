要自定义 TBMQ 部署，请先从 chart 下载默认 `values.yaml` 文件：

```bash
helm show values tbmq-helm-chart/tbmq-cluster > values.yaml
```
{: .copy-code}

{% capture installation-option %}

请勿直接在 `values.yaml` 中修改 `installation.installDbSchema`。
此参数仅在首次安装时用于初始化 TBMQ 数据库 schema。
我们将在 `helm install` 命令中通过 `--set` 选项显式传入该参数。

{% endcapture %}
{% include templates/info-banner.md content=installation-option %}
