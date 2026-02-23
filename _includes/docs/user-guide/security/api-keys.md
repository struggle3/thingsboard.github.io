* TOC
{:toc}

{% assign sinceVersion = "4.3" %}
{% include templates/since.md %}

API keys 为 ThingsBoard API 提供比密码认证更简单的替代方式。
与需要登录且定期过期的 JWT token 不同，API keys 是长期有效的凭据，在配置的过期日期之前或手动吊销前一直有效。

<hr>

<b><font size="4">Key features</font></b>

- **No login required**：API keys 无需交换用户名和密码即可立即使用。
- **Long-lived**：在您设置的过期日期前保持有效。
- **Permission inheritance**：key 继承创建该 key 的用户的全部权限。
- **Easy management**：可随时启用、禁用或删除 key。
- **Simple integration**：适合希望避免复杂认证代码的第三方应用。

<hr>

## Creating API Keys

API keys 可为 **您自己的账户** 或 **其他平台用户** 创建，具体取决于您的权限。

### Creating API Key for Your Account

为自己的账户创建 API key：
- 点击右上角的 ***three-dot*** 菜单，选择 **Account**。
- 进入 **Security** 标签。
- 在 **API keys** 区域点击 **Manage** 按钮。
- 点击 **+ Generate** 按钮。
- 输入 API key 的 **description**（如 *Production server*、*Testing environment*）。
- 选择有效期。
- 点击 **Generate**。

**重要**：复制并保存生成的 API key，之后将不再显示。

{% include images-gallery.html imageCollection="creating-api-key-for-our-account" %}

<hr>

### Creating API Key for Another User

也可在用户详情页直接创建 API key。
系统管理员可为可见的任意用户（tenant 用户）创建 API key，tenant 管理员可为客户用户创建 API key。
在用户详情视图中，API keys 标签提供该用户的完整 API key 管理能力。

- 进入 **Customers**/**Users** 区域。
- 点击目标用户打开其 **details**。
- 进入 **API keys** 标签。
- 点击 **+ Generate** 按钮。
- 输入 API key 的 **description**（如 *Production server*、*Testing environment*）。
- 选择有效期。
- 点击 **Generate**。

**重要**：复制并保存生成的 API key，之后将不再显示。

**注意**：API key 继承为其创建的用户的所有权限。

{% include images-gallery.html imageCollection="creating-api-key-for-another-user" %}

<hr>

## Using API Keys

### In API requests

在 **X-Authorization** header 中使用 **ApiKey** 前缀携带 API key：

```text
X-Authorization: ApiKey $YOUR_API_KEY_VALUE
```
{: .copy-code}

&#42; 将 **$YOUR_API_KEY_VALUE** 替换为您的 API key。

<br>示例：

```text
curl -X GET --header 'Accept: application/json' \
            --header 'X-Authorization: ApiKey tb_4xpayYjwrKCv5n15CvvS6IUb8vVZe55D-aoXcn_-hl9foOCxlEbtWYoy8bhhMqGt' \
            'https://thingsboard.cloud/api/auth/user'
```
{: .copy-code}

{% capture difference %}
**Security note**：生产环境请始终使用 HTTPS。在不安全的 HTTP 连接上执行命令会以明文传输 API key，易被窃听。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

### In Swagger UI

使用 [Swagger UI](https://swagger.io/){:target="_blank"} 时，可通过 API key 认证：

- 打开 **Swagger UI**。
- 点击 **Authorize** 按钮。
- 在 **API key form (apiKey)** 区域，输入带 **ApiKey** 前缀的 **API key value**：
  ```
  ApiKey YOUR_API_KEY_VALUE
  ```
  {: .copy-code}
- 点击 **Authorize**。

{% capture difference %}
**注意**：若同时使用 JWT 和 API key 认证，**JWT** 优先。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include images-gallery.html imageCollection="authentication-in-swagger-ui" %}

<hr>

## Managing API keys

在 API keys 表格中，每个 key 显示以下信息：
- **Created time**：API key 的生成时间
- **Description**：为 key 分配的自定义描述
- **Status**：key 为激活还是已禁用
- **Expiration time**：key 的过期日期和时间

{% include images-gallery.html imageCollection="managing-api-keys-1" %}

此外，每个 API key 可执行以下操作：
- **Enable/disable API keys** — 使用每个 API key 旁的开关临时禁用或重新启用，而无需删除 key。
- **Delete API keys** — 点击删除（垃圾桶）图标永久移除 key。此操作不可撤销。
- **Edit description** — 点击 **description** 旁的编辑（铅笔）图标更新 API key 的描述。

{% include images-gallery.html imageCollection="managing-api-keys-2" %}
