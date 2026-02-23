{% if docsPrefix == 'pe/' %}
{% assign peDocsPrefix = "pe/" %}
{% else %}
{% assign peDocsPrefix = "" %}
{% endif %}
* TOC
{:toc}

本指南介绍如何配置自定义移动应用，使其可通过手机相机[扫描QR code](/docs/{{peDocsPrefix}}user-guide/ui/mobile-qr-code/)直接启动。

在1.7.0及更高版本中，我们通过配置文件大幅简化了QR code设置配置。

{% capture pre_1_7_0_link %} 
重要提示：请使用[本指南](/docs/{{peDocsPrefix}}mobile/qr-code-settings-before-v1.7/)进行1.7.x之前的QR code配置
{% endcapture %} {% include templates/info-banner.md content=pre_1_7_0_link %}

## 平台配置

### iOS应用设置

在ThingsBoard平台中导航至**Mobile Center → Applications → 您的自定义iOS应用**。

#### App Site Association ID

在应用商店信息设置中提供**App Site Association ID**：

![App Site Association ID配置](/images/mobile/{{peDocsPrefix}}qr-code-settings-ios-store-info.png)

App Site Association ID由两部分组成，以点分隔：

**1. App Store Team ID**
- 从[Apple Developer Account](https://developer.apple.com/account)获取您的Team ID
- 在"Membership details"区块中查找

![Team ID位置](/images/mobile/qr-code-settings-team-id.png)

**2. App Bundle ID**
- 必须与应用设置中的Application package相同
- 这是您应用的唯一标识符

### Android应用设置

在ThingsBoard平台中导航至**Mobile Center → Applications → 您的自定义Android应用**。

#### SHA-256指纹

提供您应用签名密钥的**SHA-256指纹**：

![SHA-256指纹配置](/images/mobile/{{peDocsPrefix}}qr-code-settings-sha256.png)

**通过Google Play分发的应用：**
使用Google Play Console中以下位置的SHA-256证书指纹：
**Release → Setup → App Integrity → App Signing选项卡**

![Google Play SHA-256指纹](/images/mobile/sha256-fingerprint.png)

**本地分发的应用：**
使用APK签名所用的SHA-256密钥。

更详细信息，请阅读Flutter官方文档中的指南"[Set up app links for Android](https://docs.flutter.dev/cookbook/navigation/set-up-app-links)"。
