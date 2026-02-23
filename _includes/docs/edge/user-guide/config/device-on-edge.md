* TOC
{:toc}

## 概述

**Edge Devices** 是可生成遥测数据并处理 RPC 命令的基本物联网实体。它们是物理对象，如传感器、执行器、开关等，可在本地或附近网络采集、处理和传输数据，而非仅依赖集中式 Cloud 系统。

要更好地理解 **ThingsBoard 平台** 背景下作为实体的 **Devices**，请参阅 [this documentation](/docs/{{peDocsPrefix}}user-guide/ui/devices/){:target="_blank"}。

## Edge 实例上的设备管理

**Device** 实体可直接在 **Edge 实例** 上创建，并在连接建立后自动推送到 **Cloud (Server)**。对 **Device** 实体所做的任何更改都会无缝配置到 **Cloud (Server)**，无需额外操作，确保更新在所有 **Edge** 实例间同步。

在 **Edge 实例** 上创建 **Device** 后，其也会被推送到 **Cloud (Server)** 进行创建，确保整个系统的一致性和高效管理。

## 在 Edge 实例上创建设备
{% capture local-deployment %}
创建 **Device** 前，请确保已创建并配置 [Device Profile](/docs/{{peDocsPrefix}}user-guide/device-profiles/){: target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

您可以手动创建和配置 **Device**，使用 [Bulk Provisioning](/docs/{{peDocsPrefix}}user-guide/bulk-provisioning/){: target="_blank"} 选项从 CSV 文件部署多个设备，或使用 [REST API](/docs/{{peDocsPrefix}}api/){: target="_blank"} 进行程序化部署。
要手动创建 **Device**，请按以下说明操作：

{% include images-gallery.html imageCollection="create-device" showListImageTitles="true" %}

## 从 Cloud 分配设备到 Edge

**Devices** 可在 **Cloud (Server)** 上创建，然后配置到 **Edge 实例**。
请登录 **Server (Cloud)** 并进入 **Edge management > Instances** 区域。

{% include images-gallery.html imageCollection="assignment-from-cloud" showListImageTitles="true" %}

## 下一步

{% include templates/edge/guides-banner-edge.md %}
