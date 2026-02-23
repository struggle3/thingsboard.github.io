* TOC
{:toc}

本文档提供在 ThingsBoard 中配置邮件服务器的分步说明。
使用邮件可发送[通知](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}、密码找回消息、定时报告及其他重要系统消息。

{% if docsPrefix == null %}
ThingsBoard 系统管理员定义全局邮件服务器设置，适用于所有客户。
{% endif %}
{% if docsPrefix == "pe/" %}

ThingsBoard 支持在两个层级配置邮件服务器：

- 系统管理员层级 – 定义适用于所有租户的全局 SMTP 设置（除非被覆盖）。
- 租户管理员层级 – 允许各租户设置自己的 SMTP，需要时可覆盖全局配置。
{% endif %}

{% unless docsPrefix == null %}
默认情况下，若未配置租户邮件服务器，系统将使用系统管理员层级的邮件服务器设置。但需要自定义邮件配置（如公司专用 SMTP 服务器）的租户可定义自己的设置。
{% endunless %}

{% capture difference %}
**注意：** 租户管理员可[配置邮件规则节点](/docs/user-guide/rule-engine-2-0/tutorials/send-email/){:target="_blank"}，通过[规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/){:target="_blank"}发送邮件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 邮件服务器配置

配置邮件服务器设置需执行以下步骤：
{% if docsPrefix == null %}
**步骤 1.** 以系统管理员身份登录 ThingsBoard 实例 WEB UI；

**步骤 2.** 进入“Settings”页面的“Mail server”选项卡。将直接进入邮件服务器设置；
{% endif %}
{% if docsPrefix == "pe/" %}
**步骤 1.** 登录 ThingsBoard 实例 WEB UI；

**步骤 2.** 进入“Settings”页面的“Mail server”选项卡。若以系统管理员身份登录，将直接进入邮件服务器设置。若以租户管理员身份登录，需取消勾选“Use System Mail Server Settings”以配置自己的邮件服务器设置；
{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
**步骤 1.** 登录 ThingsBoard 实例 WEB UI；

**步骤 2.** 进入“Settings”页面的“Mail server”选项卡。取消勾选“Use System Mail Server Settings”以配置自己的邮件服务器设置；
{% endif %}

**步骤 3.** 邮件服务器配置：
  - 填写“Mail From”字段；
  - 选择 SMTP 提供商；
  - 进入连接设置： 
    - 选择 SMTP 协议；
    - 指定 SMTP 服务器主机和端口；
    - 设置超时；
    - 可选：启用 TLS 和 Proxy；
  - 身份验证：输入 SMTP 身份验证凭据。使用“Basic”或“OAuth 2.0”身份验证方式。

**步骤 4.** 可发送测试邮件验证设置；

**步骤 5.** 最后，点击“Save”完成邮件服务器配置。

{% include images-gallery.html imageCollection="mail-server-configuration-1" %}

## 邮件服务器设置示例

自 ThingsBoard 3.5.2 起，新增了以下提供商的邮件设置模板：[Sendgrid](#sendgrid-configuration-example)、[Gmail](#gmail-configuration-with-basic-authentication-example)和[Office 365](#office-365-configuration-with-oauth2-authentication-example)。
因此用户无需手动填写 SMTP 服务器主机、端口和 TLS 等连接设置。
若需使用其他 SMTP 服务器，请选择 SMTP 提供商类型“Custom”。

### Sendgrid 配置示例

SendGrid 配置相对简单直接。首先需创建 [SendGrid](https://sendgrid.com/) 账户。
可免费试用，免费套餐通常足以进行平台评估。

**ㅤ1. 设置 SendGrid 配置**

{% include images-gallery.html imageCollection="sendgrid-configuration" showListImageTitles="true" %}

**ㅤ2. 设置 ThingsBoard 邮件服务器**

在 ThingsBoard 实例中进入“Settings”页面 -> “Mail Server”选项卡并填写表单：

- 填写“Mail From”字段；
- 选择 SMTP 提供商 - **SendGrid**；
- 输入用户名：**apikey**；
- 输入密码：此前生成的**密码**。

点击“Save”按钮。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/sendgrid-settings-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/mail/sendgrid-settings-pe.png)
{% endif %}

<br>
**ㅤ3. 发送测试邮件**

可选，可在邮箱接收测试邮件。
若配置有误，将收到包含错误日志的弹窗。

您也可在 SendGrid 网站上完成验证。

![image](/images/user-guide/ui/mail/sendgrid-it-works.png)

### 使用基本身份验证的 Gmail 配置示例

要使用 Gmail，需启用两步验证（非强制，但强烈建议）并生成[**应用密码**](https://support.google.com/accounts/answer/185833?hl=en)。

**ㅤ1. 设置 Google 账户配置**

{% include images-gallery.html imageCollection="gmail-generate-an-app-password" showListImageTitles="true" %}

**ㅤ2. 设置 ThingsBoard 邮件服务器**

准备就绪后，可使用以下信息配置邮件服务器。
在 ThingsBoard 实例中进入“Settings”页面 -> “Mail Server”选项卡并填写表单：

- 填写“Mail From”字段；
- 选择 SMTP 提供商 - **Google**；
- 输入您的邮箱作为**用户名**；
- 保持**basic**身份验证类型；
- 输入此前复制的**应用密码**。

点击“Save”按钮。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/gmail-settings-basic-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/mail/gmail-settings-basic-pe.png)
{% endif %}

<br>
**ㅤ3. 发送测试邮件**

可选，可在邮箱接收测试邮件。
若配置有误，将收到包含错误日志的弹窗。

### 使用 OAuth2 身份验证的 Gmail 配置示例

自 ThingsBoard 3.5.2 起，支持对 Gmail SMTP 服务器使用 OAuth2 授权。
使用 OAuth 2.0 协议，用户可通过 Gmail Web OAuth 进行身份验证，而无需在应用中直接输入用户名和密码。
此方式更安全，但稍复杂。

要使用 Gmail OAuth2，需在 Google Developers Console 创建项目，但先设置 ThingsBoard 邮件服务器。

**ㅤ1. 设置 ThingsBoard 邮件服务器**

- 在 ThingsBoard 实例中，进入“Settings”页面 -> “Mail Server”选项卡；
- 填写“mail From”字段；
- 选择 SMTP 提供商 - “**Google**”；
- 在“Authentication”块中，使用将用于发送邮件的邮箱地址填写用户名；
- 将身份验证类型切换为 **OAuth2**；
- 复制并保存“**Redirect URI template**”。设置 Google 项目凭据时需要用到。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/google-oauth-settings-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/mail/google-oauth-settings-1-pe.png)
{% endif %}

<br>
**ㅤ2. 在 [Google Developers Console](https://console.developers.google.com/projectcreate) 创建项目**

{% include images-gallery.html imageCollection="create-gmail-project" showListImageTitles="true" %}

**ㅤ3. 创建凭据**

{% include images-gallery.html imageCollection="create-gmail-credentials" showListImageTitles="true" %}

<br>
**ㅤ4. 完成 ThingsBoard 设置**

返回 Thingsboard 门户，将此前步骤的 **Client ID** 和 **Client secret** 粘贴到对应字段。点击“Save”。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/google-oauth-settings-2-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/mail/google-oauth-settings-2-pe.png)
{% endif %}

<br>
**ㅤ5. 生成访问令牌**

最后，可获取访问令牌。点击 **Generate access token**，浏览器将重定向至提供商登录页。
请按浏览器中的步骤操作，授权后系统将自动保存 Refresh Token 和 Access Token 并重定向回 ThingsBoard 门户。
若成功生成访问令牌，将看到状态“generated”。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/google-oauth-settings-3-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/mail/google-oauth-settings-3-pe.png)
{% endif %}

<br>
**ㅤ6. 发送测试邮件**

点击“Send test email”按钮检查是否正常。请注意，每次更改提供商信息时系统会清除 refresh 和 access token，需重新生成。

### 使用 OAuth2 身份验证的 Office 365 配置示例

自 ThingsBoard 3.6 起，支持对 Office 365 SMTP 服务器使用 OAuth2 授权。

{% capture difference %}
**请注意：**
<br>
OAuth 2.0 仅支持 Microsoft 365 账户，**不支持**个人 Outlook 账户（如 @outlook.com 或 @hotmail.com 账户）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

首先，进入“Azure directory”保存用于发送邮件的用户主体名称（若不存在，请创建或从外部服务邀请）：

 - 登录 [Azure portal](https://portal.azure.com/) 并选择 Microsoft Entra ID；
 - 选择 microsoft 用户并复制用户主体名称。

{% include images-gallery.html imageCollection="microsoft-azure-with-oauth2" %}

要使用 Office 365 OAuth2，需在 Azure portal 注册应用，但先设置 ThingsBoard 邮件服务器。

**ㅤ1. 设置 ThingsBoard 邮件服务器**：

 - 在 ThingsBoard 实例中，进入“Settings”页面 -> “Mail Server”选项卡；
 - 输入此前复制的 Microsoft 用户主体名称（如 app_user@onmicrosoft.com）；
 - 选择 SMTP 提供商 - “**Office 365**”；
 - 在“Authentication”块中，使用与 Mail From 相同的 Microsoft 用户主体名称填写用户名；
 - 将身份验证类型切换为 **OAuth2**；
 - 复制并保存“**Redirect URI template**”。设置 Azure portal 凭据时需要用到。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-1-pe.png)
{% endif %}

<br>
**ㅤ2. 在 Azure portal 注册应用**：

{% include images-gallery.html imageCollection="azure-portal" showListImageTitles="true" %}

<br>
**ㅤ3. 创建“Client secret”**：

{% include images-gallery.html imageCollection="azure-portal-2" showListImageTitles="true" %}

<br>
**ㅤ4. 为 SMTP 添加 API 权限以完成身份验证设置**：

{% include images-gallery.html imageCollection="add-api-permissions" showListImageTitles="true" %}

<br>
**ㅤ5. 完成 ThingsBoard 设置**：

返回 ThingsBoard 门户，将此前步骤的 **Client ID**、**Client secret** 和 **Directory (tenant) ID** 粘贴到对应字段。点击“Save”。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-2-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-2-pe.png)
{% endif %}

<br>
**ㅤ6. 生成访问令牌**：

最后，可获取访问令牌。点击“Generate access token”按钮，浏览器将重定向至提供商登录页。请按浏览器中的步骤操作，
授权后系统将自动保存 Refresh Token 和 Access Token 并重定向回 ThingsBoard 门户。
若成功生成访问令牌，将看到状态“generated”。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-3-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-3-pe.png)
{% endif %}

<br>
**ㅤ7. 发送测试邮件**：

点击“Send test email”按钮检查是否正常。请注意，每次更改提供商信息时系统会清除 refresh 和 access token，需重新生成。

<br>
**Office 365 故障排查**

若发送邮件时出现身份验证错误（如 5.7.3）：

1. 确认已为用户启用 SMTP 设置。前往[此处](https://portal.office.com/adminportal/home#/users)。选择用户 → Mail → Manage email apps → Authenticate SMTP（若已启用，先禁用再启用）；
2. 在 Azure portal 中确认已禁用 Security defaults。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
