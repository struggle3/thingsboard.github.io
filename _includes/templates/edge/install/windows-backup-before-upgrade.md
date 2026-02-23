## 升级 ThingsBoard Edge 前的准备

为确保升级期间数据完整性，请备份 ThingsBoard Edge 数据。

### 停止 Edge 服务

```text
net stop tb-edge
```
{: .copy-code}

### 备份数据库

1. 启动 **pgAdmin**，以 **postgres** 超级用户登录。
2. 在左侧边栏中展开服务器并找到 **tb_edge** 数据库。
3. 右键点击 **tb_edge**，选择 **Backup**。
4. 在 **Backup Dialog** 中指定备份文件名和保存位置。
5. 点击 **Backup** 创建备份文件。
