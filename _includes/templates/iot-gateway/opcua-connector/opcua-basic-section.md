此配置部分包含 OPC-UA 服务器连接设置，例如：
- **Server endpoint url**（服务器端点 URL）- OPC-UA 服务器的主机名或 IP 地址；
- **Timeout in milliseconds**（超时毫秒数）- 连接 OPC-UA 服务器的超时时间（毫秒）；
- **Security policy**（安全策略）- 安全策略（**Basic128Rsa15**、**Basic256**、**Basic256Sha256**）；
- **Scan period in milliseconds**（扫描周期毫秒数）- 重新扫描服务器的周期（毫秒）；
- **Poll period**（轮询周期）- 轮询服务器的周期（毫秒）；
- **Subscription check period in milliseconds**（订阅检查周期毫秒数）- 检查 OPC-UA 服务器中 subscription 的周期；
- **Enable subscription**（启用订阅）- 若为 true 则网关订阅相关节点并等待数据更新，若为 false 则每 **scanPeriodInMillis** 重新扫描 OPC-UA 服务器；
- **Show map**（显示映射）- 扫描时是否显示节点：**true** 或 **false**。

{% capture difference %}
所有配置参数列表及详细说明请参见[高级配置](/docs/iot-gateway/config/opc-ua/#advanced-configuration)部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/opc-ua-connector/opc-ua-application-basic-certificates-1-ce.png)
