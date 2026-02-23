{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% assign appProject = "flutter_thingsboard_pe_app" %}
{% assign cloudApp = "[ThingsBoard Cloud](https://thingsboard.cloud/signup)" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% assign appProject = "flutter_thingsboard_app" %}
{% endif %}

* TOC
{:toc}

欢迎！本指南将带您从零开始为{{appPrefix}}实例创建和配置您自己的{{appPrefix}}移动应用。

**开始之前**，请使用[兼容性表](/docs/{% if docsPrefix == 'pe/' %}pe/{% endif %}mobile/#compatibility-table){:target="_blank"}选择与ThingsBoard平台匹配的移动应用版本。使用不兼容的版本是登录问题或意外行为的最常见原因。

## 前置条件

- 可访问{{appPrefix}}实例。最简单的方式是使用[ThingsBoard Cloud](https://thingsboard.io/installations/)。或者，使用官方[安装指南](/docs/user-guide/install/{{docsPrefix}}installation-options/){:target="_blank"}安装{{appPrefix}}。
- 准备构建{{appPrefix}}移动应用的环境：
  - [安装Flutter SDK](https://flutter.dev/docs/get-started/install){:target="_blank"}，版本需与您的应用版本对应（参见[兼容性表](/docs/{% if docsPrefix == 'pe/' %}pe/{% endif %}mobile/#compatibility-table){:target="_blank"}）。
  - （推荐）[为Flutter开发配置您的IDE（如Visual Studio Code）](https://flutter.dev/docs/get-started/editor){:target="_blank"}。
  - 如果您是Flutter新手，请[查阅"编写您的第一个Flutter应用"教程](https://flutter.dev/docs/get-started/test-drive){:target="_blank"}。

## 步骤1：在移动中心创建bundle

[移动中心](/docs/{{docsPrefix}}mobile-center/mobile-center/){:target="_blank"}是创建、配置和管理移动应用的控制中心。
它让您能够快速启动为{{appPrefix}}平台定制的移动应用。

<br>

<b><font size="4">创建新bundle</font></b>

[bundle](/docs/{{docsPrefix}}mobile-center/mobile-center/#bundle){:target="_blank"}包含您的Android和/或iOS应用配置——包括[OAuth 2.0](/docs/{{docsPrefix}}user-guide/oauth-2-support/){:target="_blank"}设置{% if docsPrefix == null %}以及[布局](/docs/mobile-center/mobile-center/#layout){:target="_blank"}偏好{% endif %}{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}、[布局](/docs/pe/mobile-center/mobile-center/#layout){:target="_blank"}偏好和[自助注册](/docs/pe/mobile-center/mobile-center/#self-registration){:target="_blank"}选项{% endif %}——全部集中在一处，便于设置。

添加新bundle：
- 进入"**移动中心**"页面。
- 在"**Bundle**"选项卡中，点击右上角的"**+ 添加bundle**"按钮。

创建bundle对话框将打开。

{% assign addNewBundleCE = '
    ===
        image: /images/mobile-center/add-new-bundle-1-ce.png,
        title: 进入"**移动中心**"页面 → "**Bundle**"选项卡，然后点击右上角的"**+ 添加bundle**"。
'
%}

{% assign addNewBundlePE = '
    ===
        image: /images/mobile-center/add-new-bundle-1-pe.png,
title: 进入"**移动中心**"页面 → "**Bundle**"选项卡，然后点击右上角的"**+ 添加bundle**"。
'
%}

{% if docsPrefix == "pe/" %}
{% include images-gallery.liquid imageCollection=addNewBundlePE %}
{% else %}  
{% include images-gallery.liquid imageCollection=addNewBundleCE %}
{% endif %}

<br><b><font size="4">基本设置</font></b>

- 输入**bundle标题**。
- 在目标移动平台（**Android**或**iOS**）旁点击"**创建新**"。
  这将打开**添加应用**对话框：
  - 输入**应用包**名称。
  - **应用密钥**将自动生成（您也可以设置自己的）。
  - 设置**已发布**应用状态——应用已准备好发布。
  - （可选）指定**最低**和**最新**应用版本及发布说明。
  - 添加**应用商店信息**：
      - **Android**：
        - **Google Play Store链接**。
        - **SHA256证书指纹**。
      - **iOS**：
        - **App Store链接**。
        - **App ID**。
  - 点击"**添加**"保存并继续。

- 然后点击"**下一步**"。

{% assign addNewBundleCE2 = '
    ===
        image: /images/mobile/getting-started/add-new-bundle-2-ce.png,
        title: 在相应部分（Android Application或iOS Application）点击"**创建新**"。
    ===
        image: /images/mobile/getting-started/add-new-bundle-3-ce.png,
        title: **Android Application**。输入**应用包**名称。记住自动生成的"**应用密钥**"或输入您自己的。指定应用状态。可选：为每个应用指定最低和最新版本及发布说明。指定应用商店信息：Google Play Store中ThingsBoard PE移动应用的链接，以及**SHA256证书指纹**。点击"**添加**"。
    ===
        image: /images/mobile/getting-started/add-new-bundle-4-ce.png,
        title: **iOS Application**。输入**应用包**名称。记住自动生成的"**应用密钥**"或输入您自己的。指定应用状态。可选：为每个应用指定最低和最新版本及发布说明。指定应用商店信息：App Store中ThingsBoard PE移动应用的链接，以及**App ID**。点击"**添加**"。
    ===
        image: /images/mobile/getting-started/add-new-bundle-5-ce.png,
        title: 点击"**下一步**"。
'
%}

{% assign addNewBundlePE2 = '
    ===
        image: /images/mobile/getting-started/add-new-bundle-2-pe.png,
        title: 在相应部分（Android Application或iOS Application）点击"**创建新**"。
    ===
        image: /images/mobile/getting-started/add-new-bundle-3-pe.png,
        title: **Android Application**。输入**应用包**名称。记住自动生成的"**应用密钥**"或输入您自己的。指定应用状态。可选：为每个应用指定最低和最新版本及发布说明。指定应用商店信息：Google Play Store中ThingsBoard PE移动应用的链接，以及**SHA256证书指纹**。点击"**添加**"。
    ===
        image: /images/mobile/getting-started/add-new-bundle-4-pe.png,
        title: **iOS Application**。输入**应用包**名称。记住自动生成的"**应用密钥**"或输入您自己的。指定应用状态。可选：为每个应用指定最低和最新版本及发布说明。指定应用商店信息：App Store中ThingsBoard PE移动应用的链接，以及**App ID**。点击"**添加**"。
    ===
        image: /images/mobile/getting-started/add-new-bundle-5-pe.png,
        title: 点击"**下一步**"。
'
%}

{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.liquid imageCollection=addNewBundlePE2 %}
{% else %}  
{% include images-gallery.liquid imageCollection=addNewBundleCE2 %}
{% endif %}

<br><b><font size="4">可选：认证与布局</font></b>

- **OAuth 2.0提供方**——如需要，为{{appPrefix}}移动应用配置外部[OAuth](/docs/{{docsPrefix}}user-guide/oauth-2-support/){:target="_blank"}。完成后点击"**下一步**"。

- **配置布局**——自定义导航菜单以便快速访问功能和仪表板。添加菜单项、设置图标/标签并重新排序条目。点击"**添加**"完成bundle创建。

{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
- **自助注册** - 为新客户自定义[自助注册](/docs/{{docsPrefix}}mobile-center/mobile-center/#self-registration){:target="_blank"}页面。
{% endif %}

使用外部[OAuth 2.0](/docs/{{docsPrefix}}user-guide/oauth-2-support/){:target="_blank"}提供方在{{appPrefix}}移动应用中配置认证，{% if docsPrefix == null %}并配置[布局](/docs/{{docsPrefix}}mobile-center/mobile-center/#layout){:target="_blank"}以便快速访问您最常使用的功能和仪表板{% endif %}{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}，配置[布局](/docs/{{docsPrefix}}mobile-center/mobile-center/#layout){:target="_blank"}以便快速访问您最常使用的功能和仪表板，并自定义新客户的[自助注册](/docs/{{docsPrefix}}mobile-center/mobile-center/#self-registration){:target="_blank"}页面{% endif %}。

{% assign addNewBundleCE3 = '
    ===
        image: /images/mobile/getting-started/add-new-bundle-6-ce.png,
        title: 使用外部**OAuth 2.0**提供方在{{appPrefix}}移动应用中配置认证。然后点击"**下一步**"继续。
    ===
        image: /images/mobile/getting-started/add-new-bundle-7-ce.png,
        title: 配置**布局**以便快速访问您最常使用的功能和仪表板。添加新菜单项、自定义图标和标签，并重新组织ThingsBoard PE移动应用的导航菜单以符合您的需求。点击"**添加**"完成bundle添加。
'
%}

{% assign addNewBundlePE3 = '
    ===
        image: /images/mobile/getting-started/add-new-bundle-6-pe.png,
        title: 使用外部**OAuth 2.0**提供方在{{appPrefix}}移动应用中配置认证。然后点击"**下一步**"继续。
    ===
        image: /images/mobile/getting-started/add-new-bundle-7-pe.png,
        title: 配置**布局**以便快速访问您最常使用的功能和仪表板。添加新菜单项、自定义图标和标签，并重新组织ThingsBoard PE移动应用的导航菜单以符合您的需求。点击"**下一步**"继续。
    ===
        image: /images/mobile/getting-started/add-new-bundle-8-pe.png,
        title: 为新客户自定义**自助注册**页面。点击"**添加**"完成bundle添加。
'
%}

{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.liquid imageCollection=addNewBundlePE3 %}
{% else %}
{% include images-gallery.liquid imageCollection=addNewBundleCE3 %}
{% endif %}

点击"**添加**"完成bundle添加。

<br><b><font size="4">配置对话框</font></b>

添加bundle后，将出现分步对话框引导您完成剩余的设置和部署步骤。
请仔细遵循以完成{{appPrefix}}移动应用配置。

{% capture 1_7_config_tip %}
**自{{appPrefix}} 4.2和移动应用1.7起可用**

自{{appPrefix}} 4.2和移动应用1.7起，应用配置流程已显著改进。
您现在可以直接从平台下载配置文件并将其置于应用代码库根目录——无需手动编辑。

使用1.7应用版本配合4.2之前平台版本时，必须手动创建配置文件，请参阅[此GitHub工单](https://github.com/thingsboard/flutter_thingsboard_pe_app/issues/263#issuecomment-3103099009){:target="_blank"}获取说明。
{% endcapture %}
{% include templates/info-banner.md content=1_7_config_tip %}

**重要：**
构建或运行应用时，请包含Dart define标志：

```
flutter run --dart-define-from-file configs.json
```
{:.copy-code}

您可以使用不同名称维护多个配置文件。将相应的文件名传给`--dart-define-from-file`标志。

{% assign configurationDialogCE = '
    ===
        image: /images/mobile/getting-started/add-new-bundle-11-ce.png,
'
%}

{% assign configurationDialogPE = '
    ===
        image: /images/mobile/getting-started/add-new-bundle-11-pe.png,
'
%}

{% if docsPrefix == "pe/" %}
{% include images-gallery.liquid imageCollection=configurationDialogPE %}
{% else %}
{% include images-gallery.liquid imageCollection=configurationDialogCE %}
{% endif %}

<br>
最后，根据您的移动平台（Android或iOS），您应看到类似以下的结果：

<br>

<div style="display: flex; flex-direction: row;">
    <div style="display: flex; flex-direction: column; align-items: center;">
        <img width="" src="/images/mobile/{{docsPrefix}}android-app-login.png" title="Android登录界面" alt="Android login screen example">
        <span style="margin-top: 16px; font-size: 90%; color: #6c757d;">Android</span>
    </div>
    <div style="display: flex; flex-direction: column; align-items: center;">
        <img width="" src="/images/mobile/{{docsPrefix}}ios-app-login.png" title="iOS登录界面" alt="iOS login screen example">
        <span style="margin-top: 16px; font-size: 90%; color: #6c757d;">iOS</span>
    </div>
</div>

{% capture run_tip %}
**提示：**在真机上首次启动可能需要一段时间。之后，可使用hot reload进行快速更新。

如果使用`flutter run`从控制台启动，按`r`进行hot reload。
{% endcapture %}
{% include templates/info-banner.md content=run_tip %}

## 步骤2.[可选]配置推送通知

我们的系统利用Firebase将ThingsBoard实例的通知直接发送到移动应用。
此设置要求每个平台租户为其账户专门配置Firebase，才能开始向其移动应用分发通知。

<br><font size="5">步骤2.1 创建Firebase项目</font>

接下来，我们将逐步介绍如何创建Firebase项目，并在其中生成私钥。此密钥用于安全地将ThingsBoard实例连接到Firebase服务。

{% capture difference %}
**请注意：**
ThingsBoard CE中，仅系统管理员可配置移动设置。ThingsBoard PE中，租户可使用系统管理员的配置或指定自己的配置。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

开始操作：

{% assign firebaseProjectCE = '
    ===
        image: /images/mobile/pe/firebase-new-project-1-pe.png,
        title: 登录您的[Firebase](https://console.firebase.google.com/){:target="_blank"}账户。登录后，点击"Create a project"按钮；
    ===
        image: /images/mobile/pe/firebase-new-project-2-pe.png,
        title: 在提供的字段中输入您所需的项目名称，然后点击"Continue"；
    ===
        image: /images/mobile/pe/firebase-new-project-3-pe.png,
        title: 接下来是决定是否为本项目启用Google Analytics。您可以选择启用或禁用。做出选择后，点击"Continue"；
    ===
        image: /images/mobile/pe/firebase-new-project-4-pe.png,
        title: 设置Google Analytics后，点击"Create project"按钮确认项目创建；
    ===
        image: /images/mobile/pe/firebase-new-project-5-pe.png,
        title: 您的Firebase项目已准备就绪。点击"Continue"打开Firebase项目控制面板；
    ===
        image: /images/mobile/pe/firebase-new-project-6-pe.png,
        title: 在左侧菜单中，进入"Project Overview" -> "Project settings"页面；
    ===
        image: /images/mobile/pe/firebase-new-project-7-pe.png,
        title: 在"Project settings"页面中，切换到"Cloud Messaging"选项卡。此处确保启用Firebase Cloud Messaging API以使用消息功能；
    ===
        image: /images/mobile/pe/firebase-new-project-8-pe.png,
        title: 接下来进入"Service accounts"选项卡。在"Admin SDK configuration snippet"中，选择"Java"部分。然后，点击"Generate new private key"按钮。此操作将为您的服务账户生成私钥——对安全服务器通信至关重要；
    ===
        image: /images/mobile/pe/firebase-new-project-9-pe.png,
        title: 点击"Generate key"按钮确认私钥生成。请妥善保管此密钥，ThingsBoard服务器端操作需要用到；
    ===
        image: /images/mobile/pe/firebase-new-project-10-ce.png,
        title: 以系统管理员身份登录ThingsBoard，打开"Settings"页面并导航至"Notifications"选项卡。在"Mobile settings"部分，上传您在Firebase项目中生成的私钥文件并点击"Save"完成配置。
'
%}

{% assign firebaseProjectPE = '
    ===
        image: /images/mobile/pe/firebase-new-project-1-pe.png,
        title: 登录您的[Firebase](https://console.firebase.google.com/){:target="_blank"}账户。登录后，点击"Create a project"按钮；
    ===
        image: /images/mobile/pe/firebase-new-project-2-pe.png,
        title: 在提供的字段中输入您所需的项目名称，然后点击"Continue"；
    ===
        image: /images/mobile/pe/firebase-new-project-3-pe.png,
        title: 接下来是决定是否为本项目启用Google Analytics。您可以选择启用或禁用。做出选择后，点击"Continue"；
    ===
        image: /images/mobile/pe/firebase-new-project-4-pe.png,
        title: 设置Google Analytics后，点击"Create project"按钮确认项目创建；
    ===
        image: /images/mobile/pe/firebase-new-project-5-pe.png,
        title: 您的Firebase项目已准备就绪。点击"Continue"打开Firebase项目控制面板；
    ===
        image: /images/mobile/pe/firebase-new-project-6-pe.png,
        title: 在左侧菜单中，进入"Project Overview" -> "Project settings"页面；
    ===
        image: /images/mobile/pe/firebase-new-project-7-pe.png,
        title: 在"Project settings"页面中，切换到"Cloud Messaging"选项卡。此处确保启用Firebase Cloud Messaging API以使用消息功能；
    ===
        image: /images/mobile/pe/firebase-new-project-8-pe.png,
        title: 接下来进入"Service accounts"选项卡。在"Admin SDK configuration snippet"中，选择"Java"部分。然后，点击"Generate new private key"按钮。此操作将为您的服务账户生成私钥——对安全服务器通信至关重要；
    ===
        image: /images/mobile/pe/firebase-new-project-9-pe.png,
        title: 点击"Generate key"按钮确认私钥生成。请妥善保管此密钥，ThingsBoard服务器端操作需要用到；
    ===
        image: /images/mobile/pe/firebase-new-project-10-pe.png,
        title: 登录ThingsBoard实例并打开"Settings"页面。导航至"Notifications"选项卡，在"Mobile settings"部分取消勾选"Use system mobile settings"（若以租户身份登录）。在此处上传您在Firebase项目中生成的私钥文件并点击"Save"完成配置。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=firebaseProjectPE %}
{% else %}  
{% include images-gallery.liquid showListImageTitles="true" imageCollection=firebaseProjectCE %}
{% endif %}

<br><font size="5">步骤2.2 将Firebase添加到移动应用</font>

要将Firebase集成到移动应用中，您需要完成Firebase官方文档中["Add Firebase to your Flutter app"](https://firebase.google.com/docs/flutter/setup)指南概述的**前两个步骤**。

<br><font size="4">[仅限iOS] Apple应用配置</font>

将**APNs认证密钥**上传到Firebase。

- 首先，使用[Apple官方文档](https://developer.apple.com/help/account/manage-keys/create-a-private-key/){:target="_blank"}在[Apple Developer Member Center](https://developer.apple.com/membercenter/index.action){:target="_blank"}创建APNs认证密钥；
- 在您的[Firebase](https://console.firebase.google.com/){:target="_blank"}项目中，进入"Project Settings"页面的"Cloud Messaging"选项卡。向下滚动找到"Apple app configuration"部分；
- 在"APNs authentication key"中点击"Upload"按钮；
- 添加APNs认证密钥并在相应字段中输入"Key ID"和"Team ID"；
- 然后点击"Upload"按钮。

{% assign APNsAuthenticationKey = '
    ===
        image: /images/mobile/apple-app-configuration-1.png,
        title: 在您的[Firebase](https://console.firebase.google.com/){:target="_blank"}项目中，进入"Project Settings"页面的"Cloud Messaging"选项卡。向下滚动找到"Apple app configuration"部分；
    ===
        image: /images/mobile/apple-app-configuration-2.png,
        title: 在"APNs authentication key"部分，点击"Upload"按钮；
    ===
        image: /images/mobile/apple-app-configuration-3.png,
        title: 使用[Apple官方文档](https://developer.apple.com/help/account/manage-keys/create-a-private-key/){:target="_blank"}在[Apple Developer Member Center](https://developer.apple.com/membercenter/index.action){:target="_blank"}创建"APNs authentication key"。现在添加此密钥并在相应字段中输入"Key ID"和"Team ID"。然后点击"Upload"按钮；
    ===
        image: /images/mobile/apple-app-configuration-4.png,
        title: APNs认证密钥已上传。
'
%}

APNs认证密钥已上传。

{% include images-gallery.liquid imageCollection=APNsAuthenticationKey %}

<br><font size="5">步骤2.3 检查项目配置</font>

成功完成这些步骤后，请确保您的项目包含以下文件：

- 如果ThingsBoard移动应用面向iOS：

```text
ios/Runner/GoogleService-Info.plist
```

- 如果ThingsBoard移动应用面向Android：

```text
android/app/google-services.json
```
{% capture difference %}
**请注意：**
如果**{{appProject}}**项目当前正在运行，请停止它并进行重新构建。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

要确认Firebase已正确集成，请运行您的应用。

```
flutter run
```
{:.copy-code}

如果一切配置正确，您移动应用中的通知菜单应处于激活状态，如下方截屏所示。

<br><object width="30%" data="/images/mobile/{{docsPrefix}}mobile-notifications.png"></object>

了解更多关于**通知**及如何配置[此处](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}。

## 步骤3.[可选]构建并发布移动应用

如需为iOS或Android**构建并发布**{{appPrefix}}移动应用，请参阅[本指南](/docs/{{docsPrefix}}mobile/release/){:target="_blank"}。

## 故障排除

如果在构建或运行移动应用时遇到问题，以下是帮助您解决最常见问题的详细指南。

### 应用无法构建

{{appPrefix}}移动应用支持特定的Flutter版本。我们的版本发布与Flutter官方发布并不总是同步，因此较新的Flutter版本可能尚不兼容。

> 务必使用为您的应用版本指定的确切Flutter版本。否则，构建可能失败或出现意外行为。

<b><font size="4">如何检查所需的Flutter版本？</font></b>

{% if docsPrefix == null %}
1. 查看以下[链接](https://github.com/thingsboard/flutter_thingsboard_app/releases){:target="_blank"}的发布说明。
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
1. 查看以下[链接](https://github.com/thingsboard/flutter_thingsboard_pe_app/releases){:target="_blank"}的发布说明。
{% endif %}

示例：

<object width="70%" data="/images/mobile/getting-started/check-flutter-version.png"></object>

<br>

**2. 检查项目根目录的`.fvmrc`文件：**

您将找到类似这样的文件：

```json
{
  "flutter": "3.24.4"
}
```

这表示我们当前使用Flutter 3.24.4。

<br><b><font size="4">安装正确的Flutter版本</font></b>

**选项1**：使用[FVM](https://fvm.app/){:target="_blank"}（Flutter版本管理器）**[推荐]**

**什么是FVM？**

FVM帮助您跨项目管理多个Flutter版本。它让您能够管理多个Flutter版本并轻松按项目切换。
在测试新Flutter版本或为不同项目贡献代码时非常有用。

按照[官方安装指南](https://fvm.app/documentation/getting-started/installation){:target="_blank"}安装FVM。

用法：使用带`fvm`前缀的Flutter命令，例如：

示例：

```bash
fvm flutter run
fvm flutter build apk
```

**选项2**：手动设置全局Flutter版本 **[不推荐]**

如果您只在一个项目上工作，可以手动设置全局Flutter版本：

```bash
cd ~/dev/flutter
git checkout 3.24.4
```
{:.copy-code}

### 警告"推送通知未配置"

如果您看到如下警告：

> "**推送通知未配置**"

这通常意味着Firebase未正确设置。

**修复：**

> **注意：**您必须首先完成设置指南中的[步骤2](/docs/mobile/getting-started/#step-2-optional-configure-push-notifications){:target="_blank"}。

<b>1.</b> 删除文件：`lib/firebase_options.dart`
<br><b>2.</b> 重新运行FlutterFire CLI：

```bash
flutterfire configure
```
{:.copy-code}

<b>3.</b> 确保`firebase_options.dart`文件已重新生成并包含Android和iOS或两者的配置。

### 仪表板无法加载

移动应用并非真正自行加载仪表板——ThingsBoard平台处理所有实际加载。
移动应用仅打开WebView，但应用和平台必须能够相互通信。

**首先，检查日志**。查找此日志消息：

```bash
Invoked tbMobileReadyHandler
```

- **如果未找到，表示平台未向应用发出就绪信号：**此情况下，请在[ThingsBoard平台仓库](https://github.com/thingsboard/thingsboard){:target="_blank"}提交issue。

- **如果您看到日志但仪表板仍无法加载：**{% if docsPrefix == null %}此情况下，请在[CE移动仓库](https://github.com/thingsboard/flutter_thingsboard_app/issues){:target="_blank"}提交issue。{% endif %}{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}此情况下，请在[PE移动仓库](https://github.com/thingsboard/flutter_thingsboard_pe_app/issues){:target="_blank"}提交issue。{% endif %}

*请尽可能详细，并通过ThingsBoard Support私下提供实例凭据（切勿公开发布）。*

### 无法登录？

[检查](/docs/{{docsPrefix}}/mobile/){:target="_blank"}您的平台和移动应用版本之间的兼容性表。版本不匹配是登录问题的最常见原因。

如果版本已对齐但您仍然无法登录：
{% if docsPrefix == null %}
- [提交GitHub issue](https://github.com/thingsboard/flutter_thingsboard_app/issues){:target="_blank"}。
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
- [提交GitHub issue](https://github.com/thingsboard/flutter_thingsboard_pe_app/issues){:target="_blank"}。
{% endif %}
- 包含：
  - 平台版本
  - 移动应用版本
  - 日志/截屏
  - 设备详情（OS、版本）

TB平台与移动应用版本之间存在兼容性表：[在此查看](/docs/{{docsPrefix}}/mobile/){:target="_blank"}

这是登录问题的最常见原因。

如果您的版本已对齐但仍无法工作——[提交GitHub issue](https://github.com/thingsboard/flutter_thingsboard_app/issues){:target="_blank"}并包含所有相关详情。

### 其他问题？

以上是最常见的问题——但如果您遇到新情况：

{% if docsPrefix == null %}
[提交GitHub issue](https://github.com/thingsboard/flutter_thingsboard_app/issues){:target="_blank"}。尽可能包含所有上下文（截屏、日志、版本、平台设置等）。
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
[提交GitHub issue](https://github.com/thingsboard/flutter_thingsboard_pe_app/issues){:target="_blank"}。尽可能包含所有上下文（截屏、日志、版本、平台设置等）。
{% endif %}

我们将尽力帮助您！

## 后续步骤

- [自定义应用](/docs/{{docsPrefix}}mobile/customization){:target="_blank"} - 了解如何自定义{{appPrefix}}移动应用以满足您的需求。
- [构建并发布{{appPrefix}}移动应用](/docs/{{docsPrefix}}mobile/release){:target="_blank"} - 了解如何构建、发布并将您的{{appPrefix}}移动应用版本发布到Google Play或App Store。
