---
layout: docwithnav-mobile-pe
title: 在ThingsBoard PE移动应用中配置白标

login-white-labeling:
 0:
  image: /images/mobile/pe/white-labeling-1.png
  title: '租户级设置：在<b>域名</b>字段中输入域'
 1:
  image: /images/mobile/pe/white-labeling-2.png
  title: '在<b>Base URL</b>字段中输入 base url（包含协议<b>http</b>或<b>https</b>，以及若与标准<b>80</b>或<b>443</b>不同则包含端口）'
 2:
  image: /images/mobile/pe/white-labeling-3.png
  title: '在<b>Logo</b>字段中上传所需Logo图像'
 3:
  image: /images/mobile/pe/white-labeling-4.png
  title: '如需，在<b>Logo height</b>字段中指定Logo高度'
 4:
  image: /images/mobile/pe/white-labeling-5.png
  title: '在<b>Primary palette</b>字段中选择主色调'
 5:
  image: /images/mobile/pe/white-labeling-6.png
  title: '点击<b>保存</b>按钮应用更改'

login-white-labeling-result:
 0:
  image: /images/mobile/pe/white-labeling-7.png
  title: '您应在登录表单顶部看到您的Logo图像。按钮和背景应根据所选色调着色。'

white-labeling:
 0:
  image: /images/mobile/pe/white-labeling-8.png
  title: '在<b>Logo</b>字段中上传所需Logo图像'
 1:
  image: /images/mobile/pe/white-labeling-9.png
  title: '在<b>Primary palette</b>字段中选择主色调'
 2:
  image: /images/mobile/pe/white-labeling-10.png
  title: '点击<b>保存</b>按钮应用更改'

white-labeling-result:
 0:
  image: /images/mobile/pe/white-labeling-11.png
  title: '您应在主屏幕顶部栏看到您的Logo图像。按钮和图标应根据所选色调着色。'

---

* TOC
{:toc}

## 概述

ThingsBoard PE的[白标](/docs/pe/user-guide/white-labeling/)功能允许您配置公司或产品Logo和配色方案。
除ThingsBoard Web界面外，白标设置还适用于ThingsBoard PE移动应用。
使用白标您可以自定义移动应用登录屏幕和主应用界面的外观。

## 登录屏幕白标

作为系统或租户管理员，您可以在**登录白标**表单中配置应用登录屏幕的Logo和色调。

{% capture login_white_labeling_levels %}
**注意：**默认应用系统级登录白标（由系统管理员配置）。每个租户可通过在**登录白标**表单中指定**域名**来覆盖这些设置。
此情况下，将根据移动应用中配置的API endpoint域名应用租户级设置
（**lib/constants/app_constants.dart**中**thingsBoardApiEndpoint**常量的值）。
{% endcapture %}
{% include templates/info-banner.md content=login_white_labeling_levels %}

要配置登录屏幕白标，请执行以下步骤：

1. 通过屏幕左侧主菜单进入**白标** -> **登录白标**；
2. 租户级设置：在**域名**字段中输入域；
3. 在**Base URL**字段中输入base url（包含协议**http**或**https**，以及若与标准**80**或**443**不同则包含端口）；
4. 在**Logo**字段中上传所需Logo图像；
5. 如需，在**Logo height**字段中指定Logo高度；
6. 在**Primary palette**字段中选择主色调；
7. 点击**保存**按钮应用更改；

{% include images-gallery.html imageCollection="login-white-labeling" %}

要验证登录白标设置，请运行移动应用。
您应在登录表单顶部看到您的Logo图像。按钮和背景应根据所选色调着色。

{% include images-gallery.html imageCollection="login-white-labeling-result" %}

## 主应用界面白标

作为系统或租户管理员，您可以在**白标**表单中配置主应用界面的Logo和色调。

{% capture app_white_labeling_levels %}
**注意**：默认应用系统级白标（由系统管理员配置）。每个租户可在**白标**表单中覆盖这些设置。
{% endcapture %}
{% include templates/info-banner.md content=app_white_labeling_levels %}

要配置主应用界面白标，请执行以下步骤：

1. 通过屏幕左侧主菜单进入**白标** -> **白标**；
2. 在**Logo**字段中上传所需Logo图像；
3. 在**Primary palette**字段中选择主色调；
4. 点击**保存**按钮应用更改；

{% include images-gallery.html imageCollection="white-labeling" %}

要验证白标设置，请运行移动应用并执行登录。
您应在主屏幕顶部栏看到您的Logo图像。按钮和图标应根据所选色调着色。

{% include images-gallery.html imageCollection="white-labeling-result" %}
