* TOC
{:toc}

## 概述

ThingsBoard **Over-the-Air (OTA) 更新** 功能是一种强大的远程管理设备固件或软件的方式，可减少手动更新需求并支持快速部署增强或修复。

**Edge OTA 更新** 功能与 **Platform (Cloud) OTA 更新** 设计相似。因此，**Edge OTA 更新** 包可按与 **Platform** Device 和 Device Profile 配置相同的方式，在 Device 和 Device Profile 配置中部署。
请参阅 [Platform OTA Updates documentation](/docs/{{cloudDocsPrefix}}user-guide/ota-updates/){: target="_blank"} 以了解 **OTA 更新** 功能。

## 将 OTA 包配置到 ThingsBoard 仓库

所有 **OTA 固件和软件包** 均在 Platform 上创建，并 **自动传播** 到每个连接到此 Platform 的 **Edge** 实例。无需租户管理员或用户执行额外操作。

{% capture local-deployment %}
**请注意！** <br>
**OTA 更新包** 在 **ThingsBoard Platform** 上创建。**无法** 在 **Edge** 实例上创建、修改或删除 OTA 更新包。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}
{% include images-gallery.html imageCollection="cannot-edit-on-edge" %}

### 创建 OTA 更新包

要在 **ThingsBoard Platform** 上创建 **OTA 更新** 包，请进入 **Advanced features > OTA updates** 区域并点击 **"+"** 图标。
在弹出窗口中填写以下字段：
* **Title：** 输入固件包名称。
* **Version：** 输入固件包更新版本号。
* **Version tag：** 该字段将自动填入相关信息。若输入自定义 tag，应与设备报告的包版本匹配（_可选_）。
* **Device profile：** 选择设备配置文件。
* **Package Type：** 选择包类型（_Firmware 或 Software_）。
* **"Upload binary file"/"Use external URL" radiobutton：** 选择文件包来源。根据所选选项：
  * **Package file：** 拖放包文件或从电脑浏览选择。
  * **Direct URL：** 输入文件的直接下载 URL。
* 点击 **"Add"** 按钮。_请注意：包上传后，title、version、device profile 和 package type 无法修改_。
* 确认固件包已成功上传。

{% include images-gallery.html imageCollection="createFirmware" %}

### 在 Edge 实例上验证 OTA 更新包

使用您的凭据登录 **ThingsBoard Edge** 实例，并进入 **Advanced features > OTA updates** 区域。以确认固件包已在 **Edge** 实例上 **成功配置**。

{% include images-gallery.html imageCollection="verifyFirmware" %}

## 下一步

{% include templates/edge/guides-banner-edge.md %}
