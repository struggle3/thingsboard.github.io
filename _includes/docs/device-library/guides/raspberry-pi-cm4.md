{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}

[Elastel EG500](https://www.elastel.com/products/industrial-raspberry-pi/eg500-edge-computing-gateway/){:target="_blank"} 是一款基于 **Raspberry Pi CM4** 的工业边缘计算网关。

适用于 IoT 网关、数据采集设备、工业控制器及边缘计算场景。

面向 IIoT 应用，具备：
- **工业接口**：2× GbE、2× USB、1× RS485、1× RS232、6× DI、6× DO、3× ADC
- **连接方式**：4G、LoRa、Wi-Fi/BLE、WiFi HaLow（802.11ah）
- **机箱**：工业级稳定性与防护

本教程将使用 Elastel EG500 作为边缘网关，从 RS485 Modbus 温湿度传感器采集数据，采集 DI 状态并控制 DO 开关（接 LED 灯）。EG500 将连接 ThingsBoard 实现数据可视化与 LED 控制。

## 前置条件

继续本指南前，需能访问 ThingsBoard 专业版。最简单的方式是使用 [ThingsBoard Cloud](https://thingsboard.io/installations/choose-region/){:target="_blank"}；也可按 [安装指南](/docs/user-guide/install/pe/installation-options/){:target="_blank"} 自行安装 ThingsBoard。

还需准备：

- **Elastel EG500** 设备
- **RS485 Modbus 温湿度传感器**
- **LED 灯**

### 接线示意

![wiring1](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/wiring1.png)
![wiring2](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/wiring2.png)


## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

**1. 本例使用 ThingsBoard Cloud**

注册账户后 [登录](https://thingsboard.cloud/login){:target="_blank"}。

![thingsboard_login](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/thingsboard_login.png)

<br>**2. 在 ThingsBoard 中创建设备**

进入 **「实体」** 下的 **「设备」** 页面，点击表格右上角 **「+」**，从下拉菜单选择 **「添加新设备」**。

![add_new_device](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/add_new_device.png)

<br>**3.** 输入设备名称（如 **Elastel_EG500**），点击 **「添加」**。

![add_device_name](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/add_device_name.png)

<br>**4. 复制并保存 Access token**

后续设备配置连接 ThingsBoard Cloud 时会用到。

![access token](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/access_token.png)

## Elastel 设备配置

本步将配置 Elastel EG500，从 RS485 Modbus 传感器采集数据并采集 DI/DO 状态。Elastel 设备预装 [Elastel IIoT 网关软件 ElastPro](https://www.elastel.com/iiot-gateway-software-elastpro/){:target="_blank"}，提供基于网页的配置与数据采集设置。

**1. 启动 ElastPro**

按 [该指南](https://docs.elastel.com/docs/ElastPro/Getting_Started){:target="_blank"} 启动 ElastPro。

**2. 启用数据采集**

进入 **Data Collect** -> **Basic**，启用 **Data collect**，配置 **Collect period**、**Report period**，点击 **「Apply settings」**。

![enable data collect](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/basic_setting.png)

<br>**3. 配置 RS485 串口以采集 Modbus 传感器数据**

进入 **Data Collect** -> **Interfaces**，启用 COM1 RS485 以连接 RS485 **温湿度传感器**，配置相关参数后点击 **「Apply settings」**。

![rs485 interface setting](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/rs485_interface.png)

<br>进入 **Data Collect** -> **South Devices** -> **Modbus Rules**，配置从 **温湿度传感器** 采集 Modbus 数据，然后 **「Apply settings」**。

![Modbus rule settings](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/modbus_rule_settings.png)

<br>**4. 配置 IO 口以采集 DI 状态并控制 DO**

进入 **Data Collect** -> **South Devices** -> **IO**，添加 DI、DO 设置规则，配置参数后点击 **「Apply settings」**。

![IO settings](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/io_settings.png)

## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}

进入 **Data Collect** -> **North Apps** -> **Reporting Center**，配置经 MQTT 连接 ThingsBoard 平台。

![Connect mqtt to ThingsBoard](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/mqtt_thingsboard_connect.png)

> 说明：若在 ThingsBoard 中使用自定义 MQTT 凭据，请在创建设备时在 **下一步：凭据 → MQTT Basic** 下设置，并在此处使用相同凭据。

更多配置选项请参考 [**ElastPro 用户手册**](https://docs.elastel.com/docs/ElastPro/intro){:target="_blank"}。

## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}

连接成功后，数据会出现在 ThingsBoard 中该设备的 **最新遥测** 选项卡下。

![check data on thingsboard](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/data_on_thingsboard.png)

<br>也可在 EG500 本地仪表板上查看数据。

![data on device local](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/data_on_devicelocal.png)

### 创建仪表板

下面将 Elastel EG500 的数据展示到仪表板上。更多仪表板用法见[此处](/docs/pe/user-guide/dashboards/){:target="_blank"}。

进入 **「Dashboards」** 页面，点击表格右上角 **「+」**，从下拉菜单选择 **「创建新仪表板」**。输入仪表板标题后点击 **「添加」**。

![add dashboard](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/add_dashboard.png)

<br>在仪表板编辑页点击「**+ 添加新部件**」按钮，添加[部件](/docs/pe/user-guide/widgets/){:target="_blank"}以展示遥测数据。

![添加部件](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/add_widget.png)

<br>选择合适部件模板并配置数据源。例如选择 **Value card** 显示「Temperature」数据，将 EG500 设备的「Temperature」数据键添加为数据源。

![添加温度部件](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/add_temp_widget.png)

<br>完成部件配置后点击 **「添加」**。此时已添加显示实时温度值的部件。

![温度部件](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/temperature_widget.png)

<br>同理添加部件以显示 **湿度**、**门状态** 数据，并添加 **「Power button」** 部件控制指示灯开关。
完成仪表板配置后点击 **「保存」**。

即可得到用于展示数据并控制 DO（LED 灯）的可视化仪表板。

![添加其他部件](/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/other_widget.png)

## 效果演示

<object width="100%" data="/images/devices-library/basic/single-board-computers/raspberry-pi-cm4/demonstration_show.gif"></object>

## 总结

按本指南操作即可将 Elastel IIoT 网关与 ThingsBoard 集成。Elastel 的易用 Web 界面与 ThingsBoard 的可视化能力可使边缘到云端的连接无缝完成。

- 了解更多 [**Elastel 边缘设备**](https://www.elastel.com/products/){:target="_blank"}。
- 查阅 ThingsBoard [**文档**](https://thingsboard.io/docs/pe/){:target="_blank"} 了解进阶功能与概念。
{% include add-device-banner.liquid %}