执行以下命令删除 EKS 集群：

```bash
eksctl delete cluster -r us-east-1 -n tbmq -w
```
{: .copy-code}

{% capture delete-cluster %}

若配置使用了不同值，请确保更新集群名称 `-n` 和区域 `-r`。

{% endcapture %}
{% include templates/info-banner.md content=delete-cluster %}
