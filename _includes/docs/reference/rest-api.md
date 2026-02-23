{% if docsPrefix == null or docsPrefix == "paas/" %}
{% assign hostName = "ThingsBoard Cloud" %}
{% assign host = "thingsboard.cloud" %}
{% endif %}
{% if docsPrefix == "paas/eu/" %}
{% assign hostName = "ThingsBoard EU Cloud" %}
{% assign host = "eu.thingsboard.cloud" %}
{% endif %}

* TOC
{:toc}

ThingsBoard 提供强大的 REST API，可管理所有平台实体、执行集成、实现设备自动 provisioning 并构建自定义应用。
为便于 API 探索与测试，ThingsBoard 内置由 [Swagger UI](https://swagger.io/){:target="_blank"} 驱动的交互式文档。

## Swagger UI

Swagger UI 是交互式工具，可用来：
- 浏览所有可用的 REST API 端点
- 查看请求与响应 schema
- 在浏览器中直接测试 API 调用
- 以指定用户身份认证并执行 API 请求

适用于开发、调试和 API 探索。

## 在哪里找到 Swagger UI？

{% if docsPrefix == null or docsPrefix == "pe/" %}
每个 ThingsBoard 实例在其地址下提供 Swagger UI 页面：

```text
http://$THINGSBOARD_HOST:PORT/swagger-ui.html
```
{: .copy-code}

&#42; 将 **$THINGSBOARD_HOST:PORT** 替换为你的 ThingsBoard 部署地址。
{% endif %}

{% if docsPrefix == "pe/" %}
获取账号的最简便方式是使用 [ThingsBoard Cloud](https://{{hostName}}/signup){:target="_blank"} 服务器。
{% endif %}

{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
每个 [{{hostName}}](https://{{host}}/){:target="_blank"} 实例都有独立的 Swagger UI 页面。   
点击下方按钮浏览 ThingsBoard Cloud REST API 文档：

<br>
<p><a href="https://{{host}}/swagger-ui.html" target="_blank" class="n-button add-device">{{hostName}} REST API</a></p>
{% endif %} 

## Swagger UI 中的认证

<b><font size="3">自动认证</font></b>

若已通过主 ThingsBoard UI 登录，Swagger UI 将自动使用当前会话。

<b><font size="3">手动认证</font></b>

可通过 Swagger UI 右上角的 **Authorize** 按钮以其他用户身份认证或授权。

步骤：
- 打开 **Swagger UI**
- 点击 **Authorize**
- 输入 **username** 与 **password**，或在 **API key 表单 (apiKey)** 中粘贴 **API key**
- 点击 **Authorize**

**注意：** 同一时间只能使用一种认证方式。   
若两种均已授权，**JWT 优先**。

{% include images-gallery.html imageCollection="swagger-ui" %}

### API key 认证

{% assign sinceVersion = "4.3" %}
{% include templates/since.md %}

API key 是比 JWT 更简单、更适合自动化的认证方式。
- **无需登录：** 不用交换密码或管理 token 刷新循环
- **长期有效：** 可持续有效或使用你设定的过期时间
- **可撤销：** 可随时禁用指定 key

{% capture difference %}
**注意：** 使用 ThingsBoard UI 中的 **API keys** 标签创建和管理。
详见 [完整文档](/docs/{{ docsPrefix }}user-guide/security/api-keys/){: target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

使用 API key

通过 API key 认证时，需在 X-Authorization 请求头中以 "**ApiKey**" 前缀携带：

```text
X-Authorization: ApiKey $YOUR_API_KEY_VALUE
```
{: .copy-code}

&#42; 将 **$YOUR_API_KEY_VALUE** 替换为你的 API key。

**重要：** API key 应仅在 HTTPS 下使用。

示例 (curl)

```text
curl -X GET --header 'Accept: application/json' \
            --header 'X-Authorization: ApiKey $YOUR_API_KEY_VALUE' \
            'http://$THINGSBOARD_URL/api/auth/user'
```

<hr>

### JWT 认证（已弃用）

ThingsBoard 使用 [JWT](https://jwt.io/){:target="_blank"} token 进行 API 请求认证。

登录时，用户名和密码会换取两个 token：
- **Access Token (JWT)** - 用于 API 请求的短期 token
- **Refresh Token** - Access Token 过期时，可用 Refresh Token 获取新的 Access Token 而无需重新登录

**默认过期时间**
- **Access Token** 有效期为 **2.5 小时**
- **Refresh Token** 有效期为 **1 周**

{% if docsPrefix == "pe/" or docsPrefix == null %}
过期时间可在系统设置中 [配置](/docs/user-guide/install/{{docsPrefix}}config/){:target="_blank"}：
- <span class="code-light">JWT_TOKEN_EXPIRATION_TIME</span>
- <span class="code-light">JWT_REFRESH_TOKEN_EXPIRATION_TIME</span>
  {% endif %}

<hr>

<b><font size="4">如何获取 JWT token？</font></b>

{% if docsPrefix == null or docsPrefix == "pe/" %}
在 "$THINGSBOARD_URL"（实际 ThingsBoard 服务器地址）上，为用户 "tenant@thingsboard.org" 与密码 "tenant" 获取 JWT token，执行以下命令：

```text
curl -X POST --header 'Content-Type: application/json' \
             --header 'Accept: application/json' \
             -d '{"username":"tenant@thingsboard.org", "password":"tenant"}' \
             'http://$THINGSBOARD_URL/api/auth/login'
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
为用户 "your_user@company.com" 与密码 "secret" 获取 JWT token，执行以下命令：

```text
curl -X POST --header 'Content-Type: application/json' \
             --header 'Accept: application/json' \
             -d '{"username":"your_user@company.com", "password":"secret"}' \
             'https://thingsboard.cloud/api/auth/login'
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/eu/" %}
为用户 "your_user@company.com" 与密码 "secret" 获取 JWT token，执行以下命令：

```text
curl -X POST --header 'Content-Type: application/json' \
             --header 'Accept: application/json' \
             -d '{"username":"your_user@company.com", "password":"secret"}' \
             'https://eu.thingsboard.cloud/api/auth/login'
```
{: .copy-code}
{% endif %}

响应：

```json
{"token":"$YOUR_JWT_TOKEN", "refreshToken":"$YOUR_JWT_REFRESH_TOKEN"}
```
{: .copy-code}

认证后，在所有 API 请求的 X-Authorization 请求头中携带获取到的 JWT token：

```text
X-Authorization: Bearer $YOUR_JWT_TOKEN
```
{: .copy-code}

## 附加工具

为便于与 ThingsBoard API 集成，可使用 ThingsBoard 官方的客户端库：

- [Java REST API Client](/docs/{{docsPrefix}}reference/rest-client/){:target="_blank"} – Java 客户端库，简化 REST API 调用
- [Python REST API Client](/docs/{{docsPrefix}}reference/python-rest-client/){:target="_blank"} – Python 客户端库，简化 REST API 调用

这些客户端可用于创建设备、资产、用户等实体，并管理其在 ThingsBoard 中的关系。