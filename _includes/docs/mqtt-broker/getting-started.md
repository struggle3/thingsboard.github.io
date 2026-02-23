{% include templates/mqtt-broker/pe-tbmq-explore-banner.md %}

* TOC
{:toc}

## 简介

本教程旨在演示 <a target="_blank" href="/products/mqtt-broker/">TBMQ</a> 的基本用法。
通过本教程，您将掌握以下能力：

* 建立 MQTT 客户端与 broker 之间的连接。
* 发布 MQTT 消息。
* 订阅 topic 以接收已发布的消息。
* 配置 MQTT 客户端的认证和授权机制。

有关 TBMQ 架构的更多信息，请参阅以下[文档](/docs/{{docsPrefix}}mqtt-broker/architecture/)。
该文档详细介绍了 broker 的内部结构和设计原理。

## 试用在线演示

使用我们在 [demo.tbmq.io](https://demo.tbmq.io){:target="_blank"} 提供的免费公共 MQTT broker 是快速上手 TBMQ 的最便捷方式。
该沙箱环境让您无需安装即可体验 TBMQ 功能。

**MQTT 连接信息：**

| Parameter | Value           |
|-----------|-----------------|
| Host      | demo.tbmq.io    |
| TCP Port  | 1883            |
| TLS Port  | 8883            |
| Username  | demo            |
| Password  | *(留空)* |

使用上述凭据，您可以立即开始发布和订阅 topic。
要访问 TBMQ UI 并查看会话、订阅和其他功能，请[注册](https://demo.tbmq.io/signup){:target="_blank"}免费账户。

{% capture demo_note %}
演示实例提供只读 UI 访问。您可以查看所有会话、订阅和 broker 统计数据，但无法修改配置。
如需在本地运行具有完整管理权限的 TBMQ，请前往[本地安装 TBMQ](#install-tbmq-{{tbmqSuffixLc}}-locally) 部分。
{% endcapture %}
{% include templates/info-banner.md content=demo_note %}

## 本地安装 TBMQ {{tbmqSuffix}}

要完全掌控 TBMQ {{tbmqSuffix}} 实例，您可以在本地安装。
不同平台的详细说明请参阅[安装选项](/docs/{{docsPrefix}}mqtt-broker/install/installation-options)文档。

请按以下步骤进行快速本地安装。

{% capture contenttogglespec %}
Linux & Mac OS%,%linuxmacos%,%templates/mqtt-broker/install/linux-macos/linux-macos.md%br%
Windows%,%windows%,%templates/mqtt-broker/install/windows/windows.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tbmqGettingStartedInstallation" toggle-spec=contenttogglespec %}

{% if docsPrefix == "pe/" %}

在继续之前，请确保已选择订阅计划或购买永久许可证。
如尚未操作，请访问[定价页面](/pricing/?section=tbmq-options){: target="_blank"}对比可选方案，并获取您的许可证密钥。

{% capture replace_tbmq_license_secret %}
请用您之前获取的许可证密钥更新 `docker-compose.yml` 文件。
打开文件，找到 **TBMQ_LICENSE_SECRET** 环境变量，
并将 **YOUR_LICENSE_KEY_HERE** 替换为您的实际许可证密钥。
更新文件后，运行以下命令重启 TBMQ。
{% endcapture %}
{% include templates/warn-banner.md content=replace_tbmq_license_secret %}
 
```shell
./tbmq-install-and-run.sh
```
{: .copy-code}

{% endif %}

本地部署安装完成后，您可通过以下 URL 访问 TBMQ UI：**http://localhost:8083**。
请耐心等待服务启动。登录时使用以下默认凭据。

**Username:**
```text
sysadmin@thingsboard.org
```
{: .copy-code}

**Password:**
```text
sysadmin
```
{: .copy-code}

## 配置客户端认证与授权

{% capture auth_note %}
如使用[演示实例](https://demo.tbmq.io){:target="_blank"}，请跳过本节。演示凭据已预配置并可直接使用。
{% endcapture %}
{% include templates/info-banner.md content=auth_note %}

为保护与 broker 的连接，请[启用 Basic 认证](/docs/{{docsPrefix}}mqtt-broker/security/authentication/basic/)。

启用 Basic 认证后，创建类型为 `Basic` 的 MQTT Client Credentials 以验证连接客户端：

* 进入 _Authentication_ - _Credentials_ 选项卡，点击表格右上角的 "+"。
* 输入凭据名称。例如 "Getting Started Credentials"。
* 输入 "username" 和 "password" 的值。例如分别使用 `username` 和 `password`。
* 授权规则默认允许发布/订阅任意 topic。
* 点击 "Add" 保存凭据。

{% include images-gallery.html imageCollection="broker-mqtt-creds-creation" %}

其他认证方式请参阅[安全指南](/docs/{{docsPrefix}}mqtt-broker/security/overview/)。

## 发布和订阅 Topic

下面演示如何发布消息并订阅 topic 以观察消息流转。
本教程使用 [Mosquitto](https://mosquitto.org/) 客户端。更多详情请参阅 [mosquitto_pub](https://mosquitto.org/man/mosquitto_pub-1.html) 和 [mosquitto_sub](https://mosquitto.org/man/mosquitto_sub-1.html) 文档。

{% capture pubsubtogglespec %}
演示实例<small>demo.tbmq.io</small>%,%demo%,%templates/mqtt-broker/getting-started/pub-sub-demo.md%br%
本地部署<small>localhost</small>%,%local%,%templates/mqtt-broker/getting-started/pub-sub-local.md{% endcapture %}

{% include content-toggle.html content-toggle-id="pubSubCommand" toggle-spec=pubsubtogglespec %}

##### 结果

订阅客户端应能收到已发布的消息：

![image](/images/mqtt-broker/getting-started/broker-pub-sub.png)

## 下一步

{% assign currentGuide = "GettingStartedGuide" %}{% include templates/mqtt-broker-guides-banner.md %}
