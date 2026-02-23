若你更新卷或合并部署文件与 GitHub 仓库文件，请勿忘记使用提供的检查和（如需要）创建脚本来检查主机卷（如日志目录等），相关说明见[「Running」步骤开头的](#create-and-check-required-host-volumes)。

若需升级数据库，编辑 .env 文件，将「TB_VERSION」设为目标版本（例如升级到最新版本时设为 {{ site.release.ce_full_ver }}）。然后执行以下命令：

```bash
./docker-stop-services.sh
./docker-upgrade-tb.sh
./docker-start-services.sh
```
{: .copy-code}

注意，需按版本逐个升级（例如 4.0.0 -> 4.0.1 -> 4.1.0 等）。

{% capture from-version-note %}
较早版本（3.9.1 之前）的升级需使用 <code style="color:black">"--fromVersion"</code> 参数，例如：

`# upgrading to v3.9.0...`<br>
`./docker-upgrade-tb.sh --fromVersion=3.8.1`

有效的 <code style="color:black">"fromVersion"</code> 值请参阅 [升级说明](/docs/user-guide/install/{{docsPrefix}}upgrade-instructions)。
{% endcapture %}
{% include templates/info-banner.md content=from-version-note %}

### 迁移至专业版

也可使用 `docker-upgrade-tb.sh` 脚本从社区版（CE）迁移至专业版（PE）：

1. 先升级至最新 CE 版本。
2. 将配置与[最新 PE Docker Compose 脚本](https://github.com/thingsboard/thingsboard-pe-docker-compose/tree/release-{{ site.release.ce_ver }})合并。勿忘[配置许可证密钥](/docs/user-guide/install/pe/cluster/docker-compose-setup/#step-3-obtain-your-license-key)。
3. 运行以下升级脚本以将数据库从 CE 迁移至 PE：
```bash
./docker-upgrade-tb.sh --fromVersion=CE
```