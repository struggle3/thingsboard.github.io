{% assign deviceName = "VIBit" %}
{% assign deviceVendorLink = "https://machineastro.com/vibit/" %}
{% assign thingsboardHost = "https://" | append: hostName %}
{% assign officialManualLink = "/docs/devices-library/resources/manuals/vibit.pdf" %}
{% assign prerequisites = '
- [Sensor user guide](' | append: officialManualLink | append: '){: target="_blank"}
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
  '
  %}

## 概述

[VIBit]({{deviceVendorLink}}){:target="_blank"} 是一款紧凑、坚固的三轴振动、温度与声学传感器，适用于工业异常检测。支持 Wi-Fi 连接，可与 MachineAstro VIBit 应用无缝集成，用于配置与监控。<br><br><br><br><br>

## 前置条件

继续本指南需准备以下内容：  
- [ThingsBoard 账户]({{ thingsboardHost }}){: target="_blank"}
{{ prerequisites }}
- 手机上已安装 MachineAstro VIBit 应用。
- 传感器连接所需的 Wi-Fi 网络凭证。
- MQTT 基本凭证：
  - **Username**：sensor
  - **Password**：cimcon
  - **Client ID**：VIBit 设备 BLE MAC（传感器蓝牙 MAC 地址）


## 在 ThingsBoard 中创建设备配置文件

首先在 ThingsBoard 中创建新的设备配置文件，使用 **MQTT 传输**及标准 MQTT 主题发送遥测和属性。

- 登录 ThingsBoard 实例。
- 进入 **配置** 下的 **设备配置文件** 页面。
- 点击「**+**」按钮，从下拉菜单中选择「**添加新设备配置文件**」。
- 输入 **MQTT** 作为设备配置文件名称。
- 点击「**下一步：传输配置**」按钮。
- 选择 **MQTT** 作为传输类型。
- 保留默认的 **MQTT 设备主题过滤器**。
- 点击 **添加** 创建设备配置文件。

{% assign createDeviceProfile = '
    ===
        image: /images/devices-library/ready-to-go-devices/machine-astro/vibit-bp/vibit-create-profile-1.png,
        title: 进入 **配置** 下的 **设备配置文件** 页面，点击「**+**」按钮，从下拉菜单中选择「**添加新设备配置文件**」。
    ===
        image: /images/devices-library/ready-to-go-devices/machine-astro/vibit-bp/vibit-create-profile-2.png,
        title: 输入 **MQTT** 作为设备配置文件名称。点击「**下一步：传输配置**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/machine-astro/vibit-bp/vibit-create-profile-3.png,
        title: 选择 **MQTT** 作为传输类型。保留默认 **MQTT 设备主题过滤器**。点击 **添加** 创建设备配置文件。
    ===
        image: /images/devices-library/ready-to-go-devices/machine-astro/vibit-bp/vibit-create-profile-4.png,
        title: 设备配置文件已创建。
'
%}

{% include images-gallery.liquid imageCollection=createDeviceProfile %}

## 在 ThingsBoard 中创建设备

- 进入 **实体** 下的 **设备** 页面。
- 点击「**+**」添加新设备，从下拉菜单中选择「**添加新设备**」。
- 使用 VIBit 传感器 BLE MAC 地址作为名称（如 "F4B3B1A1EFAC"）。
- 在「设备配置文件」字段中选择此前创建的 **MQTT** 设备配置文件。
- 点击 **下一步：凭证** 按钮。
- 在 **凭证** 选项卡中：
    - 选择 **MQTT Basic** 作为凭证类型。
    - 使用 **VIBit 设备的 BLE MAC 地址** 作为 **Client ID**。
    - 输入 **sensor** 作为 **Username**。
    - 输入 **cimcon** 作为 **Password**。
- 点击 **添加** 创建设备。

{% assign createDevice = '
    ===
        image: /images/devices-library/ready-to-go-devices/machine-astro/vibit-bp/vibit-create-device-1.png,
        title: 进入 **实体** 下的 **设备** 页面。点击「**+**」添加新设备，从下拉菜单中选择「**添加新设备**」。
    ===
        image: /images/devices-library/ready-to-go-devices/machine-astro/vibit-bp/vibit-create-device-2.png,
        title: 使用 VIBit 传感器 BLE MAC 地址作为名称（如 "F4B3B1A1EFAC"）。在「设备配置文件」字段中选择此前创建的 **MQTT** 配置。点击 **下一步：凭证** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/machine-astro/vibit-bp/vibit-create-device-3.png,
        title: 在 **凭证** 选项卡中：<br> - 选择 **MQTT Basic** 作为凭证类型。<br> - 使用 **VIBit 设备的 BLE MAC 地址** 作为 **Client ID**。<br> - 输入 **sensor** 作为 **Username**。<br> - 输入 **cimcon** 作为 **Password**。<br> - 点击 **添加** 创建设备。
    ===
        image: /images/devices-library/ready-to-go-devices/machine-astro/vibit-bp/vibit-create-device-4.png,
        title: 设备已创建。
'
%}

{% include images-gallery.liquid imageCollection=createDevice %}

## 通过 VIBit 移动应用连接设备到 ThingsBoard

### 前置条件

- ThingsBoard 平台上需存在用户。
- ThingsBoard 平台上需存在 VIBit 设备。
<br>

- 为 VIBit 传感器上电。
- 在手机上打开 VIBit 移动应用。
- VIBit 移动应用可选择「**自定义**」选项并输入静态公网 IP 或 HTTPS 域名，连接任意 ThingsBoard 平台。下方为示例截图。

![image](/images/devices-library/ready-to-go-devices/machine-astro/vibit/vibit-mobile-app-1.png)

![image](/images/devices-library/ready-to-go-devices/machine-astro/vibit/vibit-mobile-app-2.png)

- 进入应用中的连接部分。将显示蓝牙范围内的 VIBit 传感器列表。

![image](/images/devices-library/ready-to-go-devices/machine-astro/vibit/vibit-mobile-app-3.png)

- 搜索对应设备并点击 **连接** 按钮。（前提是设备已在 ThingsBoard 中存在。）

![image](/images/devices-library/ready-to-go-devices/machine-astro/vibit/vibit-mobile-app-4.png)

- 在应用中配置传感器的 Wi-Fi 设置：
  - 输入 Wi-Fi SSID 和密码。
  - 输入 ThingsBoard 服务器 URL。
  - MQTT **Username** 填 sensor，**Password** 填 cimcon，**Client ID** 填 BLE MAC 地址。
  - 保存设置以应用配置。

![image](/images/devices-library/ready-to-go-devices/machine-astro/vibit/vibit-mobile-app-5.png)

![image](/images/devices-library/ready-to-go-devices/machine-astro/vibit/vibit-mobile-app-6.png)

- 在移动应用中查看云与 Wi-Fi 连接状态。

![image](/images/devices-library/ready-to-go-devices/machine-astro/vibit/vibit-mobile-app-7.png)

### 在 ThingsBoard 上查看数据

- 在 ThingsBoard 中进入「**设备**」部分，选择您的 VIBit 设备。
- 打开「**最新遥测**」选项卡查看实时数据，包括：
  - 三轴加速度与速度 RMS
  - FFT 时序数据
  - 温度与声学读数

![image](/images/devices-library/ready-to-go-devices/machine-astro/vibit/vibit-mobile-app-8.png)

{% capture difference %}
使用[仪表板](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}可视化数据趋势并分析设备长期健康状况。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 总结

通过 MQTT Basic 认证将 VIBit 与 ThingsBoard 集成，可实现工业设备的可靠、高效监控，支持预测性维护并减少停机时间。实时数据传输与完整仪表板的结合，帮助运维团队做出更明智的决策。
{% include add-device-banner.liquid %}