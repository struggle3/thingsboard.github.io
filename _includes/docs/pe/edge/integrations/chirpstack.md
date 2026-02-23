* TOC
{:toc}

{% assign integrationName = "ChirpStack" %}
{% assign integrationUrl = "chirpstack" %}
{% include templates/edge/integrations/edge-pe-reference.md %}

### 概述

[ChirpStack](https://www.chirpstack.io/){: target="_blank"} 是一款 **开源 LoRaWAN Network Server**，可用于搭建 LoRaWAN 网络。
将 ChirpStack 与 **ThingsBoard Edge** 集成后，可在边缘本地连接、处理并可视化设备数据，实现低延迟洞察与离线能力。

详情请参阅集成示意图。

![image](/images/pe/edge/integrations/chirpstack/chirpstack-diagram.webp){: style="display: block; margin: auto; max-height: 400px"}

### 前置条件

* **ThingsBoard Edge Professional Edition** 已运行。
* 通过 [Docker Compose](https://www.chirpstack.io/project/guides/docker-compose/){: target="_blank"} 或 [Ubuntu](https://www.chirpstack.io/project/guides/debian-ubuntu/){: target="_blank"} 安装 **ChirpStack Network Server**。
* 设备已连接至网络。连接 **LoRaWAN 设备** 与 [ChirpStack](https://www.chirpstack.io/project/guides/connect-device/){: target="_blank"} 的方法请参阅相关文档。

### 创建 converter 与 integration 模板

仅 **ThingsBoard Professional Edition** 可创建 converter 和 integration 模板。
因此请使用 [**ThingsBoard Cloud**](https://thingsboard.cloud/signup){: target="_blank"} 或 [**安装**](/docs/user-guide/install/pe/installation-options/){: target="_blank"} 自有平台实例，以 **Tenant administrator** 身份登录。

#### 基本设置

添加 **ChirpStack 集成**：
- 进入 **Edge management > Integration templates** 部分，点击 **"Add"** 按钮添加新集成。
- 选择 **ChirpStack** 类型并输入 **integration name**。
- 点击 **"Next"** 按钮。

{% include images-gallery.html imageCollection="basic-settings" %}

{% capture debug-mode %}
**Debug mode** 对开发和排查非常有用。但长期开启会显著增加数据库占用的磁盘空间，因为所有调试数据都会保存其中。
<p>因此，自 <b>version 3.9</b> 起，<b>ThingsBoard</b> 仅在集成的前 <b>15 分钟</b> 内保存所有 debug 事件。之后仅保留失败事件。这些设置可组合或完全禁用。</p>
{% endcapture %}
{% include templates/info-banner.md content=debug-mode %}

#### Uplink 数据 converter

**Uplink** 用于将设备传入数据转换为在 **ThingsBoard** 中显示所需的格式。

* 选择 **"Create new"** 选项卡
* 输入 **Converter name**
* **Main decoding configuration** 区块：
  * 从下拉菜单选择 **Entity type**（_Device 或 Asset_）并输入 **entity name**。集成执行后将创建对应实体。

{% capture placeholder %}
<b>$eui</b> 占位符会自动替换为设备的 <b>唯一标识符</b>（_例如 70B3D57ED003B6F5_），来源为 <b>Loriot</b>（或 ChirpStack、类似 MQTT 消息）的 payload。
<br>例如，若设备实体命名为 <b>"Loriot Device $eui"</b>，创建的设备名可能为 <b>"Loriot Device 70B3D57ED003B6F5"<b>。
{% endcapture %}
{% include templates/info-banner.md content=placeholder %}

* 在 **"function payloadDecoder"** 字段中输入脚本。**Edge 3.9 及更早版本** 可使用以下脚本：
{% capture chirpstackuplinkconverterconfig %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/chirpstack/chirpstack-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/chirpstack/chirpstack-uplink-converter-config-javascript.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="chirpstackuplinkconverterconfig" toggle-spec=chirpstackuplinkconverterconfig %}

{% include images-gallery.html imageCollection="uplink-data-converter-script" %}

自 **Edge 4.0** 起，可以：
* 选择 **"Library"** 选项卡，在 **"Vendor"** 和 **"Model"** 下拉菜单中选择厂商并找到对应型号。
* 或使用 converter 中提供的默认脚本。

{% include images-gallery.html imageCollection="uplink-data-converter-library" %}

* **Advanced decoding parameters** 区块：
  - **"Device profile"**、**"Device label"**、**"Customer name"** 和 **"Device group name"** 字段非必填，也可使用 **$-pattern** 动态填充。
  - 在 **Attributes** 和 **Telemetry** 部分指定应解释为属性或遥测的 keys。
  - 在 **Update only keys list** 部分，定义仅在值相对上一条消息发生变化时才保存到数据库的 keys。适用于 Attributes 和 Telemetry，有助于优化数据存储。
- 点击 **"Next"** 按钮。

{% include images-gallery.html imageCollection="uplink-data-converter-advanced-parameters" %}

#### Downlink 数据 converter（可选）

配置 **Downlink data converter** 为可选，若不需要可省略。
要跳过 downlink converter 配置，选择 **"Skip"** 选项卡并点击 **"Skip"** 按钮。

{% include images-gallery.html imageCollection="downlink-data-converter" %}

#### 连接 {#connection}

在配置 **Connection** 之前，请在 **ChirpStack UI** 中创建 **Application server API Token**。
* 在 **http://chipstack-server-ip:8080**（_例如 http://10.7.2.193:8080/_）打开 **ChirpStack UI** 并使用凭据登录。
  * 若未修改凭据，可使用：
    <br>Username: **admin**
    <br>Password: **admin**
* 进入 **Tennant > API Keys** 部分，点击 **"Add API Key"** 按钮。
* 输入 **API key name** 并点击 **"Submit"** 按钮。
* 创建 **API key name** 后，复制并粘贴到 **ThingsBoard UI** 的 **"Application server API Token"** 字段。

{% include images-gallery.html imageCollection="chirpstack-api-key" %}

在 **ThingsBoard UI** 中继续 **Connection** 配置。填写以下字段：
* **Base URL：** 按格式输入：**http://edge-ip:edge-port**（_例如 http://10.7.2.193:8080_）。
* **HTTP endpoint URL：** 复制以备配置 [ChirpStack application](#integration-on-chirpstack) 时使用。
* **Application server URL：** 输入 application server 或 REST API 服务的地址，格式：**http://chipstack-server-ip:8090**（_例如 http://10.7.2.193:8090_）。
* **Application server API Token：** 粘贴从 **ChirpStack UI** 获取的 **API Token**。
* 点击 **"Add"** 按钮。

{% include images-gallery.html imageCollection="connection" %}

### 在 ChirpStack 应用中配置集成 {#integration-on-chirpstack}

要将设备数据从 **ChirpStack** 转发到 **ThingsBoard**，还需配置 **ChirpStack Application Integration**。
在 **http://chipstack-server-ip:8080** 登录 **ChirpStack UI** 继续。

#### 添加 device profile

在配置 **ChirpStack Application** 之前先创建 device profile。填写必填项：
* 进入 **Tenant > Device Profiles** 部分，点击 **"Add device profile"** 按钮。
* 在 **"General"** 选项卡中填写以下字段：
  * **Name：** 输入 device profile 名称。
  * **Region：** 输入 LoRaWAN 区域参数。
  * **MAC Version：** 设备使用的 LoRaWAN MAC 版本。
  * **Regional parameters revision：** 您所在区域的参数集版本。
  * **ADR Algorithm：** 自适应数据速率逻辑。
  * **Expect uplink interval (secs)：** 输入 ChirpStack 预期设备发送 uplink 消息的秒数。
* 点击 **"Submit"** 按钮。

{% include images-gallery.html imageCollection="chirpstack-device-profile" %}

#### 添加 integration

在 **ChirpStack** 应用中配置 integration：
* 进入 **Tenant > Applications** 部分，点击 **"Add application"** 按钮。
* 输入 **application name** 并点击 **"Submit"** 按钮。
* 选择 **"Integrations"** 选项卡。
* 在列表中找到 **HTTP integration**，点击 **"+"** 按钮将其添加到 application。
* 将 **ThingsBoard UI** [Connection](#connection) 配置步骤中获取的 **HTTP endpoint URL** 粘贴到对应字段。
* 点击 **"Submit"** 按钮。

{% include images-gallery.html imageCollection="chirpstack-applications" %}

#### 添加设备

添加 integration 后添加设备：
* 选择 **"Devices"** 选项卡，点击 **"Add device"** 按钮。
* 在 **"Device"** 选项卡中输入设备 **name**。
* **Device EUI (EUI64)：** 输入分配给 LoRaWAN 设备的唯一 64 位（8 字节）标识符。
  * 选择 DevEUI 表示或传输的字节序（_MSB 或 LSB_）。
* **Device profile：** 从下拉菜单选择 device profile。
* 点击 **"Submit"** 按钮。

{% include images-gallery.html imageCollection="chirpstack-device" %}

#### 添加 gateway（可选）

在测试环境中可省略添加 gateway。
但设备本身会通过 gateway 发送数据。添加 gateway：
* 进入 **Tenant > Gateways** 部分，点击 **"Add gateways"** 按钮。
* 输入 **gateway name**、**gateway ID** 以及 gateway 预期发送统计信息的秒数。

{% include images-gallery.html imageCollection="chirpstack-gateway" %}

### 将 integration 分配到 Edge 

创建 **integration 模板** 并完成 **ChirpStack Application Integration** 配置后，将 **integration 模板** 分配到 **Edge** 实例：
* 进入 **Edge management > Instances** 部分，点击 **"Manage edge integrations"** 按钮。
* 在 **"Integration"** 页面点击 **"Assign to edge"** 按钮。在 **"Assign the Integration to the Edge"** 弹窗中，从下拉菜单选择 integration 并点击 **"Assign"** 按钮。
* 要确认 **ChirpStack** 集成在 **Edge** 上，请登录 **ThingsBoard Edge** 实例并进入 **Integrations center > Integrations** 部分。

{% include images-gallery.html imageCollection="assign-to-edge" %}

### 发送 uplink 消息

要模拟 uplink，可使用 [ChirpStack Device Simulator](https://github.com/brocaar/chirpstack-simulator){: target="_blank"} 或手动向 **ChirpStack Application Server** 发送 **HTTP 消息**。

**HTTP 消息** 示例：

```bash
curl -v -X POST -d '{
    "deduplicationId": "7658d04d-7f1c-4eb6-900b-d948f3061a9d",
    "time": "2025-06-13T12:44:52.653+00:00",
    "deviceInfo": {
        "tenantId": "6e073e9a-6b4f-4747-b22c-7507568debfb",
        "tenantName": "ChirpStack",
        "applicationId": "c3f2c4aa-07c8-4d6c-8a86-7ea2d4a31dca",
        "applicationName": "Sample Application",
        "deviceProfileId": "d8ee6c09-414c-4b2e-888a-8e8f86e3187a",
        "deviceProfileName": "Default device profile",
        "deviceName": "chirp device",
        "devEui": "24e124538b223213",
        "deviceClassEnabled": "CLASS_A",
        "tags": {}
    },
    "devAddr": "01a44c4c",
    "adr": true,
    "dr": 5,
    "fCnt": 153,
    "fPort": 84,
    "confirmed": false,
    "data": "AXU9AwABBAAB",
    "rxInfo": [{
        "gatewayId": "e4e124dadef64eee",
        "uplinkId": 25127,
        "gwTime": "2025-06-13T12:44:52.653481+00:00",
        "nsTime": "2025-06-13T12:44:52.670509207+00:00",
        "timeSinceGpsEpoch": "1433853910.653s",
        "rssi": -68,
        "snr": 13.2,
        "channel": 4,
        "location": {},
        "context": "Hw9+zQ==",
        "crcStatus": "CRC_OK"
    }],
    "txInfo": {
        "frequency": 867300000,
        "modulation": {
            "lora": {
                "bandwidth": 125000,
                "spreadingFactor": 7,
                "codeRate": "CR_4_5"
            }
        }
    },
    "regionConfigId": "eu868"
}'  $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json"
```
{: .copy-code.expandable-7}
其中：
* **deduplicationId：** 测试用途可生成任意有效 UUID v4。仅用于模拟真实性和调试依赖它的集成。
* **tenantId：** 替换为您的 ChirpStack 租户 ID。
* **applicationId：** 替换为 ChirpStack Application ID。
* **applicationName：** 替换为 ChirpStack Application 名称。
* **deviceProfileId：** 替换为 ChirpStack device profile ID。
* **deviceProfileName：** 替换为 ChirpStack device profile 名称。
* **devEui：** 替换为在 ChirpStack 设备中添加的 Device EUI。
* **gatewayId：** 替换为 ChirpStack gateway ID。
* **$YOUR_HTTP_ENDPOINT_URL：** 替换为 ThingsBoard 集成中获取的实际值。

在生产环境中，设备会**自动**定期发送 uplink 消息或在事件触发时发送，无需人工干预。

发送消息后，**ThingsBoard Edge** 用户界面将创建新设备。
* 查看接收的时序数据：进入 **Entities > Devices** 部分，点击 **device** 并选择 **"Latest telemetry"** 选项卡。

{% include images-gallery.html imageCollection="device" %}

查看接收的 uplink 消息：
* 进入 **Integrations center > Integrations** 部分，点击 **ChirpStack integration** 并选择 **"Events"** 选项卡。

{% include images-gallery.html imageCollection="uplink-integration" %}

接收的数据可在 **Uplink converter** 中查看：
- 进入 **Integrations center > Data converters** 部分，点击 **Uplink converter**。
- 在 **"Data converter details"** 页面选择 **"Events"** 选项卡。
- 在 **"In"** 和 **"Out"** 列查看消息详情。

{% include images-gallery.html imageCollection="uplink-converter" %}

### 下一步

{% include templates/edge/guides-banner-edge.md %}
