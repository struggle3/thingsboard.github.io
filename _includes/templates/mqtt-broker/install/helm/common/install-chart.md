现在可以使用 Helm chart 安装 TBMQ。
请确保当前目录与自定义的 `values.yaml` 文件所在目录一致。

```bash
helm install my-tbmq-cluster tbmq-helm-chart/tbmq-cluster \
  -f values.yaml \
  --set installation.installDbSchema=true
```
{: .copy-code}

{% capture installation-tip %}

`my-tbmq-cluster` 为 Helm release 名称。可改为任意名称，后续 Helm 命令中将使用此名称引用该部署。

{% endcapture %}
{% include templates/info-banner.md content=installation-tip %}

部署完成后，输出应类似以下内容：

```bash
NAME: my-tbmq-cluster
LAST DEPLOYED: Wed Mar 26 17:42:49 2025
NAMESPACE: tbmq
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
TBMQ 集群 my-tbmq-cluster 将在数分钟内部署完成。
信息：
命名空间：tbmq
```
