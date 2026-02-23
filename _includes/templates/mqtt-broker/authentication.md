## 认证

要对 broker 执行管理操作，必须先登录系统并获取 Access Token。
该 Access Token 用于对管理操作进行认证和授权。

要获取 Access Token，可执行以下命令：

```bash
curl --location --request POST 'http://localhost:8083/api/auth/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"sysadmin@thingsboard.org",
    "password":"sysadmin"
}'
```
{: .copy-code}

**请注意**：若 broker 安装在远程服务器上，需将命令中的 "localhost" 替换为服务器公网 IP 或指定域名。
此外，请确保端口 8083 可从公网访问以建立连接。
同时，请将命令中的 "username" 和 "password" 替换为您环境中正确且有效的凭据。

授权成功后，响应中将包含一个名为 **token** 的字段。
后续所有 TBMQ 管理请求均需使用该 token。
为简化操作，您可以将 token 字段的值赋给名为 <i>ACCESS_TOKEN</i> 的环境变量，
或直接在本教程中涉及的请求里替换 <i>$ACCESS_TOKEN</i> 字符串。

```bash
export ACCESS_TOKEN=PLACE_YOUR_TOKEN_HERE
```
{: .copy-code}
