
* TOC
{:toc}

## Swagger UI

安装 TBMQ 后，可使用 Swagger UI 浏览 REST API。

通过以下 URL 访问 Swagger UI：

``` 
http(s)://YOUR_HOST:PORT/swagger-ui/
```

本地安装请使用以下 URL：

```text
http://localhost:8083/swagger-ui/
```
{: .copy-code}

该 URL 提供交互界面，用于浏览和使用 TBMQ 的 REST API 端点。
使用 Swagger UI 可便捷地探索功能、测试 API 调用并获取 TBMQ 提供的服务端 API 信息。

若您已在主登录页完成授权，文档页将自动使用您的凭证。
无需额外认证即可无缝访问文档。

若需手动授权或使用不同凭证，可点击文档页右上角的「Authorize」按钮。
该按钮用于提供认证信息并以所需权限完成授权。

使用「Authorize」按钮可灵活以不同用户身份认证，根据授权级别访问文档中相应部分。

{% include images-gallery.html imageCollection="broker-swagger-ui" %}

## JWT Token

TBMQ 使用 [JWT](https://jwt.io/)（JSON Web Tokens）在 API 客户端（如浏览器和脚本）与平台之间安全表示声明。
JWT token 用于安全交换信息的机制。

登录 broker 时，用户名和密码将换得一对 token。这些 JWT 形式的 token 封装了用户认证与授权所需的必要信息。
确保凭证安全传输，并允许 API 客户端与平台安全通信，同时维护所交换信息的完整性和机密性。

主 token 为短效 token，用于执行 API 调用。主 token 过期后，refresh token 用于获取新的主 token。
主 token 和 refresh token 的过期时间可在系统设置中[配置](/docs/{{docsPrefix}}mqtt-broker/install/config/)，通过 `JWT_TOKEN_EXPIRATION_TIME` 和 `JWT_REFRESH_TOKEN_EXPIRATION_TIME` 参数。默认过期时间分别为 2.5 小时和 1 周。

参见以下示例命令，为用户「sysadmin@thingsboard.org」、密码「sysadmin」及服务器「THINGSBOARD_MQTT_BROKER_URL」获取 token：

{% capture tabspec %}token
A,get-token.sh,shell,reference/resources/get-token.sh,/docs/{{docsPrefix}}mqtt-broker/reference/resources/get-token.sh
B,response.json,json,reference/resources/get-token-response.json,/docs/{{docsPrefix}}mqtt-broker/reference/resources/get-token-response.json{% endcapture %}
{% include tabs.html %}

- 将 ‘X-Authorization’ 请求头设置为 “Bearer $YOUR_JWT_TOKEN”. **请确保**使用主 JWT token，而非 refresh token.

## 控制器概览

- **Admin Controller**：用于查看、创建或删除管理员用户。
- **App Controller**：用于 broker 状态的高级监控与控制。
- **App Shared Subscription Controller**：用于查看、创建或删除 Application 共享订阅。
- **Auth Controller**：用于查看当前用户信息及修改密码。
- **Client Session Controller**：用于查看 Client Session 信息、断开连接并清除它们。
- **Login Endpoint**：用于用户认证及获取 JWT token 数据。
- **MQTT Client Credentials Controller**：用于查看、创建或删除 MQTT 客户端凭证。
- **Retained Msg Controller**：用于查看主题保留消息信息，并强制清理存储保留消息的数据结构。
- **Subscription Controller**：用于查看 Client 订阅信息，并强制清理存储订阅的数据结构。
- **Time series Controller**：用于获取和删除历史统计数据。
- **Unauthorized Client Controller**：用于获取和删除系统中的未授权客户端。
- **WebSocket Connection Controller**：用于为 WebSocket 客户端创建、获取和删除 WebSocket 连接。
- **WebSocket Subscription Controller**：用于为 WebSocket 客户端创建、获取和删除 WebSocket 订阅。
