{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

远程集成支持将局域网（LAN）内多台设备的数据可靠地流式传输到云端 ThingsBoard 平台。 
适用于例如本地 MQTT broker 或 OPC-UA 服务器无公网 IP、无法从 ThingsBoard 所在位置访问的场景。 
远程集成会连接这些服务器、拉取数据、在本地存储并流式传输到 ThingsBoard 实例。

尽管部署流程会多出一些步骤，但可实现与局域网内服务器和设备的集成。独立集成进程也能提升隔离程度和性能。

远程集成支持租户启动 [TCP](/docs/user-guide/integrations/tcp/) 和 [UDP](/docs/user-guide/integrations/udp/) 集成。这两种集成需启动绑定特定端口的服务。 
ThingsBoard 为多租户环境，TCP 和 UDP 集成无法作为 core 服务的一部分运行，否则可能发生租户间端口冲突。 
因此建议各租户以远程方式运行 TCP/UDP 集成。租户创建的自定义集成亦然。

![image](/images/user-guide/integrations/remote/remote-integrations-overview.png)

可将任意 ThingsBoard 集成与 ThingsBoard 实例分开运行。

本指南提供分步说明，介绍如何启动连接本地 MQTT Broker 的 MQTT 远程集成，并将数据推送到 [ThingsBoard Cloud](https://{{hostName}}/signup)。

更多 ThingsBoard 平台集成功能说明见[此处](/docs/{{peDocsPrefix}}user-guide/integrations/)。

## ThingsBoard 配置

假设您已在自有 [ThingsBoard PE 实例](/docs/user-guide/install/pe/installation-options/)或 [ThingsBoard Cloud](https://{{hostName}}/signup) 拥有租户管理员账户。

### 在 ThingsBoard 中创建远程集成

在 ThingsBoard 中创建远程集成，使其通过端口 1883 连接本地 broker 并订阅所有 topic。

- 进入「**Integrations center**」->「**Integrations**」页面，点击「plus」添加新集成。命名为「**MQTT remote integration**」，选择类型「**MQTT**」；

![image](/images/user-guide/integrations/remote/remote-integration-1-paas.png)

- 下一步添加默认上行转换器。新转换器将包含转换入站数据所需的代码。点击「**Next**」；

![image](/images/user-guide/integrations/remote/remote-integration-2-paas.png)

- 在添加下行转换器步骤可新建下行转换器。此处保持「Downlink data converter」为空。点击「**Skip**」；

![image](/images/user-guide/integrations/remote/remote-integration-3-paas.png)

- 在连接步骤指定 **host**：「**{{hostName}}**」，**port**：「**1883**」；
- 订阅所有 **topics**；
- 也可选择 MQTT **QoS** 级别。默认使用 MQTT QoS 0（At most once）；
- 复制并保存「**Integration key**」和「**Integration secret**」，后续会用到；

![image](/images/user-guide/integrations/remote/remote-integration-4-paas.png)

- 进入 **advanced settings**。建议取消勾选「**Clean session**」。多数 broker 不支持粘性会话，启用该选项可能导致静默断开；
- 点击「**Add**」创建集成。

![image](/images/user-guide/integrations/remote/remote-integration-5-paas.png)

<br>
接下来执行远程集成安装步骤。

## 选择平台并安装

可通过 Docker、Debian 或 RPM 包安装 ThingsBoard 集成。
请按下列步骤之一操作。

 * [Linux 或 Mac OS 上的 Docker](#docker-on-linuxmac)
 * [Windows 上的 Docker](#docker-on-windows)
 * [Ubuntu](#ubuntu-server)
 * [CentOS/RHEL Server](#centosrhel-server)

### Docker on Linux/Mac

- **[安装 Docker CE](https://docs.docker.com/engine/installation/)**

- **选择要安装的集成**

{% capture contenttogglespec %}
HTTP Integrations<br><small>(HTTP, Sigfox, ThingPark, OceanConnect and <br> T-Mobile IoT CDP)</small>%,%http%,%templates/install/integration/http-docker.md%br%
MQTT Integrations<br><small>(MQTT, AWS IoT, IBM Watson, The Things Stack Community)</small>%,%mqtt%,%templates/install/integration/mqtt-docker.md%br%
AWS SQS<br> Integration<br>%,%aws%,%templates/install/integration/aws-docker.md%br%
Azure Event Hub<br>Integration<br>%,%azure%,%templates/install/integration/azure-docker.md%br%
OPC UA<br> Integration<br>%,%opcua%,%templates/install/integration/opcua-docker.md%br%
TCP/UDP<br> Integration<br>%,%tcpudp%,%templates/install/integration/tcpudp-docker.md%br%
CoAP<br> Integration<br>%,%coap%,%templates/install/integration/coap-docker.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="remoteintegrationdockerinstall" toggle-spec=contenttogglespec %}

{% include templates/install/integration/advanced-config-docker.md %} 

- **故障排查**

{% include templates/troubleshooting/dns-issues.md %}

### Docker on Windows

- **[安装 Windows 版 Docker Toolbox](https://docker-docs.uclv.cu/toolbox/toolbox_install_windows/)**

- **选择要安装的集成**

{% capture contenttogglespecwin %}
HTTP Integrations<br><small>(HTTP, Sigfox, ThingPark, OceanConnect and <br> T-Mobile IoT CDP)</small>%,%http%,%templates/install/integration/http-docker-windows.md%br%
MQTT Integrations<br><small>(MQTT, AWS IoT, IBM Watson, The Things Network)</small>%,%mqtt%,%templates/install/integration/mqtt-docker-windows.md%br%
AWS SQS<br> Integration<br>%,%aws%,%templates/install/integration/aws-docker-windows.md%br%
Azure Event Hub<br>Integration<br>%,%azure%,%templates/install/integration/azure-docker-windows.md%br%
OPC UA<br> Integration<br>%,%opcua%,%templates/install/integration/opcua-docker-windows.md%br%
TCP/UDP<br> Integration<br>%,%tcpudp%,%templates/install/integration/tcpudp-docker-windows.md%br%
CoAP<br> Integration<br>%,%coap%,%templates/install/integration/coap-docker-windows.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="remoteintegrationdockerinstallwin" toggle-spec=contenttogglespecwin %}

{% include templates/install/integration/advanced-config-docker.md %} 

 - **故障排查**

{% include templates/troubleshooting/dns-issues-windows.md %}

### Ubuntu Server

 - 安装Java 17 (OpenJDK)

{% include templates/install/ubuntu-java-install.md %}

 - **Choose Integration package to install**
 
{% capture ubuntuinstallspec %}
HTTP Integrations<br><small>(HTTP, Sigfox, ThingPark, OceanConnect and <br> T-Mobile IoT CDP)</small>%,%http%,%templates/install/integration/http-ubuntu.md%br%
MQTT Integrations<br><small>(MQTT, AWS IoT, IBM Watson, The Things Network)</small>%,%mqtt%,%templates/install/integration/mqtt-ubuntu.md%br%
AWS SQS<br> Integration<br>%,%aws%,%templates/install/integration/aws-ubuntu.md%br%
Azure Event Hub<br>Integration<br>%,%azure%,%templates/install/integration/azure-ubuntu.md%br%
OPC UA<br> Integration<br>%,%opcua%,%templates/install/integration/opcua-ubuntu.md%br%
TCP/UDP<br> Integration<br>%,%tcpudp%,%templates/install/integration/tcpudp-ubuntu.md%br%
CoAP<br> Integration<br>%,%coap%,%templates/install/integration/coap-ubuntu.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="remoteintegrationinstallubuntu" toggle-spec=ubuntuinstallspec %} 

### CentOS/RHEL Server

 - Install Java 17 (OpenJDK) 

{% include templates/install/rhel-java-install.md %}

 - **Choose Integration package to install**
 
{% capture rhelinstallspec %}
HTTP Integrations<br><small>(HTTP, Sigfox, ThingPark, OceanConnect and <br> T-Mobile IoT CDP)</small>%,%http%,%templates/install/integration/http-rhel.md%br%
MQTT Integrations<br><small>(MQTT, AWS IoT, IBM Watson, The Things Network)</small>%,%mqtt%,%templates/install/integration/mqtt-rhel.md%br%
AWS SQS<br> Integration<br>%,%aws%,%templates/install/integration/aws-rhel.md%br%
Azure Event Hub<br>Integration<br>%,%azure%,%templates/install/integration/azure-rhel.md%br%
OPC UA<br> Integration<br>%,%opcua%,%templates/install/integration/opcua-rhel.md%br%
TCP/UDP<br> Integration<br>%,%tcpudp%,%templates/install/integration/tcpudp-rhel.md%br%
CoAP<br> Integration<br>%,%coap%,%templates/install/integration/coap-rhel.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="remoteintegrationinstallrhel" toggle-spec=rhelinstallspec %} 

## 远程集成配置

远程集成通过 ThingsBoard UI 配置，无特殊步骤。
查看与具体集成相关的指南和视频教程：

 - [HTTP](/docs/{{peDocsPrefix}}user-guide/integrations/http/)
 - [MQTT](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/)
 - [CoAP](/docs/{{peDocsPrefix}}user-guide/integrations/coap/)
 - [Kafka](/docs/{{peDocsPrefix}}user-guide/integrations/kafka/)
 - [OPC-UA](/docs/{{peDocsPrefix}}user-guide/integrations/opc-ua/)
 - [Actility ThingPark](/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/)
 - [TheThingsStack](/docs/{{peDocsPrefix}}user-guide/integrations/ttn/)
 - [TheThingsIndustries](/docs/{{peDocsPrefix}}user-guide/integrations/tti/)
 - [KPN Things](/docs/{{peDocsPrefix}}user-guide/integrations/kpn-things/)
 - [LORIOT](/docs/{{peDocsPrefix}}user-guide/integrations/loriot/)
 - [ChirpStack](/docs/{{peDocsPrefix}}user-guide/integrations/chirpstack/)
 - [AWS IoT](/docs/{{peDocsPrefix}}user-guide/integrations/aws-iot/)
 - [AWS Kinesis](/docs/{{peDocsPrefix}}user-guide/integrations/aws-kinesis/)
 - [IBM Watson IoT](/docs/{{peDocsPrefix}}user-guide/integrations/ibm-watson-iot/)
 - [Azure Event Hub](/docs/{{peDocsPrefix}}user-guide/integrations/azure-event-hub/)
 - [Azure Service Bus](/docs/{{peDocsPrefix}}user-guide/integrations/azure-service-bus/)
 - [Azure IoT Hub](/docs/{{peDocsPrefix}}user-guide/integrations/azure-iot-hub/)
 - [SigFox](/docs/{{peDocsPrefix}}user-guide/integrations/sigfox/)
 - [OceanConnect](/docs/{{peDocsPrefix}}user-guide/integrations/ocean-connect/)
 - [TCP](/docs/{{peDocsPrefix}}user-guide/integrations/tcp/)
 - [UDP](/docs/{{peDocsPrefix}}user-guide/integrations/udp/)
 - [Tuya](/docs/{{peDocsPrefix}}user-guide/integrations/tuya/)
 - [Custom](/docs/{{peDocsPrefix}}user-guide/integrations/custom/)
  
## 远程集成故障排查

请查看日志文件。其位置取决于您使用的平台和安装包，在安装步骤中有说明。 

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
