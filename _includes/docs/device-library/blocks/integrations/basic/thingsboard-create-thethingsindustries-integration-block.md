### 在 The Things Industries 上添加网关

我们需要在 [The Things Industries 云](https://www.thethingsindustries.com/){:target="_blank"} 上添加网关。

要添加网关，请按以下步骤操作：

{% assign addGatewaySteps = '
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/1-login-page.png,
        title: 登录云端并打开控制台。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/2-cloud-console.png,
        title: 选择「**前往网关**」。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/3-gateway-list.png,
        title: 点击「**注册网关**」按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/4-register-gateway.png,
        title: 填写网关信息（网关 EUI）并点击「注册网关」按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/5-gateway-info.png,
        title: 网关已添加。复制并保存「**网关服务器地址**」，稍后需要用到。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addGatewaySteps %}

{% if page.hasIntegrationDeviceConfiguration | downcase == "true"%}
{% assign articleFilename = page.name |  replace: ".md", "" %}
{% assign guideFilePath = "/docs/device-library/blocks/integrations/devices-configuration/" | append: articleFilename | append: "-thethingsindustries-block.md" %}

{% include {{ guideFilePath }} %}

{% endif %}

### 在 The Things Industries 云上配置应用

现在需要在 The Things Industries 上配置集成。请按以下步骤操作：

{% assign addIntegrationSteps = '
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/the-things-industries-integration-mqtt-1.png,
        title: 打开控制台，点击「<b>创建应用</b>」。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/the-things-industries-integration-mqtt-2.png,
        title: 填写应用所需字段。然后点击「**创建应用**」按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/the-things-industries-integration-mqtt-3.png,
        title: 进入「<b>集成</b>」-> 在左侧菜单中打开「<b>MQTT</b>」页面。然后点击「<b>生成新 API 密钥</b>」按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/the-things-industries-integration-mqtt-4.png,
        title: 复制并保存 <b>密码</b>（API 密钥）（离开页面后将无法再次查看）。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addIntegrationSteps %}

现在可以前往 ThingsBoard 配置集成。

### 在 ThingsBoard 中创建集成

接下来，我们将在 **ThingsBoard** 中创建「**The Things Industries**」集成。

首先，复制以下代码，创建上行数据转换器时需要用到：

{% capture converterCode %}
var data = decodeToJson(payload);

var deviceName = data.end_device_ids.device_id;
var deviceType = data.end_device_ids.application_ids.application_id;

// If you want to parse incoming data somehow, you can add your code to this function.
// input: bytes
// expected output:
//  {
//    "attributes": {"attributeKey": "attributeValue"},
//    "telemetry": {"telemetryKey": "telemetryValue"}
//  }
// default functionality - convert bytes to HEX string with telemetry key "HEX_bytes"

function decodeFrmPayload(input) {
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
var incomingDateString = data.uplink_message.received_at;
var dateString = incomingDateString.substring(0, incomingDateString.lastIndexOf(".")+3) + "Z";
var timestamp = new Date(dateString).getTime();
// --- Timestamp parsing

// You can add some keys manually to attributes or telemetry
attributes.f_port = data.uplink_message.f_port;
attributes.settings = data.uplink_message.settings;
// We want to save correlation ids as single object, so we are excluding them from attributes parse and add manually
attributes.correlation_ids = data.correlation_ids;

// You can exclude some keys from the result
var excludeFromAttributesList = ["device_id", "application_id", "uplink_message", "correlation_ids"];
var excludeFromTelemetryList = ["uplink_token", "gateway_id", "settings"];

// Message parsing
// To avoid paths in the decoded objects we passing false value to function as "pathInKey" argument.
// Warning: pathInKey can cause already found fields to be overwritten with the last value found, e.g. receive_at from uplink_message will be written receive_at in the root.
var telemetryData = toFlatMap(data.uplink_message, excludeFromTelemetryList, false);
var attributesData = toFlatMap(data, excludeFromAttributesList, false);

// Passing incoming bytes to decodeFrmPayload function, to get custom decoding
var customDecoding = {};
if (data.uplink_message.get("frm_payload") != null) {
    customDecoding = decodeFrmPayload(base64ToBytes(data.uplink_message.frm_payload));
}

// Collecting data to result
if (customDecoding.?telemetry.size() > 0) {
    telemetry.putAll(customDecoding.telemetry);
}

if (customDecoding.?attributes.size() > 0) {
    attributes.putAll(customDecoding.attributes);
}

telemetry.putAll(telemetryData);
attributes.putAll(attributesData);

var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    telemetry: {
        ts: timestamp,
        values: telemetry
    },
    attributes: attributes
};

return result;
{% endcapture %}

{% include code-toggle.liquid code=converterCode params="javascript|.copy-code.expandable-15" %}

{% assign createTTIIntegration = '
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/1-create-tti-integration.png,
        title: 点击右上角的「**加号**」图标添加新集成。选择类型「**The Things Industries 集成**」。然后点击「**下一步**」。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/2-create-tti-integration-uplink.png,
        title: 将先前复制的脚本粘贴到解码器函数区域。点击「**下一步**」。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/3-create-tti-integration-downlink.png,
        title: 将「**下行数据转换器**」字段留空。点击「**跳过**」按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/4-create-tti-integration-configuration.png,
        title: 填写您的参数，然后点击「**添加**」按钮。
'
%}

在「**连接**」步骤中，您需要以下参数：

- **Region（区域）**：*eu1*（在 The Things Industries 控制台中注册应用所在区域）；
- **Username（用户名）**：*thingsboard-data-integration@thingsboard*（使用 The Things Industries 集成中的 ***用户名***）；
- **Password（密码）**：使用 The Things Industries 集成中的 ***密码***。

<br>
现在，打开「**集成中心**」部分 ->「**集成**」页面，按以下步骤操作：

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createTTIIntegration %}

集成已创建。

<br>
可按以下方式检查集成连接状态：

- 点击集成列表中的某一行；
- 进入「**事件**」选项卡；
- 在 **事件类型** 下拉列表中选择「**生命周期事件**」。

若看到 **STARTED** 事件且状态为 **Success**，则表示集成已成功启动，可以接收消息。

![检查集成连接](/images/devices-library/basic/integrations/check-integration-started.png)
