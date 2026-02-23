---
layout: docwithnav
title: 将 MI-8 数据发布到 ThingsBoard
description: 将 MI-8 数据发布到 ThingsBoard 指南

---

* TOC
{:toc}

## 前置条件

本教程中，我们将配置 FusionDAQ 设备以集成到 ThingsBoard。

## 技术特性

FDQ-99900 MI-8 是一款紧凑型 24 位数据采集系统（DAQ），可测量多达 10 路外部传感器，并将数值本地记录到 SD 卡或通过蜂窝数据连接推送到云端。高级触发功能使 MI-8 仅传输感兴趣的事件，从而节省存储空间与网络流量。低功耗与宽工作温度范围设计适用于户外与远程部署。MI-8 有带机箱和不带机箱两种配置，可支持定制包装方案。例如，无机箱（OEM）配置常与配套传感器和硬件一起安装到 IP-67 防护等级 NEMA 机箱中。

**特性：**
* 将数据推送到远程服务器或直接记录到 SD 卡
* LTE CAT-M1 与 CAT-NB 蜂窝频段
* 高级触发选项
* HTTP/MQTT 推送 API
* 最多两个通用 0-10V 模拟输入
* 最多四个 RTD 或应变片测量
* 最多六个热电偶输入
* 接地热电偶负共模范围处理（±2.4V）
* 支持所有主流热电偶类型（B、E、J、K、N、R、S、T）
* 14.4V 稳压输出为外部传感器供电
* 宽供电电压范围（4.8-30V）
* 适用于电池供电部署
* 集成 GPS（GNSS）接收器

<p align="center">
   <img src="/images/samples/fusion-daq/m-8-device.png" alt="m 8 device">
</p>

## 为 ThingsBoard 配置设备

包含将设备连接到 ThingsBoard 所需的说明。

### 创建 ThingsBoard 设备

在浏览器中打开 [ThingsBoard Cloud server](https://thingsboard.cloud/) 并登录。

进入「**Device groups**」选项卡 ->「**All**」，点击「plus」按钮添加新设备。

输入设备名称，选择现有或新建 [device profile](https://thingsboard.io/docs/user-guide/device-profiles/)，点击「Add」按钮。

![image](/images/samples/fusion-daq/fusion-daq-mi-8-create-device-1.png)

设备已创建。打开其详情，点击「Copy access token」按钮复制自动生成的 **access token**。

![image](/images/samples/fusion-daq/fusion-daq-mi-8-create-device-2.png)

### 配置 MI-8

获取 access token 后即可配置 MI-8。所有 MI-8 DAQ 均通过 SD 卡根目录下的 config.json 文件配置。
可从[此链接](/docs/samples/fusion-daq/resources/config.json)下载该 JSON 文件示例。
[MI-8 用户手册](https://fusiondaq.com/wp-content/uploads/2023/01/LTEdaq_OperatingManual-1.pdf)中有修改该文件的详细说明，本示例主要关注 name 和 push 字段。
这些字段描述如何连接到 ThingsBoard 或其他服务。

本示例使用的 MI-8 config.json 文件：

![image](/images/samples/fusion-daq/fusion-daq-config-json.png)

该文件中的 **name** 字段为可选。**name** 会显示在 MI-8 OLED 屏幕上，并作为设备属性发送到 ThingsBoard。最佳实践是使 config.json 中的 name 与 ThingsBoard 中的设备名称一致，但非必须。name 字段不用于 MI-8 与 ThingsBoard 之间的遥测数据关联，仅作为用户参考。

**push** 字段描述与 ThingsBoard 服务器的连接。本示例使用 HTTP POST 请求（"mode":"post"）。ThingsBoard 也支持 MQTT，但 POST 消耗的蜂窝数据更少。HTTP 请求 URL 由 **server**、**port**、**use_ssl** 和 **path/attributes_path** 字段构建。

ThingsBoard 遥测（传感器数据）请求发送到 http://thingsboard.cloud:80/api/vi/{ACCESS_TOKEN}/telemetry

**use_ssl** 字段指定使用 HTTP 还是 HTTPS。**server** 字段为双斜杠「//」和冒号之间的部分。接下来是 **port** 和一个斜杠。其余为 **path**。

将 server 设为「**thingsboard.cloud**」。Username 和 password 留空。

将 **path** 设为「api/vi/{ACCESS_TOKEN}/telemetry」，将 **attributes_path** 设为「api/vi/{ACCESS_TOKEN}/attributes」。
将 **{ACCESS_TOKEN}** 替换为 ThingsBoard 设备凭证页中的 access token。
每个设备都有唯一的 access token。
传感器数值会定期发送到 **path**，属性（name、IMEI、ICCID 等）在 MI-8 首次上电时发送到 **attributes_path**。

将 **push_attributes** 设为 true，以便在每次上电时发送一次属性（如 MI-8 IMEI 号等不常变化的数据）。

使用非加密 HTTP 推送数据时，将 **port** 设为 80，**use_ssl** 设为 false。
使用 SSL 加密（HTTPS）时，将 **port** 设为 443，**use_ssl** 设为 true。两种协议均支持，但 HTTPS 每次推送会消耗更多蜂窝数据。

将 **use_json** 设为 true。发送到 ThingsBoard 的所有数据应格式化为 JSON 以简化集成。

将 **use_headers** 设为 false。ThingsBoard 不需要 HTTP 头，且每次推送会增加蜂窝数据消耗。

最后将 **include_name**、**include_imei** 和 **include_iccid** 设为 false。这些字段会在遥测推送中包含 ICCID、IMEI 和 MI-8 名称，从而增加蜂窝数据消耗。此处无需包含，因为它们会在每次 MI-8 上电时通过单独的 attributes HTTP 请求发送到 ThingsBoard。

保存 config.json，断开 PC 与 MI-8 USB 端口的连接（若已连接且启用大容量存储），然后重启 MI-8 使新设置生效。

### 在 ThingsBoard 中验证 MI-8 连接

此时 MI-8 应已配置完毕，可与 ThingsBoard 通信。
返回 ThingsBoard 实例，进入「Device groups」->「All」。
点击刚与 MI-8 关联的设备，进入「Latest Telemetry」选项卡。
MI-8 上电并建立蜂窝连接后，[操作手册](https://fusiondaq.com/wp-content/uploads/2023/01/LTEdaq_OperatingManual-1.pdf)中配置的活跃 MI-8 触发应能显示所有传感器数值。
注意，GPS 数值仅在首次 GPS 定位后传输，根据距上次定位的时间和 MI-8 移动距离，可能需要数分钟。
GPS 数值（lat、lon 和 alt）只有在至少传输一次后才会出现在遥测窗口中。

![image](/images/samples/fusion-daq/fusion-daq-mi-8-latest-telemetry-1.png)

接下来进入「Attributes」选项卡。属性是 MI-8 发送到 ThingsBoard 的附加数据，多为相对固定、不常变化的信息，如调制解调器 IMEI、SIM ID（ICCID）和 MI-8 固件版本。
属性仅在 MI-8 每次上电时发送一次到 ThingsBoard。

![image](/images/samples/fusion-daq/fusion-daq-mi-8-attributes-1.png)

## 联系我们

如有其他问题，请[联系 Fusion DAQ](https://fusiondaq.com/contact/)。

## 下一步

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
