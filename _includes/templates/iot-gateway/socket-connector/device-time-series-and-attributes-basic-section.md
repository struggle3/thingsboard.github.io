本 converter 面向二进制 payload。它直接解析二进制数据以获取 attribute 和 time series，使用特定字节位置进行数据提取。

添加新的 time series 或 attribute key 时，请按以下步骤操作：

{% assign creatingAttrAndTimeseries = '
    ===
        image: /images/gateway/socket-connector/socket-adding-device-1-ce.png,
        title: 点击“**Attributes**”部分的“**铅笔**”图标以添加新 attribute key；
    ===
        image: /images/gateway/socket-connector/socket-adding-device-2-ce.png,
        title: 在打开窗口中点击“**Add attribute**”；
    ===
        image: /images/gateway/socket-connector/socket-adding-device-4-ce.png,
        title: 输入 **key 名称**并填写 **字节位置**。点击“**Apply**”；
    ===
        image: /images/gateway/socket-connector/socket-adding-device-5-ce.png,
        title: 点击“**Time series**”部分的“**铅笔**”图标以添加新 time series key；
    ===
        image: /images/gateway/socket-connector/socket-adding-device-6-ce.png,
        title: 在打开窗口中点击“**Add time series**”；
    ===
        image: /images/gateway/socket-connector/socket-adding-device-7-ce.png,
        title: 输入 **key 名称**、填写 **字节位置**并点击“**Apply**”。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingAttrAndTimeseries %}

可为每个 time series 或 attribute 启用特定的上报策略。该策略定义数据发送到 ThingsBoard 服务器的频率。可用策略如下：

- **On report period（按上报周期）** - 在上报周期后向 ThingsBoard 发送数据；
- **On value change（按值变化）** - 值变化时向 ThingsBoard 发送数据；
- **On value change or report period（按值变化或上报周期）** - 值变化或到达上报周期时向 ThingsBoard 发送数据；
- **On received（按接收）** - 从设备接收数据后向 ThingsBoard 发送数据（默认策略）。

![image](/images/gateway/socket-connector/socket-adding-device-9-ce.png)

{% capture difference %}
更多关于 report strategy 的信息请参见[此处](/docs/iot-gateway/features-overview/report-strategy){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
