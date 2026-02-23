* TOC
{:toc}

## 概述

TBMQ 专业版支持基于支持 OAuth 2.0 协议的外部用户管理平台，为用户提供单点登录（SSO），并自动创建 Administrator 或 Viewer。
支持 OAuth 2.0 的平台示例：[Google](#login-with-google)、[Auth0](#login-with-auth0)、[Keycloak](#login-with-keycloak)、[Okta](https://www.okta.com/){:target="_blank"}、[Azure](https://portal.azure.com/){:target="_blank"}等。

## OAuth 2.0 认证流程

TBMQ 支持授权码（Authorization Code）许可类型，用授权码换取访问令牌。
用户被重定向回 TBMQ 客户端后，平台从 URL 获取授权码，并向外部用户管理平台请求访问令牌。
通过[基础映射器](#basic-mapper)或[自定义映射器](#custom-mapper)，将外部平台的用户信息转换为 TBMQ 内部 OAuth 2.0 用户。
随后执行常规 TBMQ 授权流程。

## 通过外部提供商配置认证

OAuth 2.0 客户端与域名分开配置，可复用已配置客户端并简化设置。
要通过外部提供商认证，需先配置带必要凭据的 OAuth 2.0 客户端。
然后添加新域名或使用已有域名，并将新客户端加入该域名的 OAuth 2.0 客户端列表。

### 域名操作

**添加域名**

添加新域名按以下步骤：

* 在“OAuth 2.0”页的“域名”标签中，点击“加号”图标添加新域名；
* 填写域名及 OAuth 2.0 客户端；
* 点击“添加”完成。

{% include images-gallery.html imageCollection="adding-domain-1" %}

**编辑域名**

更新已有域名设置，按以下步骤：

* 点击域名查看详情；
* 点击大橙色按钮进入编辑模式；
* 进行所需修改；
* 点击“应用更改”保存。

{% include images-gallery.html imageCollection="editing-domain-1" %}

**删除域名**

删除域名，按以下步骤：

* 点击要删除域名行的“垃圾桶”图标；
* 在确认对话框中点击“是”。

{% include images-gallery.html imageCollection="deleting-domain-1" %}

### OAuth 2.0 客户端操作

**添加 OAuth 2.0 客户端**

在 TBMQ 中添加新 OAuth 2.0 客户端，按以下步骤：

* 进入“OAuth 2.0”页的“OAuth 2.0 客户端”标签，点击“加号”图标；
* 输入客户端描述性标题；
* 从下拉菜单选择认证提供商；
* 填写从认证提供商获取的 Client ID 和 Client Secret；
* 按需配置高级设置；
* 点击“添加”完成。

{% include images-gallery.html imageCollection="adding-oauth2-client-1" %}

**编辑 OAuth 2.0 客户端**

更新已有 OAuth 2.0 客户端：

* 点击客户端查看详情；
* 点击大橙色按钮进入编辑模式；
* 进行所需修改；
* 点击“应用更改”保存。

{% include images-gallery.html imageCollection="editing-oauth2-client-1" %}

**删除 OAuth 2.0 客户端**

删除不再使用的客户端：

* 点击要删除客户端行的“垃圾桶”图标；
* 在确认对话框中点击“是”。

{% include images-gallery.html imageCollection="deleting-oauth2-client-1" %}

## 使用 Google 登录

本示例使用 [Google](https://developers.google.com/identity/protocols/oauth2/openid-connect){:target="_blank"} 进行认证。

将 Google 外部用户信息映射到 OAuth 平台时，可使用内置[基础映射器](#basic-mapper)。
若[基础映射器](#basic-mapper)不满足业务需求，可配置[自定义映射器](#custom-mapper)以获得更多灵活性。

### 准备工作

使用 Google OAuth 2.0 认证前，需在 [Google API Console](https://console.developers.google.com/){:target="_blank"} 中创建项目以获取 OAuth 2.0 凭据。

参考 [OpenID Connect](https://developers.google.com/identity/protocols/oauth2/openid-connect){:target="_blank"} 页面说明或下方步骤配置 OAuth 2.0 客户端。
配置完成后将获得 Client ID 和 Client Secret。

* 在左侧菜单进入“凭据”页，在“创建凭据”下拉中选择“OAuth 客户端 ID”；
* 输入 OAuth 客户端名称，并在“已授权的重定向 URI”中加入 TBMQ 重定向 URI，格式如下：

```
http(s)://domain:port/login/oauth2/code/
```
{: .copy-code}

* 将 `domain` 替换为您的 TBMQ 域名，并指定 HTTP 访问端口。
  若域名为 *my.tbmq.org*，示例：

```
https://my.tbmq.org/login/oauth2/code/
```

* 点击“创建”。

OAuth 客户端已创建，您将获得 *Client ID* 和 *Client Secret*。

{% include images-gallery.html imageCollection="google-credentials-for-oauth-1" %}

### 在 TBMQ 中将 Google 配置为 OAuth 2.0 认证提供商

在 TBMQ 中通过 Google 配置 OAuth 2.0 认证，按以下步骤：

* 登录 TBMQ 实例；
* 进入“安全”下的“OAuth 2.0”页面；
* 在“域名”标签中点击“加号”图标；
* 输入 TBMQ 实例的域名或 IP 地址；
* 在“OAuth 2.0 客户端”中点击“创建新”添加客户端。

{% include images-gallery.html imageCollection="google-configuration-of-thingsboard-google-1" %}

添加新 OAuth 2.0 客户端：

* 标题输入“Google”；
* 提供商选择“Google”；
* 填入 [Google API Console](https://console.developers.google.com/){:target="_blank"} 中的 Client ID 和 Client Secret。

展开“高级设置”并配置“通用”区块：

* 使用此[链接](https://developers.google.com/identity/protocols/oauth2/openid-connect#discovery){:target="_blank"}查看最新 URL（如“Access Token URI”“Authorization URI”）；
* 客户端认证方法选择“POST”；
* 启用“允许创建用户”；
* 在 scope 字段添加：`email`、`openid`、`profile`。

{% include images-gallery.html imageCollection="google-configuration-of-thingsboard-google-2" %}

在“映射器”区块：

* 映射器类型保持“BASIC”；
* 指定要分配的角色；
* 点击“添加”。

{% include images-gallery.html imageCollection="google-configuration-of-thingsboard-google-3" %}

* OAuth 客户端已成功添加。再次点击“添加”确认域名添加。

新域名已添加完成。

{% include images-gallery.html imageCollection="google-configuration-of-thingsboard-google-4" %}

### 登录

进入 TBMQ 登录页后，将出现“使用 Google 登录”选项。
选择您的 Google 账户，即可使用该邮箱登录 TBMQ。

{% include images-gallery.html imageCollection="login-with-google-1" %}

在“用户”页面可查看新创建的用户。

{% include images-gallery.html imageCollection="login-with-google-2" %}

## 使用 Auth0 登录

本示例通过外部提供商 [Auth0](https://auth0.com/){:target="_blank"} 配置 **OAuth** 认证。

将 Auth0 外部用户信息映射到 OAuth 平台时，使用内置[基础映射器](#basic-mapper)。

若[基础映射器](#basic-mapper)不满足需求，可配置[自定义映射器](#custom-mapper)以实现所需映射。

### Preparations

Now let's add another provider to our list – [Auth0](https://auth0.com/){:target="_blank"}.

To apply the configuration properly, we first need to obtain OAuth 2.0 credentials:

* Go to the [Auth0 management console](https://manage.auth0.com/){:target="_blank"}. Open the "Applications" page, and click the "+ Create Application" button;
* Name your application "TBMQ" and choose the application type **Regular Web Applications**;
* Next, choose the technology being used. Please select **Java Spring Boot**;
* Once your application is created, you are redirected to the application details page. Navigate to the **Settings** tab to find the *Client ID* and *Client Secret*;
* In the **Allowed Callback URLs** field, update the redirect URI using the format:

```
http(s)://domain:port/login/oauth2/code/
```
{: .copy-code}

* Replace `domain` with your TBMQ domain and specify the port used for HTTP access.
  For example, if your domain is *my.tbmq.org*:

```
https://my.tbmq.org/login/oauth2/code/
```

{% capture difference %}
Please note that it is not necessary to update the Application Login URI.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

* In the **Advanced Settings** section, you will find all the necessary URLs (endpoints) required for configuring OAuth 2.0;
* Click the **Save Changes** button.

{% include images-gallery.html imageCollection="auth0-credentials-1" %}

### Configuring Auth0 as an OAuth 2.0 authentication provider in TBMQ

To configure OAuth 2.0 authentication in TBMQ via Auth0, follow these steps:

* Log in to your TBMQ instance;
* Go to the "OAuth 2.0" page in the "Security" section;
* On the "Domains" tab, click the "plus" icon;
* Enter your domain name or IP address of your TBMQ instance;
* Click "Create new" in the "OAuth 2.0 clients" section to add a new one.

{% include images-gallery.html imageCollection="oauth0-configuration-of-thingsboard-1" %}

Adding a new OAuth 2.0 client:

* In the opened window, enter **Auth0** as the title for the client;
* Select **Custom** as the provider from the dropdown;
* Enter the *Client ID* and *Client Secret* obtained from the [Auth0 management console](https://manage.auth0.com/){:target="_blank"}.

In the **General** block of the "Advanced settings" section:

* Fill in all the required URLs using the values obtained from the [Auth0 management console](https://manage.auth0.com/){:target="_blank"};
* Select **POST** as the client authentication method;
* Enter **Auth0** as the provider label;
* Add the following scopes to the scope field: `openid`, `email`, `profile`.

{% include images-gallery.html imageCollection="oauth0-configuration-of-thingsboard-2" %}

<br>
Proceed to the "Mapper" block:
- Leave the mapper type as **BASIC**;
- Specify the role to be used;
- Click **Add** to complete the addition of the new OAuth 2.0 client.

{% include images-gallery.html imageCollection="oauth0-configuration-of-thingsboard-3" %}

* The Auth0 client has been successfully added. Click **Add** again to confirm the addition of the domain.

{% include images-gallery.html imageCollection="oauth0-configuration-of-thingsboard-4" %}

### Sign in

Navigate to the login screen. You will now find the login method Auth0.
Click the "Login with Auth0" button.

{% include images-gallery.html imageCollection="login-with-oauth0-1" %}

Go to the "Users" page. There you will find that a new user has been created.

{% include images-gallery.html imageCollection="login-with-oauth0-2" %}

## 使用 Keycloak 登录

本示例使用 [Keycloak](https://www.keycloak.org/){:target="_blank"} 进行认证。

将 Keycloak 外部用户信息映射到 OAuth 平台时，使用内置[基础映射器](#basic-mapper)。

若[基础映射器](#basic-mapper)不满足需求，可配置[自定义映射器](#custom-mapper)以实现所需映射。

### Preparations

To use Keycloak for authentication, you need to set up a project in [Keycloak](https://www.keycloak.org/){:target="_blank"} to obtain OAuth 2.0 credentials.
Follow the [official instructions](https://www.keycloak.org/guides){:target="_blank"} or the steps below.
By the end, you should have a new Keycloak client with credentials consisting of a Client ID and a Client Secret.

**Start Keycloak**

Get started with Keycloak using your [preferred method](https://www.keycloak.org/guides){:target="_blank"}.
In this example, we will run a test Keycloak server on Docker.

* Make sure you have [Docker](https://docs.docker.com/compose/install/){:target="_blank"} installed;
* Run the command below to start Keycloak locally on port 8081 and create an initial admin user with the username **admin** and password **admin**:

```bash
docker run -p 8081:8080 -e KC_BOOTSTRAP_ADMIN_USERNAME=admin -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:26.0.5 start-dev
```
{: .copy-code}

{% include images-gallery.html imageCollection="terminal-start-keycloak" %}

**Log in to the admin console**

* Log in to the [Keycloak Admin Console](http://localhost:8081/admin){:target="_blank"} using **admin** as username and password.

{% include images-gallery.html imageCollection="log-in-to-admin-console" %}

**Create a realm**

* Click "Keycloak" next to the master realm, then click the "Create realm" button;
* Enter **ThingsBoard** in the realm name field, and click "Create".

The new realm has been created.

{% include images-gallery.html imageCollection="create-new-realm" %}

**Create a new client**

A client represents an application or service that requests user authentication.

* Go to the "Clients" page in the left-hand menu, and click the "Create client" button;
* Enter **thingsboard** as the client ID. Leave the client type as **OpenID Connect**. Click "Next";
* Enable the **Client authentication** option. Confirm that **Standard flow** is enabled. Click "Next";
* In the "Login settings" section, add the TBMQ redirect URI in the **Authorized Redirect URIs** section using the format:

```
http(s)://domain:port/login/oauth2/code/
```
{: .copy-code}

* Replace `domain` with your TBMQ domain and specify the port used for HTTP access.
  For example, if your domain is *my.thingsboard.instance*:

```
https://my.thingsboard.instance/login/oauth2/code/
```

* Click "Save".

Client created successfully.

{% include images-gallery.html imageCollection="create-client" %}

<br>
You now have credentials consisting of a Client ID and a Client Secret.  
The Client ID is available on the "Settings" tab. The Client Secret is located on the "Credentials" tab.

{% include images-gallery.html imageCollection="client-id-and-secret" %}

#### Endpoints

As a fully compliant OpenID Connect Provider, Keycloak exposes a set of endpoints that applications and services can use for authentication and authorization.

* Go to the "Realm settings" page;
* Scroll down and locate the "OpenID Endpoint Configuration" link, then click it;
* A new window will open with the configuration. Check the "Pretty-print" option for easier reading.

Here you can find values such as **Access Token URI**, **Authorization URI**, **JSON Web Key URI**, and **User Info URI**, which are required for configuring the OAuth 2.0 client in TBMQ.
A description of the available endpoints is provided [here](https://www.keycloak.org/securing-apps/oidc-layers){:target="_blank"}.

{% include images-gallery.html imageCollection="endpoint-configuration" %}

### Create a user

Now add a user. Only added users will be able to authenticate via Keycloak.

* Go to the "Users" page in the left-hand menu;
* Click "Create new user";
* Enter the username and email address. First name and last name are optional;
* Click "Create".

The user has been created.

{% include images-gallery.html imageCollection="create-user" %}

Set a password for this user:

* Navigate to the "Credentials" tab and click **Set password**;
* Fill in the password form. Toggle **Temporary** to **Off** so that the user is not forced to change the password on first login;
* Click **Save password**.

The password has been set successfully.

{% include images-gallery.html imageCollection="create-password" %}

### Configuring Keycloak as an OAuth 2.0 authentication provider in TBMQ

To configure OAuth 2.0 authentication in TBMQ via Keycloak, follow the steps below:

* Log in to your TBMQ instance;
* Go to the "OAuth 2.0" page of the "Security" section;
* Navigate to the "OAuth 2.0 clients" tab, and click the "plus" icon;
* Enter **Keycloak** as the title;
* Select **Custom** as the provider from the dropdown menu;
* Enter the *Client ID* and *Client Secret* retrieved from the [Keycloak console](http://localhost:8081/admin){:target="_blank"}.

Then expand the "Advanced settings" menu and configure the "General" block:

* Use the [endpoint configuration file](#endpoints) to find the current values for **Access Token URI**, **Authorization URI**, **JSON Web Key URI**, and **User Info URI**. Fill in the corresponding fields;
* Set the client authentication method to **POST**;
* Enter **Keycloak** as the provider label;
* Add the following scopes: `email`, `openid`, `profile`.

{% include images-gallery.html imageCollection="keycloak-add-thingsboard-oauth-client-1" %}

Go to the "Mapper" block:

* Leave the mapper type as **BASIC**;
* Specify the role to be used;
* Click **Add** to confirm.

A new OAuth 2.0 client has been added.

{% include images-gallery.html imageCollection="keycloak-add-thingsboard-oauth-client-2" %}

<br>
Now, add a new domain:

* Go to the "Domains" tab of the "OAuth 2.0" page, and click the "plus" icon;
* Enter your domain name or IP address of your TBMQ instance;
* Specify **Keycloak** as the OAuth 2.0 client;
* Click **Add** again to confirm.

A new domain has been added.

{% include images-gallery.html imageCollection="keycloak-add-domain" %}

### Sign in

Go to the TBMQ login screen. You will now see the option **Login with Keycloak**.
Click this button. A window will open prompting you to sign in to your Keycloak account.
Enter your Keycloak credentials and click **Sign In**. You are now logged into TBMQ using Keycloak.

{% include images-gallery.html imageCollection="login-with-keycloak-1" %}

Go to the "Users" page. There you will find that a new user has been created.

{% include images-gallery.html imageCollection="login-with-keycloak-2" %}

## 将外部用户映射到 TBMQ 内部用户结构

将外部用户信息对象映射为 TBMQ 用户时，可使用 [Basic](#basic-mapper)、[Custom](#custom-mapper)、GitHub 和 Apple 映射器。

### 基础映射器

基础映射器按预定义规则将外部 OAuth 2.0 用户信息对象合并为 TBMQ OAuth 2.0 用户。

使用基础映射器时，将映射器类型设为 **Basic**。

{% include images-gallery.html imageCollection="mapper-basic-1" %}

可用属性说明：

* **允许创建用户**：启用后，若 TBMQ 中尚不存在该用户账户，将自动创建。
  禁用时，若没有对应的 TBMQ 用户，使用外部 OAuth 2.0 提供商登录将返回 *access denied* 错误。

* **邮箱属性键**：外部 OAuth 2.0 用户信息中用于 TBMQ 用户邮箱的属性键。

* **名属性键**：外部 OAuth 2.0 用户信息中用于 TBMQ 用户名的属性键。

* **姓属性键**：外部 OAuth 2.0 用户信息中用于 TBMQ 用户姓的属性键。

* **角色**：从预定义角色中选择分配给用户的角色。

> {% include templates/mqtt-broker/security/user-password.md %}

### 自定义映射器

若基础映射器不满足业务需求，可配置自定义映射器以实现所需逻辑。

自定义映射器为与 TBMQ 微服务并列运行的独立微服务。
TBMQ 将所有映射请求转发至该微服务，并期望返回 TBMQ OAuth 2.0 用户对象。

可参考此[基础实现](https://github.com/thingsboard/tbmq-custom-oauth2-mapper){:target="_blank"}作为自定义映射器起点。

使用自定义映射器时，将映射器类型设为 **Custom**。

{% include images-gallery.html imageCollection="mapper-custom-1" %}

可用属性说明：

* **URL**：自定义映射器端点的 URL；
* **username**：若自定义映射器端点启用了基本认证，在此填写 *username*；
* **password**：若自定义映射器端点启用了基本认证，在此填写 *password*。

## HAProxy 配置

若 TBMQ 运行在 HAProxy 等负载均衡器之后，需正确配置均衡算法以确保会话落在同一 TBMQ 实例：

```bash
backend tbmq-api-backend
  ...
  balance source # balance 必须设为 'source'
  ...
```

同时为 HTTP 和 HTTPS 请求配置 ACL 映射：

```bash
frontend http-in
  ...
  acl tbmq_api_acl path_beg /api/ /swagger /webjars /v2/ /oauth2/ /login/oauth2/ # '/oauth2/ /login/oauth2/' added
  ...
```

```bash
frontend https_in
  ...
  acl tbmq_api_acl path_beg /api/ /swagger /webjars /v2/ /oauth2/ /login/oauth2/ # '/oauth2/ /login/oauth2/' added
  ...
```
