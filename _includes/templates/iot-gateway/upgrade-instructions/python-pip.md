### 步骤 1：停止 Gateway

若 Gateway 以后台服务或 systemd 服务运行，请先停止：

```bash
sudo systemctl stop thingsboard-gateway
```
{: .copy-code}

若在终端手动运行，请使用 `Ctrl + C` 停止。

### 步骤 2：通过 pip 升级 ThingsBoard Gateway 包

在 Python 环境中执行以下命令：

```bash
pip install --upgrade thingsboard-gateway
```
{: .copy-code}

{% capture difference %}
根据环境不同，可能需要使用 pip3 或 python3 -m pip。若为用户级安装，请添加 `--user`。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 步骤 3：重启 Gateway

升级完成后，再次启动 Gateway：

```bash
sudo systemctl start thingsboard-gateway
```
{: .copy-code}

若为手动运行：

```bash
thingsboard-gateway
```
{: .copy-code}

### 说明

- 若在虚拟环境中运行，请确保 `pip install` 和服务控制命令在该环境中执行。
- 若通过 systemd 服务安装 Gateway，服务文件可能需要指向正确的环境或可执行文件路径。
