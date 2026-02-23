### 步骤 1：下载 .deb 文件

下载安装用的 `.deb` 包。

```bash
wget https://github.com/thingsboard/thingsboard-gateway/releases/latest/download/python3-thingsboard-gateway.deb
````
{: .copy-code}

### 步骤 2：安装新的 .deb 文件

在终端中执行以下命令安装更新包：

```bash
sudo apt install ./python3-thingsboard-gateway.deb -y
```
{: .copy-code}

{% capture difference %}
将自动升级现有 Gateway 安装，不会删除配置和扩展文件 **（自 Gateway 3.7.6 版本起）**。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 步骤 3：重启 Gateway

升级后，重启 Gateway 服务以应用更改：

```bash
sudo systemctl restart thingsboard-gateway
```
{: .copy-code}

### 步骤 4：验证升级

为确保升级成功，可通过以下命令检查 Gateway 状态和日志：

```bash
sudo systemctl status thingsboard-gateway
```
{: .copy-code}

### 配置文件保留

升级过程中，**将保留所有用户配置文件。** 包括：
- Connector 配置文件。
- 自定义用户扩展。
- `tb_gateway.json` 文件。

升级过程还会自动备份当前配置目录，确保出现问题时可以恢复。备份存储于以下路径：

- Connector 配置：
  ```
  /etc/thingsboard-gateway/configs_backup.tar.gz
  ```

- 用户扩展：
  ```
  /var/lib/thingsboard_gateway/extensions_backup.tar.gz
  ```

### 说明

- 本升级流程仅适用于基于 .deb 包的安装。若使用 Docker 或 pip 安装，请参阅本页顶部提供的相应指南。
- 升级后请务必测试 Gateway，确保 connector 和扩展正常工作。
