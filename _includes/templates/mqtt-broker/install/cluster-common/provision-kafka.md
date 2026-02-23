建议使用 Helm 部署 Bitnami Kafka。请先查看 `kafka` 目录。

```bash
ls kafka/
```
{: .copy-code}

其中可找到 _default-values-kafka.yml_ 文件——从 [Bitnami artifactHub](https://artifacthub.io/packages/helm/bitnami/kafka) 下载的默认值。以及修改后的 _values-kafka.yml_ 文件。
建议保持第一个文件不变，仅修改第二个文件。这样升级到下一版本时更容易通过 diff 看出变更。

添加 Bitnami helm 仓库：

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```
{: .copy-code}

安装 Bitnami Kafka 时执行以下命令：

```bash
helm install kafka -f kafka/values-kafka.yml bitnami/kafka --version 29.3.4
```
{: .copy-code}

等待几分钟直至 Kafka Pod 启动并运行。
