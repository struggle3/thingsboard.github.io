{% if docsPrefix == null %}
{% assign THINGSBOARD_MOBILE_APP = "[ThingsBoard mobile application ](/docs/mobile/)" %}
{% assign CUSTOM_APPLICATION = "[custom application](/docs/mobile/)" %}
{% assign OFFICIALLY_PUBLISHED_APPLICATION = "**ThingsBoard Live**" %}
{% assign PREFIX = "CE" %}
{% endif %}
{% if docsPrefix == "pe/" %}
{% assign THINGSBOARD_MOBILE_APP = "[Thingsboard PE mobile application ](/docs/pe/mobile/)" %}
{% assign CUSTOM_APPLICATION = "[custom application](/docs/pe/mobile/)" %}
{% assign OFFICIALLY_PUBLISHED_APPLICATION = "**ThingsBoard Cloud**" %}
{% assign PREFIX = "PE" %}
{% endif %}
{% if docsPrefix contains "paas/" %}
{% assign THINGSBOARD_MOBILE_APP = "[Thingsboard PE mobile application ](/docs/pe/mobile/)" %}
{% assign CUSTOM_APPLICATION = "[custom application](/docs/pe/mobile/)" %}
{% assign OFFICIALLY_PUBLISHED_APPLICATION = "**ThingsBoard Cloud**" %}
{% endif %}

* TOC
{:toc}

{% assign sinceVersion = "3.7" %}
{% include templates/since.md %}

我们新增了 QR 码功能，用于简化 ThingsBoard 移动应用中的授权流程。
该功能使登录更快速、更安全，为用户提供比传统用户名密码输入更友好的方式。

## Scan to download the mobile app

{% if docsPrefix == null %}
若尚未安装 {{THINGSBOARD_MOBILE_APP}}，扫描 QR 码将引导用户前往应用商店（[Google Play](https://play.google.com/store/apps/details?id=org.thingsboard.demo.app){:target="_blank"} 和 [App Store](https://apps.apple.com/us/app/thingsboard-live/id1594355695){:target="_blank"}）。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
若尚未安装 {{THINGSBOARD_MOBILE_APP}}，扫描 QR 码将引导用户前往应用商店（[Google Play](https://play.google.com/store/apps/details?id=org.thingsboard.cloud){:target="_blank"} 和 [App Store](https://apps.apple.com/us/app/thingsboard-cloud/id6499209395){:target="_blank"}）。
{% endif %}

按下列简单步骤开始：

{% include images-gallery.html imageCollection="download-app-with-qr-code" showListImageTitles="true" %}

此外，点击“Connect mobile app”部件中的“App Store”或“Google Play”按钮，可跳转到对应应用商店的 ThingsBoard 应用页面进行下载。

{% include images-gallery.html imageCollection="clicking-button" %}

## Login with QR code

用 ThingsBoard 移动应用扫描 QR 码，即可无需手动输入凭据即时登录账户。

登录流程简单便捷：

{% include images-gallery.html imageCollection="authorize-with-qr-code" showListImageTitles="true" %}

## Configuring QR code widget on Home page

{% if docsPrefix == null %}
移动应用 QR 码部件配置仅可在 **系统级别** 进行。
请以 **系统管理员** 身份登录，进入“Mobile center”页面的“QR code widget”选项卡，关闭“Use system settings”开关。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
移动应用 QR 码部件设置默认继承自 **系统级别**。[Tenant administrators](/docs/{{docsPrefix}}user-guide/ui/tenants/){:target="_blank"} 可覆盖系统设置。请进入“Mobile center”页面的“QR code widget”选项卡，关闭“Use system settings”开关。
{% endif %}

{% include images-gallery.html imageCollection="mobile-app-qr-code-widget-settings" %}

此处有两个设置块：“Applications”和“Appearance on Home page”。

**Applications：**

Tenant 可使用两种应用类型：默认和自定义。

{% if docsPrefix == null %}
* **Default**。使用默认应用表示使用官方发布的 {{OFFICIALLY_PUBLISHED_APPLICATION}} 移动应用（[Google Play](https://play.google.com/store/apps/details?id=org.thingsboard.demo.app){:target="_blank"} 和 [App Store](https://apps.apple.com/us/app/thingsboard-live/id1594355695){:target="_blank"}）。
{% endif %}
{% if docsPrefix == "pe/" %}
* **Default**。使用默认应用表示使用官方发布的 {{OFFICIALLY_PUBLISHED_APPLICATION}} 移动应用（[Google Play](https://play.google.com/store/apps/details?id=org.thingsboard.cloud){:target="_blank"} 和 [App Store](https://apps.apple.com/us/app/thingsboard-cloud/id6499209395){:target="_blank"}）。
{% endif %}
{% if docsPrefix contains "paas/" %}
* **Default**。使用默认应用表示使用官方发布的 {{OFFICIALLY_PUBLISHED_APPLICATION}} 移动应用（[Google Play](https://play.google.com/store/apps/details?id=org.thingsboard.cloud){:target="_blank"} 和 [App Store](https://apps.apple.com/us/app/thingsboard-cloud/id6499209395){:target="_blank"}）。
{% endif %}

{% include images-gallery.html imageCollection="application-settings-default" %}

{% unless docsPrefix contains 'paas/' %}
{% capture difference %}
**注意：** {{OFFICIALLY_PUBLISHED_APPLICATION}} 移动应用最新版本 (1.2.0) 支持切换服务器 host，可与你的 ThingsBoard {{PREFIX}} 实例配合使用。在移动应用登录页选择“Login with scan QR code”选项，应用将自动切换服务器 host 到你的 ThingsBoard {{PREFIX}} 平台 host。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
{% endunless %}

* **Custom**。若希望使用自有 {{CUSTOM_APPLICATION}}，请切换到自定义设置，指定在“[Bundle](/docs/{{docsPrefix}}mobile-center/mobile-center/#bundle){:target="_blank"}”选项卡中预配置的 bundle。然后保存更改。
 
{% include images-gallery.html imageCollection="application-settings-custom" %}

{% unless docsPrefix == null or docsPrefix == "pe/" %}
{% capture difference %}
**注意：** 使用自定义移动应用时，tenant 必须在 [Domain settings](/docs/{{docsPrefix}}domains/){:target="_blank"} 中配置域名。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
{% endunless %}

可按需禁用未使用的平台。

{% include images-gallery.html imageCollection="disable-platforms" %}

<br>
在“Home”页面用移动设备[扫描 QR 码](#login-with-qr-code)，确认是否跳转到指定应用。

<br>
**Appearance on Home page：**

可在“Home”页禁用 QR 码部件、调整徽章位置，以及修改 QR 码标签以满足需求。

{% include images-gallery.html imageCollection="appearance-on-home-page" %}

## Mobile app QR code widget

ThingsBoard 3.7 发布后，新增了“Mobile app QR code”部件。可在 [dashboards](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"} 中使用该部件，简化客户在移动设备上的登录流程。

将此部件添加到 dashboard：

{% include images-gallery.html imageCollection="add-qr-code-widget" showListImageTitles="true" %}
