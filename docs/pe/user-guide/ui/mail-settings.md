---
layout: docwithnav-pe
assignees:
- ashvayka
title: 邮件服务器配置
description: ThingsBoard IoT 平台邮件设置

mail-server-configuration-1:
    0:
        image: /images/user-guide/ui/mail/mail-server-configuration-1-pe.png
        title: '进入"Settings"页面的"Mail server"选项卡。若以系统管理员身份登录，将直接进入邮件服务器设置。若以租户管理员身份登录，请取消勾选"Use System Mail Server Settings"以配置您自己的邮件服务器；'
    1:
        image: /images/user-guide/ui/mail/mail-server-configuration-2-pe.png
        title: '填写"Mail From"字段，选择SMTP提供商，然后进行连接设置：选择SMTP协议、指定SMTP服务器的主机和端口、设置超时；'
    2:
        image: /images/user-guide/ui/mail/mail-server-configuration-3-pe.png
        title: '可选：启用TLS和Proxy；'
    3:
        image: /images/user-guide/ui/mail/mail-server-configuration-4-pe.png
        title: '输入SMTP身份验证凭据。使用"Basic"或"OAuth 2.0"认证方式。此时可发送测试邮件以验证设置。最后点击"Save"完成邮件服务器配置。'

sendgrid-configuration:
    0:
        image: /images/user-guide/ui/mail/sendgrid-welcome.png
        title: '创建账户后将跳转至欢迎页。点击"Start"按钮；'
    1:
        image: /images/user-guide/ui/mail/sendgrid-smtp-relay.png
        title: '进入"Email API"部分->"Integration Guide"页面，选择设置方法-"SMTP Relay"；'
    2:
        image: /images/user-guide/ui/mail/sendgrid-token.png
        title: '创建API密钥：输入API密钥名称并生成。'

gmail-generate-an-app-password:
    0:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-1.png
        title: '进入您的Google账户，导航至"Security"页面。然后选择"2-Step Verification"选项卡；'
    1:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-2.png
        title: '在页面底部选择"App passwords"；'
    2:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-3.png
        title: '点击"Select app"并在下拉菜单中选择"Other"应用；'
    3:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-4.png
        title: '输入应用名称并点击"Generate"按钮；'
    4:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-5.png
        title: '复制并保存应用密码。'

create-gmail-project:
    0:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-1-pe.png
        title: '输入"Project name"和"Location"。然后点击"Create"。新项目已创建。'

create-gmail-credentials:
    0:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-2-pe.png
        title: '选择已创建的项目并导航至"APIs & Services"页面；'
    1:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-3-pe.png
        title: '点击"Credentials"选项卡，然后点击"Create Credentials"按钮并选择"OAuth client ID"；'
    2:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-4-pe.png
        title: '在"Create OAuth client ID"窗口中选择应用类型-"Web application"并输入OAuth2客户端名称。然后在"Authorized redirect URIs"部分点击"+ Add URI"按钮并粘贴之前复制的"Redirect URI template"。点击"Create"；'
    3:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-5-pe.png
        title: '保存创建的client ID和client secret以备后续步骤使用。'

microsoft-azure-with-oauth2:
    0:
        image: /images/user-guide/ui/mail/azure-create-application-1.png
        title: '登录Azure门户并选择Microsoft Entra ID；'
    1:
        image: /images/user-guide/ui/mail/microsoft-azure-copy-user-principal-name-1-pe.png
        title: '选择Microsoft用户并复制用户主体名称。'

azure-portal:
    0:
        image: /images/user-guide/ui/mail/azure-create-application-2.png
        title: '在"Manage"部分选择"App registrations"页面，点击"New registration"按钮；'
    1:
        image: /images/user-guide/ui/mail/azure-create-application-3.png
        title: '输入应用程序名称并粘贴之前复制的"Redirect URI template"。点击"Register"按钮；'
    2:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-4-pe.png
        title: '应用创建后可在"Overview"页面找到"Client ID"和"Directory (tenant) ID"。保存以供后续步骤使用。'

azure-portal-2:
    0:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-5-pe.png
        title: 'Select "Certificates & secrets" > "Client secrets" > click "New client secret" button;'
    1:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-6-pe.png
        title: 'Add a description for your client secret. Select an expiration for the secret or specify a custom lifetime. Click "Add";'
    2:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-7-pe.png
        title: 'Save client secret value for future step.'

add-api-permissions:
    0:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-1-pe.png
        title: '在Azure门户中进入"API permissions"页面，点击"Add a permission"按钮；'
    1:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-2-pe.png
        title: '选择API-"Microsoft Graph"；'
    2:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-3-pe.png
        title: '选择权限类型-"Delegated permissions"；'
    3:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-4-pe.png
        title: '搜索并勾选"SMTP.Send"权限。然后点击"Add permissions"按钮；'
    4:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-5-pe.png
        title: '权限已更新。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ui/mail-settings.md %}