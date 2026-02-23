{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% assign peDocsPrefix = "pe/" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% assign peDocsPrefix = "" %}
{% endif %}
* TOC
{:toc}

本指南将带您创建并发布适用于**iOS**和**Android**的{{appPrefix}}移动应用**1.7.x**版本。

{% capture contribution_note %}
如需发布早于**1.7.x**的版本，请使用[旧版指南](/docs/{{peDocsPrefix}}mobile/release-before-v1.7/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=contribution_note %}

<br><b><font size="5">开始之前</font></b>

假定您已在[移动中心](/docs/{{docsPrefix}}mobile-center/mobile-center/){:target="_blank"}[创建了应用bundle](/docs/{{docsPrefix}}mobile/getting-started/#step-1-create-a-bundle-in-the-mobile-center){:target="_blank"}并下载了生成的**configs.json**文件。

如需更改任何设置：
  - 在移动中心更新。
  - 重新下载configs.json。
  - 替换项目中的文件。
{% capture config_note %}
请勿手动编辑**configs.json**。始终在**移动中心**管理设置，以保持所有环境同步并减少配置错误。
{% endcapture %}
{% include templates/info-banner.md content=config_note %}

{% assign releaseRedownloadConfigCE = '
    ===
        image: /images/mobile/release-redownload-config-1-ce.png,
    ===
        image: /images/mobile/release-redownload-config-2-ce.png,
'
%}

{% assign releaseRedownloadConfigPE = '
    ===
        image: /images/mobile/pe/release-redownload-config-1-pe.png,
    ===
        image: /images/mobile/pe/release-redownload-config-2-pe.png,
'
%}

{% if docsPrefix == "pe/" %}
{% include images-gallery.liquid imageCollection=releaseRedownloadConfigPE %}
{% else %}  
{% include images-gallery.liquid imageCollection=releaseRedownloadConfigCE %}
{% endif %}

## iOS — 构建与发布

在为[App Store](https://developer.apple.com/app-store/submissions/){:target="_blank"}和[TestFlight](https://developer.apple.com/testflight/){:target="_blank"}准备应用的发布版本时，请遵循官方["Build and release an IOS app"](https://docs.flutter.dev/deployment/ios){:target="_blank"}指南。

{% capture ios_build_notice %}
**重要提示：**在为发布准备应用时（例如生成构建归档），您必须在构建命令中提供`--no-tree-shake-icons`标志以及带配置文件的`--dart-define-from-file`标志：
{% endcapture %}
{% include templates/info-banner.md content=ios_build_notice %}

Flutter构建命令：

```bash
flutter build ipa --no-tree-shake-icons --dart-define-from-file configs.json
```
{: .copy-code}

## Android — 构建与发布

在为[Google Play](https://support.google.com/googleplay/android-developer/answer/9859152?hl=en){:target="_blank"}准备应用的发布版本时，请遵循官方["Build and release an Android app"](https://docs.flutter.dev/deployment/android){:target="_blank"}指南。

{% capture android_build_notice %}
**重要提示：**在为发布准备应用时（例如生成构建归档），您必须在构建命令中提供`--no-tree-shake-icons`标志以及带配置文件的`--dart-define-from-file`标志：
{% endcapture %}
{% include templates/info-banner.md content=android_build_notice %}

Flutter构建命令：

```bash
flutter build appbundle --no-tree-shake-icons --dart-define-from-file configs.json
```
{: .copy-code}

## 构建标志说明

**`--no-tree-shake-icons`**
    防止Flutter在构建过程中移除未使用的图标，从而使移动应用能够显示在通知中心设置为通知的任何图标。

**`--dart-define-from-file configs.json`**
    从移动中心下载的JSON文件加载{{appPrefix}}移动应用配置，确保您的应用使用正确的生产环境设置。
