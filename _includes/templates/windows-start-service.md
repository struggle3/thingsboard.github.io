现在启动 ThingsBoard 服务！
以管理员身份打开命令提示符并执行以下命令：

```shell
net start thingsboard
```
{: .copy-code}

预期输出：

```text
The ThingsBoard Server Application service is starting.
The ThingsBoard Server Application service was started successfully.
```

要重启 ThingsBoard 服务，可执行以下命令：

```shell
net stop thingsboard
net start thingsboard
```
{: .copy-code}

启动后，可通过以下链接打开 Web UI：

```bash
http://localhost:8080/
```
{: .copy-code}

若在运行安装脚本时指定了 *--loadDemo*，可使用以下默认凭证：

- **System Administrator**：sysadmin@thingsboard.org / sysadmin
- **Tenant Administrator**：tenant@thingsboard.org / tenant
- **Customer User**：customer@thingsboard.org / customer

可随时在账户资料页面修改各账户密码。