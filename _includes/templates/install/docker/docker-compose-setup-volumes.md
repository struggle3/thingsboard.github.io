执行以下命令为服务创建日志文件夹，并将这些文件夹的 chown 权限授予 docker 容器用户。
要更改用户，需使用 **chown** 命令，该命令需要 sudo 权限（脚本将提示输入 sudo 密码）：
{% capture docker-desktop-osx-warning %}
对于使用 [同步文件共享功能](https://docs.docker.com/desktop/features/synchronized-file-sharing/) 的 MacOS Docker Desktop 用户（默认对 `/Users` 子目录启用）：

请注意，您需要跳过更改主机卷所有权，因为虚拟化引擎会自动解析。

对 create 和 check 脚本均使用 `--skipChown` 标志：

`./docker-create-log-folders.sh --skipChown`

`./docker-check-log-folders.sh --skipChown`
{% endcapture %}
{% include templates/warn-banner.md content=docker-desktop-osx-warning %}
```bash
./docker-create-log-folders.sh
```
{: .copy-code}

检查所有必需的卷文件夹是否可用且具有正确的所有权：
```bash
./docker-check-log-folders.sh
```
{: .copy-code}