* TOC
{:toc}

在发布应用之前，您可能希望对其进行完善。每个应用应有自己的标识。因此，我们建议在发布前设置唯一的标签名称和应用启动图标。

## 更改应用名称

以下是使用终端更改应用标签名称的简单步骤：

### 安装Rename包

首先，全局激活rename包：

```bash
flutter pub global activate rename
```
{: .copy-code}

### 为两个平台设置相同的应用名称

使用此命令，您将为iOS和Android平台获得相同的应用名称：

```bash
rename setAppName --targets android,ios --value "您所需的应用名称"
```
{: .copy-code}

### 为每个平台设置不同名称

如果您希望每个平台有不同的名称，只需运行：

```bash
rename setAppName --targets ios --value "您的iOS应用名称"
```
{: .copy-code}
```bash
rename setAppName --targets android --value "您的Android应用名称"
```
{: .copy-code}

## 更改包名

{% capture package_name_notice %}
**请注意：**您的包名应与ThingsBoard平台上移动中心配置的包名相同。
{% endcapture %}
{% include templates/info-banner.md content=package_name_notice %}

### 设置包名

```bash
rename setBundleId --targets android --value "org.yourCompany.app"
```
{: .copy-code}
```bash
rename setBundleId --targets ios --value "org.yourCompany.app.ios"
```
{: .copy-code}

{% capture platform_limitation %}
**当前ThingsBoard平台限制：**每个应用应有唯一的包名，即使它们适用于不同平台。因此我们在iOS包名中添加了`.ios`后缀。您可以使用任何包名，只要您的iOS和Android包名不同即可。
{% endcapture %}
{% include templates/info-banner.md content=platform_limitation %}

## 更改启动图标

请参阅[应用图标和启动画面指南](/docs/{{docsPrefix}}mobile/app-icon-splash-screen/)获取自定义应用图标的详细说明。

## 构建并发布Android版本

在为[Google Play](https://support.google.com/googleplay/android-developer/answer/9859152?hl=en)准备应用的发布版本时，请遵循官方["Build and release an Android app"](https://docs.flutter.dev/deployment/android)指南。

{% capture android_build_notice %}
**重要提示：**在为发布准备应用时（例如生成构建归档），您必须在构建命令中提供`--no-tree-shake-icons`标志：
{% endcapture %}
{% include templates/info-banner.md content=android_build_notice %}

```bash
flutter build appbundle --no-tree-shake-icons
```
{: .copy-code}

## 构建并发布iOS版本

在为[App Store](https://developer.apple.com/app-store/submissions/)和[TestFlight](https://developer.apple.com/testflight/)准备应用的发布版本时，请遵循官方["Build and release an iOS app"](https://docs.flutter.dev/deployment/ios)指南。

{% capture ios_build_notice %}
**重要提示：**在为发布准备应用时（例如生成构建归档），您必须在构建命令中提供`--no-tree-shake-icons`标志：
{% endcapture %}
{% include templates/info-banner.md content=ios_build_notice %}

```bash
flutter build ipa --no-tree-shake-icons
```
{: .copy-code}
