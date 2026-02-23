{% if docsPrefix == null %}
{% assign MOBILE_APPLICATION_LINK = "[ThingsBoard Mobile Application](/docs/mobile/)" %}
{% assign MOBILE_APPLICATION = "ThingsBoard Mobile Application" %}
{% assign GETTING_STARTED = "[Getting started with the ThingsBoard Mobile Application](/docs/mobile/getting-started/)" %}
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") or (docsPrefix == "paas/eu/") %}
{% assign MOBILE_APPLICATION_LINK = "[ThingsBoard PE Mobile Application](/docs/pe/mobile/)" %}
{% assign MOBILE_APPLICATION = "ThingsBoard PE Mobile Application" %}
{% assign GETTING_STARTED = "[Getting started with the ThingsBoard PE Mobile Application](/docs/pe/mobile/getting-started/)" %}
{% endif %}

* TOC
{:toc}

{% assign sinceVersion = "3.9.0" %}
{% include templates/since.md %}

**移动中心**是ThingsBoard中构建、配置和管理移动应用的一站式中心。无论您是从零开始还是准备将{{MOBILE_APPLICATION}}发布到Google Play Store或App Store，此工具都将引导您完成流程的每一步。

移动中心分为多个选项卡，便于创建和管理移动应用：

- [Bundle](#bundle)：管理bundle中包含的移动应用设置。这些设置包括为客户配置安全认证方法{% if docsPrefix == null %}、定义布局{% endif %}{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}、定义布局和管理移动应用内用户自助注册选项{% endif %}。
- [应用](/docs/{{docsPrefix}}mobile-center/applications/){:target="_blank"}：管理您的移动应用——添加新应用、编辑现有应用或移除过时版本。
- [QR code部件](/docs/{{docsPrefix}}user-guide/ui/mobile-qr-code/){:target="_blank"}：在ThingsBoard"主页"上设置QR code部件，方便用户访问移动应用。

## Bundle

**Bundle**将OAuth 2.0设置{% if docsPrefix == null %}和布局设计{% endif %}{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}、布局设计和自助注册{% endif %}等配置集中到一个或多个移动应用中——让您可以在一个地方管理Android和iOS版本。

应用的bundle提供以下设置：

1. **基本设置**：定义bundle名称并关联您的应用。还没有应用？您可以在此直接创建。
2. **OAuth 2.0**：通过集成支持OAuth 2.0的第三方身份提供方，为用户启用单点登录（SSO）。
3. **布局**：自定义应用导航菜单以匹配您的使用场景。
{% unless docsPrefix == null %}4. **自助注册**：为新的移动用户设置用户友好的注册表单。{% endunless %}

<br><b><font size="4">如何添加新bundle</font></b>

- 进入"**移动中心**"页面。
- 在"**Bundle**"选项卡中，点击窗口右上角的"**+ 添加bundle**"按钮。

将打开新的设置对话框。

{% include images-gallery.html imageCollection="add-bundle" %}

### 基本设置

输入bundle名称并选择现有的Android/iOS应用，或从此窗口[直接创建新应用](#create-new-application)。

{% include images-gallery.html imageCollection="basic-settings-1" %}

> 即使在创建带配置的bundle后，您也可以添加应用。

#### 创建新应用

- 在相应部分（Android Application或iOS Application）点击"**创建新**"。
- 输入**应用包**名称。
- **应用密钥**将自动生成。请记住或替换为您自己的。
- 设置**应用状态**：
  - **草稿**：适用于仍在开发中的应用。您可以在应用创建并发布后添加应用商店信息（如Google Play Store或App Store链接、SHA256证书指纹或App ID）。
  - **已发布**：适用于已准备好发布供最终用户使用的应用。
  - **已弃用**：适用于不再积极支持但仍可用的旧版应用。
  - **已暂停**：适用于暂时禁用或限制使用的应用。
- （可选）指定最低/最新应用版本及发布说明。
- 添加**应用商店信息**：
  - **Android**：**Google Play Store链接**和**SHA256证书指纹**。
  - **iOS**：**App Store链接**和**App ID**。
- 点击"**添加**"保存应用并完成流程。

{% include images-gallery.html imageCollection="add-application" %}

然后，点击"**下一步**"。

### OAuth 2.0

通过支持[OAuth 2.0](/docs/{{docsPrefix}}user-guide/oauth-2-support/){:target="_blank"}协议的外部提供方 为{{MOBILE_APPLICATION}}中的用户添加认证功能。
为此，指定已配置的OAuth 2.0客户端或[配置新客户端](/docs/{{docsPrefix}}user-guide/oauth-2-support/#operations-with-oauth-20-client){:target="_blank"}。完成OAuth 2.0配置后，点击"下一步"。

您也可以禁用移动设备的OAuth 2.0使用。

{% include images-gallery.html imageCollection="specify-oauth-clients" %}

### 布局

设置您最常使用的功能和仪表板的快速访问。
添加新菜单项、更改图标和项目名称，并根据您的需求重新组织{{MOBILE_APPLICATION}}的导航菜单。

{% include images-gallery.html imageCollection="layout-1" %}

要添加新菜单项，请遵循以下步骤：

- 点击页面底部或现有菜单项之间的"**+ 添加特定页面**"按钮；
- 输入**新菜单页面名称**；
- 从列表中选择**页面类型**：
  - *Dashboard* - 链接到ThingsBoard仪表板。
  - *Webview* - 链接到外部网页。
  - *Custom* - 链接到内置ThingsBoard页面。
- 根据所选的页面类型，指定仪表板或链接到外部网页或ThingsBoard菜单项；

{% if docsPrefix == null %}
- 点击"添加"；
- 配置布局后，点击"**添加**"完成bundle创建。
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
- 点击"**添加**"；
- 配置布局后，点击"**下一步**"。
{% endif %}

{% include images-gallery.html imageCollection="custom-page-type" %}

<br>
以下路由可用于"Custom"页面类型：

| **页面名称**      | **路由**     | **说明**                      |
|:-------------------|:---------------|:------------------------------------|
| Home               | /home          | 显示"主页"页面            |
| Assets             | /assets        | 显示"资产"页面          |
| Device profiles    | /devices       | 显示"设备配置"页面 |
| All devices        | /deviceList    | 显示所有设备列表    |
| Alarms             | /alarms        | 显示告警列表         |
| Dashboards         | /dashboards    | 显示仪表板列表     |
| Specific dashboard | /dashboard/:id | 显示指定仪表板    |
| Audit logs         | /auditLogs     | 显示"审计日志"页面      |
| Customers          | /customers     | 显示客户列表      |
| Specific customer  | /customer/:id  | 显示指定客户     |
| Notifications      | /notifications | 显示通知列表  |
| Custom URL link    | /url/:link     | 显示"资产"页面          |
| ---                 

{% unless docsPrefix == null %}
移动应用的菜单配置算法与桌面版ThingsBoard中的菜单自定义类似。有关菜单自定义的深入理解，请参阅[此文档](/docs/{{docsPrefix}}user-guide/custom-menu/){:target="_blank"}。
{% endunless %}

**"更多"页面**

移动应用导航菜单中显示的菜单项数量取决于您移动设备的屏幕尺寸。
底部导航菜单中放不下的项将在"更多"页面下可用。

{% include images-gallery.html imageCollection="layout-2" %}

{% unless docsPrefix == null %}

### 自助注册

**自助注册**功能允许租户为其客户配置注册页面，让他们能够轻松注册并使用预定义权限配置登录ThingsBoard。

为新客户配置自助注册表单：

- **页面标题**。输入将显示在注册页面顶部的页面标题。它作为标题向用户表明表单的用途。
- **通知接收人**。指定将接收新用户注册通知的接收人。有关通知及如何添加新通知接收人的更多信息请参阅[此处](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}。
- **重定向设置**：
  - **应用URL scheme**：定义成功注册后用于重定向用户的自定义URL scheme。例如*tbscheme*。
  - **应用URL主机名**：重定向中使用的URL的主机名部分，例如*app.pe.thingsboard.org*。

{% include images-gallery.html imageCollection="self-registration-1" %}

- **注册表单字段**。完成注册表单的必填字段为email、password和repeat password。如需，可指定其他字段。

{% include images-gallery.html imageCollection="self-registration-2" %}

- **Captcha属性**。Captcha（Completely Automated Public Turing test to tell Computers and Humans Apart）是用于区分人类用户和机器人的自动测试。
在ThingsBoard中使用Captcha有助于防止在系统中自动创建虚假账户。

要**生成Captcha**，请导航至[Google ReCaptcha管理控制台](https://www.google.com/recaptcha/intro/v3.html){:target="_blank"}：
- 选择要使用的reCAPTCHA版本：v2、v3或Enterprise。
- 指定ThingsBoard实例的域名。
- 复制并安全存储site key和secret key。

{% include images-gallery.html imageCollection="captcha" %}

**在ThingsBoard中**：
- 选择要使用的**Captcha版本**。
- 指定**Captcha site key** - 用于在网站上渲染CAPTCHA的公钥。
- 指定**Captcha secret key** - 用于在服务器上验证CAPTCHA响应的私钥。
- **Captcha log action name**：指定与CAPTCHA关联的操作，用于日志目的。

{% include images-gallery.html imageCollection="self-registration-3" %}

- **显示隐私政策**。启用或禁用注册页面上隐私政策链接的显示。
- **显示使用条款**。启用或禁用注册页面上使用条款链接的显示。
- **用户组角色**。指定用户成功注册后将分配的角色。这些角色决定用户的权限和访问级别。

{% include images-gallery.html imageCollection="self-registration-4" %}

- **高级设置**：
  - **客户组**：指定新用户将加入的客户组。
  - **客户标题前缀**：指定将添加到客户标题用于识别的前缀。
  - **自定义菜单**：为新用户应用自定义导航菜单。
  - **默认仪表板**：用户首次登录时看到的仪表板。

{% include images-gallery.html imageCollection="self-registration-5" %}

- **主页仪表板**。用户导航至"主页"菜单项时将显示的主仪表板。

{% include images-gallery.html imageCollection="self-registration-6" %}

- 点击"**添加**"完成bundle创建。

{% endunless %}

### 配置对话框

接下来将打开配置对话框。使用提供的说明继续配置您的新移动应用。
或者，如果您已有{{MOBILE_APPLICATION}}，点击"**关闭**"。

{% include images-gallery.html imageCollection="configuration-dialog" %}
{% capture difference %}
有关启动新应用的更多信息，请参阅"{{GETTING_STARTED}}"文档。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

bundle已添加。bundle中指定的应用现在使用已定义的设置。

{% include images-gallery.html imageCollection="bundle-added" %}

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
