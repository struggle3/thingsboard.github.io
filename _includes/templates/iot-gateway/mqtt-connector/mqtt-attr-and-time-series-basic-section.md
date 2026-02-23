添加新的 time series 或 attribute key 时，请按以下步骤操作：

{% assign attrAndTimeseries = '
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-3-ce.png,
        title: 点击"**Attributes**"部分的"**铅笔**"图标以添加新 attribute key；
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-4-ce.png,
        title: 在打开窗口中点击"**Add attribute**"；
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-5-ce.png,
        title: 填写"**Key**"字段，选择"**Type**"（可为 `string`、`boolean`、`integer`、`double`，若 **Payload type** 为 `Bytes` 则可为 `Raw`），填写"**Value**"并点击"**Apply**"；
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-6-ce.png,
        title: 点击"**Time series**"部分的"**铅笔**"图标以添加新 time series key；
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-7-ce.png,
        title: 在打开窗口中点击"**Add time series**"；
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-8-ce.png,
        title: 填写"**Key**"字段，选择"**Type**"（可为 `string`、`boolean`、`integer`、`double`，若 **Payload type** 为 `Bytes` 则可为 `Raw`），填写"**Value**"并点击"**Apply**"。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=attrAndTimeseries %}

可为每个 time series 或 attribute 启用特定的上报策略。该策略定义数据发送到 ThingsBoard 服务器的频率。可用策略如下：

- **On report period（按上报周期）** - 在上报周期后向 ThingsBoard 发送数据；
- **On value change（按值变化）** - 值变化时向 ThingsBoard 发送数据；
- **On value change or report period（按值变化或上报周期）** - 值变化或到达上报周期时向 ThingsBoard 发送数据；
- **On received（按接收）** - 从设备接收数据后向 ThingsBoard 发送数据（默认策略）。

{% capture difference %}
更多关于 report strategy 的信息请参见[此处](/docs/iot-gateway/features-overview/report-strategy){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/mqtt-connector/mqtt-gateway-configuring-10-ce.png)
