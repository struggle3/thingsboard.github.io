本配置部分包含 connector 的通用设置，例如：

- **Name** - 用于日志和保存到持久化设备的 connector 名称；
- **Logs configuration（日志配置）** - 本地和远程日志设置：
  - **Enable remote logging** - 为 connector 启用远程日志；
  - **Logging level** - 本地和远程日志级别：NONE、ERROR、CRITICAL、WARNING、INFO、DEBUG、TRACE；
- **Report strategy** - 向 ThingsBoard 发送数据的策略：
  - **Report period** - 向 ThingsBoard 发送数据的周期（毫秒）；
  - **Type** - report strategy 类型：
    - **On report period** - 在上报周期后向 ThingsBoard 发送数据；
    - **On value change** - 值变化时向 ThingsBoard 发送数据；
    - **On value change or report period** - 值变化或到达上报周期时向 ThingsBoard 发送数据；
    - **On received** - 从设备接收数据后向 ThingsBoard 发送数据（默认策略）。

{% capture difference %}
更多关于 report strategy 的信息请参见[此处](/docs/iot-gateway/features-overview/report-strategy){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
