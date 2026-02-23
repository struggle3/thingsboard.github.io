### 从 TBMQ CE 升级到 TBMQ PE（v2.2.0）

要将现有 **TBMQ 社区版 (CE)** 升级到 **TBMQ 专业版 (PE)**，请确保在开始前已运行最新的 **TBMQ CE {{site.release.broker_full_ver}}** 版本。
将当前配置与最新的 [TBMQ PE K8S 脚本](https://github.com/thingsboard/tbmq-pe-k8s/tree/{{ site.release.broker_branch }}) 合并。
请勿忘记[配置许可证密钥](#configure-the-license-key)。

运行以下命令（包含升级脚本）以迁移 PostgreSQL 数据库数据（从 CE 到 PE）：

```bash
./k8s-delete-tbmq.sh
./k8s-upgrade-tbmq.sh --fromVersion=ce
./k8s-deploy-tbmq.sh
```
{: .copy-code}
