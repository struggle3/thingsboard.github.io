To add new time series or attribute key, follow these steps:

{% assign attrAndTimeseries = '
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-3-ce.png,
        title: Click the “**pencil**” icon in the “**Attributes**” section to add new attribute key;
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-4-ce.png,
        title: Click on "**Add attribute**" in the opened window;
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-5-ce.png,
        title: Enter the "**Key**" field, select the "**Type**" (can be [path](#path-types), [identifier](#identifier-types) or constant), enter "**Value**" and click "**Apply**" button;
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-6-ce.png,
        title: Now click on the “**pencil**” icon in the “**Time series**” section to add new time series key;
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-7-ce.png,
        title: Click on "**Add time series**" in the opened window;
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-8-ce.png,
        title: Enter the "**Key**" field, select the "**Type**" (can be [path](#path-types), [identifier](#identifier-types) or constant), enter "**Value**" and click "**Apply**" button.
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=attrAndTimeseries %}

您可为每个 time series 或 attribute 启用特定的上报策略。该策略定义数据发送到 ThingsBoard 服务器的频率。可用策略如下：

- **On report period**（按上报周期）- 在上报周期后向 ThingsBoard 发送数据；
- **On value change**（按值变化）- 当值变化时向 ThingsBoard 发送数据；
- **On value change or report period**（按值变化或上报周期）- 当值变化或在上报周期后向 ThingsBoard 发送数据；
- **On received**（按接收）- 从设备接收数据后向 ThingsBoard 发送数据（默认策略）。

{% capture difference %}
有关 report strategy 的更多信息请参见[此处](/docs/iot-gateway/features-overview/report-strategy){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/opc-ua-connector/opc-ua-gateway-configuring-10-ce.png)
