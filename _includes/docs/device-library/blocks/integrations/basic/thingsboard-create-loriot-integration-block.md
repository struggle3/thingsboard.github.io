### 在 Loriot 上添加网关

我们需要在 [Loriot](https://loriot.io){: target="_blank"} 上添加网关。

要添加网关，请按以下步骤操作：

{% assign addGatewaySteps = '
    ===
        image: /images/devices-library/basic/integrations/loriot/main-page-network.png,
        title: 登录 Loriot 服务器。在「**网络**」部分打开「**示例网络**」或创建新网络。
    ===
        image: /images/devices-library/basic/integrations/loriot/sample-network.png,
        title: 点击「**添加网关**」按钮。
    ===
        image: /images/devices-library/basic/integrations/loriot/register-gateway.png,
        title: 向下滚动并选择「**Packet Forwarder Semtech**」。
    ===
        image: /images/devices-library/basic/integrations/loriot/add-gateway.png,
        title: 向上滚动，将网关的 **MAC 地址**（从***网关 EUI***中去除中间的 **FFFF** 或 **FFFE** 后得到）填入 **eth0 MAC address** 字段，将网关 EUI 填入 **Custom EUI** 字段。
    ===
        image: /images/devices-library/basic/integrations/loriot/gateway-added-disconnected.png,
        title: 网关已添加。您可看到其状态为已断开连接。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addGatewaySteps %}

{% if page.hasIntegrationDeviceConfiguration | downcase == "true"%}
{% assign articleFilename = page.name |  replace: ".md", "" %}
{% assign guideFilePath = "/docs/device-library/blocks/integrations/devices-configuration/" | append: articleFilename | append: "-loriot-block.md" %}

{% include {{ guideFilePath }} %}

{% endif %}

### 在 Loriot 上配置应用

现在需要在 Loriot 中复制「**应用 ID**」。在 ThingsBoard 中配置集成时需要用到。

请按以下步骤操作：

{% assign copyLoriotApplicationId = '
    ===
        image: /images/devices-library/basic/integrations/loriot/main-page-application.png,
        title: 在左侧菜单中进入「**应用**」，选择「**SampleApp**」或创建新应用。
    ===
        image: /images/devices-library/basic/integrations/loriot/sample-application.png,
        title: 复制「**应用 ID**」值并保存。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=copyLoriotApplicationId %}

现在可以前往 ThingsBoard 配置集成。

### 在 ThingsBoard 中创建集成

接下来，我们将在 ThingsBoard 中创建与 Loriot 的集成。

首先，复制以下代码，创建上行数据转换器时需要用到：

{% capture converterCode %}
var data = decodeToJson(payload);
var deviceName = data.EUI;
var deviceType = "LoraDevices";

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
var timestamp = data.ts;
// --- Timestamp parsing

// You can add some keys manually to attributes or telemetry
attributes.fPort = data.port;
attributes.battery = data.bat;

// You can exclude some keys from the result
var excludeFromAttributesList = ["data", "gws", "EUI", "ts", "cmd", "port", "seqno", "fcnt", "toa", "ack", "bat", "snr", "rssi"];
var excludeFromTelemetryList = ["gws", "EUI", "ts", "freq", "port", "data", "cmd", "dr", "offline"];

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

{% assign createLoriotIntegration = '
    ===
        image: /images/devices-library/basic/integrations/loriot/1-create-integration-name-type.png,
        title: 点击「**加号**」按钮添加新集成。选择类型「**Loriot**」。然后点击「**下一步**」。
    ===
        image: /images/devices-library/basic/integrations/loriot/2-create-integration-uplink.png,
        title: 将先前复制的脚本粘贴到解码器函数区域。点击「**下一步**」。
    ===
        image: /images/devices-library/basic/integrations/loriot/3-create-integration-downlink.png,
        title: 将「**下行数据转换器**」字段留空。点击「**跳过**」按钮。
    ===
        image: /images/devices-library/basic/integrations/loriot/4-create-integration-configuration.png,
        title: 填写您的参数，然后点击「**添加**」按钮。
'
%}

<br>
现在，打开「**集成中心**」部分 ->「**集成**」页面，按以下步骤操作：

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createLoriotIntegration %}

集成已创建。

<br>
可按以下方式检查集成连接状态：

- 点击集成列表中的某一行；
- 进入「**事件**」选项卡；
- 在 **事件类型** 下拉列表中选择「**生命周期事件**」。

若看到 **STARTED** 事件且状态为 **Success**，则表示集成已成功启动，可以接收消息。

![检查集成连接](/images/devices-library/basic/integrations/check-integration-started.png)

### 故障排除

若看到以下错误信息，表示输出未自动创建。

![检查集成连接](/images/devices-library/basic/integrations/loriot/loriot-integration-error-pe.png)

您可以手动配置：

{% assign loriotTroubleshooting = '
    ===
        image: /images/devices-library/basic/integrations/loriot/loriot-troubleshootin-1-pe.png,
        title: 进入 ThingsBoard Loriot 集成的编辑模式，关闭 **「创建 Loriot 应用输出」** 开关并复制 **「HTTP 端点 URL」**。然后应用更改；
    ===
        image: /images/devices-library/basic/integrations/loriot/loriot-troubleshootin-2-pe.png,
        title: 打开 **eu2.loriot.io**，在左侧面板中进入 **「输出」** 页面，点击 **「添加新输出」** 按钮；
    ===
        image: /images/devices-library/basic/integrations/loriot/loriot-troubleshootin-3-pe.png,
        title: 选择 **「HTTP Push」**。将 **「HTTP 端点 URL」** 粘贴到 **「Target URL for POSTs」** 字段。点击 **「添加输出」** 按钮；
    ===
        image: /images/devices-library/basic/integrations/loriot/loriot-troubleshootin-4-pe.png,
        title: 删除默认输出；
    ===
        image: /images/devices-library/basic/integrations/loriot/loriot-troubleshootin-5-pe.png,
        title: 前往云端检查连接状态。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=loriotTroubleshooting %}
