### 在 ChirpStack 上添加网关

我们需要在 [ChirpStack](https://chirpstack.io){: target="_blank"} 上添加网关。

要添加网关，请按以下步骤操作：

{% assign addGatewaySteps = '
    ===
        image: /images/devices-library/basic/integrations/chirpstack/gateways.png,
        title: 登录 ChirpStack 服务器。进入「**网关**」页面，点击「**添加网关**」按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/add-gateway.png,
        title: 填写 **名称**、**网关 EUI**（根据您的网关而定，可在网关控制面板上查看），向下滚动并点击「**提交**」按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/gateway-added-offline.png,
        title: 网关已添加。在网关列表中可查看其状态。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addGatewaySteps %}

{% if page.hasIntegrationDeviceConfiguration | downcase == "true"%}
{% assign articleFilename = page.name |  replace: ".md", "" %}
{% assign guideFilePath = "/docs/device-library/blocks/integrations/devices-configuration/" | append: articleFilename | append: "-chirpstack-block.md" %}

{% include {{ guideFilePath }} %}

{% endif %}

### 在 ChirpStack 上配置应用

现在需要在 ChirpStack 上配置应用。请按以下步骤操作：

{% assign addIntegrationSteps = '
    ===
        image: /images/devices-library/basic/integrations/chirpstack/applications.png,
        title: 在左侧菜单中进入「**应用**」页面，点击「**添加应用**」按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-application.png,
        title: 填写应用名称并点击「**提交**」按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/api-keys.png,
        title: 在左侧菜单中进入 **API 密钥** 页面，点击「**添加 API 密钥**」按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-api-key.png,
        title: 为 API 密钥设置名称并点击「**提交**」按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/api-key-created.png,
        title: 复制创建的 API 密钥并保存，稍后在 ThingsBoard 上配置集成时需要用到。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addIntegrationSteps %}

现在可以前往 ThingsBoard 配置集成。

### 在 ThingsBoard 中创建集成

接下来，我们将在 ThingsBoard 中创建与 ChirpStack 的集成，并在 ChirpStack 上配置集成。

首先，复制以下代码，创建上行数据转换器时需要用到：

{% capture converterCode %}
var data = decodeToJson(payload);
var deviceName = data.deviceInfo.deviceName;
var deviceType = data.deviceInfo.deviceProfileName;

// If you want to parse incoming data somehow, you can add your code to this function.
// input: bytes
// expected output:
//  {
//    "attributes": {"attributeKey": "attributeValue"},
//    "telemetry": {"telemetryKey": "telemetryValue"}
//  }
// default functionality - convert bytes to HEX string with telemetry key "HEX_bytes"

function decodePayload(input) {
    var output = { attributes:{}, telemetry: {} };
    // --- Decoding code --- //

    output.telemetry.HEX_bytes = bytesToHex(input);
    
    // --- Decoding code --- //
    return output;
}

// --- attributes and telemetry objects ---
var telemetry = {};
var attributes = {};
// --- attributes and telemetry objects ---

// --- Timestamp parsing
var dateString = data.time.substring(0, data.time.lastIndexOf('+')-3) + "Z";
var timestamp = new Date(dateString).getTime();
// --- Timestamp parsing

// You can add some keys manually to attributes or telemetry
attributes.fPort = data.port;
attributes.encodedData = data.data;

// You can exclude some keys from the result
var excludeFromAttributesList = ["deviceName", "rxInfo", "txInfo", "deduplicationId", "time", "dr", "fCnt", "fPort"];
var excludeFromTelemetryList = ["data", "deviceInfo", "devAddr", "adr"];

// Message parsing
// To avoid paths in the decoded objects we passing false value to function as "pathInKey" argument.
// Warning: pathInKey can cause already found fields to be overwritten with the last value found.

var telemetryData = toFlatMap(data, excludeFromTelemetryList, false);
var attributesData = toFlatMap(data, excludeFromAttributesList, false);

var uplinkDataList = [];

// Passing incoming bytes to decodePayload function, to get custom decoding
var customDecoding = decodePayload(hexToBytes(data.data));

// Collecting data to result
if (customDecoding.?telemetry.size() > 0) {
    telemetry.putAll(customDecoding.telemetry);
}

if (customDecoding.?attributes.size() > 0) {
    attributes.putAll(customDecoding.attributes);
}

telemetry.putAll(telemetryData);
attributes.putAll(attributesData);

var deviceInfo = {
    deviceName: deviceName,
    deviceType: deviceType,
    telemetry: {
        ts: timestamp,
        values: telemetry
    },
    attributes: attributes
};

uplinkDataList.add(deviceInfo);

if (data.cmd == "gw") {
    foreach( gatewayInfo : data.gws ) {
        var gatewayInfoMsg = {
            deviceName: gatewayInfo.gweui,
            deviceType: "LoraGateway",
            attributes: {},
            telemetry: {
                "ts": gatewayInfo.ts,
                "values": toFlatMap(gatewayInfo, ["ts", "time", "gweui"], false)
            }
        };
        uplinkDataList.add(gatewayInfoMsg);
    }
}

return uplinkDataList;
{% endcapture %}

{% include code-toggle.liquid code=converterCode params="javascript|.copy-code.expandable-15" %}

{% assign createChirpstackIntegration = '
    ===
        image: /images/devices-library/basic/integrations/chirpstack/1-create-integration.png,
        title: 进入「**集成中心**」部分的「**集成**」页面，点击「**加号**」按钮添加新集成。选择类型「**Chirpstack**」。然后点击「**下一步**」。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/2-create-integration-uplink.png,
        title: 将先前复制的脚本粘贴到解码器函数区域。点击「**下一步**」。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/3-create-integration-downlink.png,
        title: 将「**下行数据转换器**」字段留空。点击「**跳过**」按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/4-create-integration-configuration.png,
        title: 填入 ChirpStack 的「**应用服务器 URL**」和「**API 密钥**」，并复制「**HTTP 端点 URL**」。点击「**添加**」按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/application-integrations.png,
        title: 现在打开 ChirpStack，进入「**应用**」页面 -> 您的应用 ->「**集成**」选项卡，找到并点击 **HTTP** 磁贴。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-application-integration.png,
        title: 将「**HTTP URL 端点**」填入「**Event Endpoint URL(s)**」字段，点击「**提交**」按钮。
'
%}

请按以下步骤添加集成：

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createChirpstackIntegration %} 

集成已创建。

<br>
可按以下方式检查集成连接状态：

- 点击集成列表中的某一行；
- 进入「**事件**」选项卡；
- 在 **事件类型** 下拉列表中选择「**生命周期事件**」。

若看到 **STARTED** 事件且状态为 **Success**，则表示集成已成功启动，可以接收消息。

![检查集成连接](/images/devices-library/basic/integrations/check-integration-started.png)
