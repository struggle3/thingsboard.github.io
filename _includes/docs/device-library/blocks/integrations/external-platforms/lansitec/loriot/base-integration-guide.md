{% assign vendorLowerCase = page.vendor | downcase %}
{% assign deviceNameInPath = page.deviceImageFileName | split: "." | first %}
{% assign converterFilePath = "/docs/device-library/blocks/integrations/external-platforms/" | append: vendorLowerCase | append: "/loriot/" | append: deviceNameInPath | append: "-uplink-converter.md" %}

### 在 Loriot 上添加网关

我们需要在 [Loriot](https://loriot.io/){:target="_blank"} 上添加网关。

要添加网关，请按以下步骤操作：

{% assign loriotAddGateway = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-add-gateway-1.png,
        title: 登录 Loriot 服务器。在「**网络**」部分打开「**示例网络**」或创建新网络。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-add-gateway-2.png,
        title: 点击「**添加网关**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-add-gateway-3.png,
        title: 向下滚动并选择「**MultiTech Conduit AEP**」。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-add-gateway-4.png,
        title: 向上滚动，将网关的 **MAC 地址**（从 **网关 EUI** 中去掉中间的 **FFFF** 或 **FFFE** 后得到）填入 **eth0 MAC address** 字段，将网关 EUI 填入 **Custom EUI** 字段。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-add-gateway-5.png,
        title: 网关已添加。您可看到其状态为已断开连接。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=loriotAddGateway %}

### 在 Loriot 上添加设备

我们需要在 [Loriot](https://loriot.io/){:target="_blank"} 上添加设备。

要添加设备，请按以下步骤操作：

{% assign loriotAddGateway = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-1.png,
        title: 登录 Loriot 服务器。我们使用 **eu2.loriot.io**，具体取决于注册时选择的区域。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-2.png,
        title: 在左侧菜单中进入「**应用**」页面。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-3.png,
        title: 打开您的应用，我们的示例为「**SampleApp**」。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-4.png,
        title: 进入「**注册设备**」页面。使用设备配置中的值填写字段，然后点击「**注册**」按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=loriotAddGateway %}

### 在 ThingsBoard 中创建集成

接下来，我们将在 ThingsBoard 中创建与 Loriot 的集成。

首先，复制以下代码，创建上行数据转换器时需要用到：

```javascript
var data = decodeToJson(payload);
var deviceName = data.end_device_ids.device_id;
var deviceType = data.end_device_ids.application_ids.application_id;

var result = {
  deviceName: deviceName,
  deviceType: deviceType,
  telemetry: data.uplink_message.decoded_payload
};

return result;
```
{:.copy-code}

现在，进入「**集成中心**」部分下的「**集成**」页面，按以下步骤操作：

{% assign ttnsAddGateway = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-intergration-1.png,
        title: 点击右上角的「**加号**」图标按钮添加新集成。选择类型「**Loriot**」。然后点击「**下一步**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-intergration-2.png,
        title: 将先前复制的脚本粘贴到解码器函数区域。点击「**下一步**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-intergration-3.png,
        title: 将「**下行数据转换器**」字段留空。点击「**跳过**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/loriot-intergration-4.png,
        title: 填写您的参数，然后点击「**添加**」按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=ttnsAddGateway %}
