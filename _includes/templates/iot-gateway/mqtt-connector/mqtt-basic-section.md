本配置部分包含 MQTT Broker 连接相关设置，例如：
- **Host（主机）** - MQTT Broker 的主机名或 IP 地址；
- **Port（端口）** - MQTT Broker 上用于建立连接的监听端口；
- **MQTT version（MQTT 版本）** - MQTT 协议版本（网关当前支持 **3.1**、**3.11**、**5** 三个版本）；
- **Client ID（客户端 ID）** - 每个客户端在 Broker 上会话的唯一标识符；
- **Security（安全）** - 在 MQTT Broker 端配置客户端认证（匿名、基本认证或证书）。

{% capture difference %}
**请注意：**
Broker（或 Broker 集群）不允许使用相同 **Client ID** 的两个会话同时存在。若第二个连接使用了该 ID，
Broker 会关闭已有会话并接受新连接（会话接管）。**Client ID** 可为任意有效 UTF-8 字符串；
若暂无描述性 ID，可在 MQTT connector 配置界面中生成——见本小节下方的最后几张截图。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture difference %}
所有配置参数列表及其详细说明参见
[高级配置](/docs/iot-gateway/config/mqtt/#advanced-configuration) 章节。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/mqtt-connector/connection-to-broker-basic-section-1-ce.png)

若希望由界面生成 **Client ID**，请将 **Client ID** 字段留空并点击 *Generate Client ID*（见下方截图）。
网关会创建唯一的标识符。

![image](/images/gateway/mqtt-connector/generate-clientID-from-UI.png)

生成 **Client ID** 后的界面表单，例如 *tb_gw_rfpev*——仅为示例，您的实际值会不同。

![image](/images/gateway/mqtt-connector/generated-clientID-from-UI.png)
