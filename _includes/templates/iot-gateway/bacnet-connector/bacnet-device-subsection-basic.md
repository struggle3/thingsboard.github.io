要添加新设备，请点击 "**plus**"（加号）图标：

![image](/images/gateway/bacnet-connector/bacnet-gateway-configuring-1-ce.png)

在打开的 modal 窗口中填写以下字段：
- **Host** - 设备的主机；
- **Port** - 设备的端口；
- **Device name source** - 设备名称来源，可为：
  - **Constant** - 设备名称为静态；
  - **Expression** - 设备名称为表达式；
- **Device name value / expression** - 设备名称（详细示例见[此处](/docs/iot-gateway/config/bacnet/#usage-examples)）；
- **Device profile source** - device profile 来源，可与设备名称来源相同；
- **Device profile value / expression** - device profile 名称（详细示例见[此处](/docs/iot-gateway/config/bacnet/#usage-examples)）；
- **Poll period** - connector 轮询 BACnet 设备的时间周期；
- **Advanced configuration settings**（高级配置设置）：
  - **Alternative responses addresses** - 设备响应的备用地址（详细示例见[此处](/docs/iot-gateway/config/bacnet/#usage-examples)）。
- **Report strategy** - 向 ThingsBoard 发送数据的策略：
  - **Report period** - 向 ThingsBoard 发送数据的周期（毫秒）；
  - **Type** - report strategy 类型：
    - **On report period** - 在上报周期后向 ThingsBoard 发送数据；
    - **On value change** - 当值变化时向 ThingsBoard 发送数据；
    - **On value change or report period** - 当值变化或在上报周期后向 ThingsBoard 发送数据；
    - **On received** - 从设备接收数据后向 ThingsBoard 发送数据（默认策略）。

{% capture difference %}
所有配置参数列表及详细说明请参见[高级配置](/docs/iot-gateway/config/bacnet/#devices)部分。

更多使用示例请参见[使用示例](/docs/iot-gateway/config/bacnet/#usage-examples)部分。

有关 report strategy 的更多信息请参见[此处](/docs/iot-gateway/features-overview/report-strategy){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/bacnet-connector/bacnet-gateway-configuring-2-ce.png)
