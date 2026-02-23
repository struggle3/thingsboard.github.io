{% assign feature = "Self-registration" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

ThingsBoard 自助注册功能允许租户为客户配置注册页，使其能以预定义权限配置简单注册并登录 ThingsBoard。
该功能自 ThingsBoard PE 2.4.1 起提供。 

本文档包含完整用例配置示例。 

## 用例描述

作为租户管理员，希望允许用户在我的IoT平台实例上注册自有账户。 
注册后，希望允许其查看指定仪表板、
provisioning 自有设备或 claim 现有设备。 
从前置条件开始。

## 前置条件

### 步骤 1. 在云端安装 ThingsBoard 

需要一台运行中且启用了白标功能的 ThingsBoard PE 实例。 
可按[安装说明](/docs/user-guide/install/pe/installation-options/)部署自有 ThingsBoard PE 实例。 
实例需在云端运行并分配公网 IP。

### 步骤 2. 为 ThingsBoard IP 分配 DNS 记录

需要为 ThingsBoard 实例分配有效的 **DNS 名称**。
若暂无域名，可使用任意域名注册商。
若有域名，请联系系统管理员申请子域，例如 iot.mycompany.com。 

### 步骤 3. 为 ThingsBoard 实例配置 HTTPS 访问

参见[安装后步骤](/docs/user-guide/install/pe/ubuntu/#post-installation-steps)中的 HAProxy 安装说明。 
支持 Linux 发行版和 Docker。可为 ThingsBoard 实例申请 Let's Encrypt 证书并配置 HTTPS。

### 步骤 4. ReCAPTCHA v2

需保护注册表单免受机器人攻击。 
为此需生成 ReCAPTCHA。打开 Google ReCaptcha [管理控制台](https://www.google.com/recaptcha/intro/v3.html)，在其中使用新域名。
注意：仅使用 ReCAPTCHA v2。配置示例见下方。

![image](/images/user-guide/self-registration/reCAPTCHA.png)

将 site key 和 secret 复制保存到安全位置。

### 前置条件小结

已准备一台运行在 DigitalOcean 上的 ThingsBoard Prototype 实例。 
域名：srd.thingsboard.io（srd 表示「self registration demo」）已解析到服务器 IP：46.101.146.242。

![image](/images/user-guide/self-registration/digitalocean.png)

## ThingsBoard 配置

### 步骤 5. 邮件服务器设置

以租户管理员身份登录实例，前往 Whitelabeling —> Mail server。
使用 SMTP 服务器配置 ThingsBoard。若暂无 SMTP，可选用 [SendGrid](https://sendgrid.com/)。
更多信息见邮件设置[指南](/docs/{{docsPrefix}}user-guide/ui/mail-settings/)。

不要忘记使用「Send Test Mail」按钮验证邮件服务器设置。

![image](/images/user-guide/self-registration/mailserver.png)

### 步骤 6. 创建新用户角色

创建「Customer Administrator」角色。前往「Roles」并点击「+」。
该角色在您于租户下创建首个 Customer 实体时会自动生成。 
若尚不存在，可手动添加。 
角色类型为「Generic」，对「All」实体允许「All」操作。

![image](/images/user-guide/self-registration/customer-admin-role.png)

将该角色应用于客户用户后，客户用户可控制该客户范围内的所有实体。 
您也可创建其他角色，例如只读角色。

「Read-Only」组角色。用于对指定仪表板授予只读访问。 
该仪表板对所有自助注册客户相同。

![image](/images/user-guide/self-registration/read-only-role.png)

### 步骤 7. 创建共享仪表板

首先前往「Device Groups」->「All」，创建名为「Device A」、类型为「sensor」的示例设备。 
导入仪表板时需通过一定校验。 

然后前往 Dashboard Groups，创建名为「Shared Dashboards」的新组。
导入[简单仪表板](/docs/user-guide/resources/my_smart_devices_dashboard.json)，用于显示设备列表。 
该仪表板支持添加/编辑/删除设备。 
使用 Entity Admin Widgets Bundle 中的新部件。

此处需注意几点。 

![image](/images/user-guide/self-registration/dashboard.gif)

添加设备时的流程如下。 
此表单及其他 UI 表单均在部件配置中设置。 
进入编辑模式，点击 Edit widget，前往「Actions」。
此处有三个自定义操作。 
Delete 操作较简单，Add 和 Edit Device 操作使用名为「HTML Templates」的新功能。 
可完全控制对话框的 UI 和逻辑。 
打开「Add」操作并展开至全屏。

![image](/images/user-guide/self-registration/dashboard-config.png)
 
可见自定义 Resources、CSS、HTML、JS 选项卡。 
Add/Edit 对话框在此配置。
更多自定义操作和表单说明见单独视频教程。

![image](/images/user-guide/self-registration/action-config.png)

### 步骤 8. 配置注册表单以全屏打开仪表板 

最后配置 Signup Form。 
使用您的域名和 ReCAPTCHA 凭证。  

添加两个 User Group Roles。 
一是 Customer Administrator。新用户需能在该客户下创建和编辑任意实体。
二是对刚创建共享仪表板的 Read-Only 访问。同时将该仪表板设为默认并勾选「Always Full Screen」。

（可选）修改提示文案和隐私政策。

![image](/images/user-guide/self-registration/signup-form-config.png)

完成。自助注册表单已配置完成。保存后前往注册页。 
创建新用户，可看到其完全隔离并控制自有设备。

注册表单示例见下：

![image](/images/user-guide/self-registration/signup-form.png)


## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
