{% assign vendorLowerCase = page.vendor | downcase %}
{% assign deviceNameInPath = page.deviceImageFileName | split: "." | first %}
{% assign converterFilePath = "/docs/device-library/blocks/integrations/external-platforms/" | append: vendorLowerCase | append: "/thethingsindustries/" | append: deviceNameInPath | append: "-uplink-converter.md" %}

### 在 The Things Industries 上添加网关

我们需要在 [The Things Industries 云](https://www.thethingsindustries.com/){:target="_blank"} 上添加网关。

要添加网关，请按以下步骤操作：

{% assign ttnsAddGateway = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-1.png,
        title: 登录云端并打开控制台。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-add-gateway-1.png,
        title: 进入 **主页**，点击「**注册网关**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-add-gateway-2.png,
        title: 填写网关信息（网关 EUI）并点击「**注册网关**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-add-gateway-3.png,
        title: 网关已添加。您可看到其状态为已断开连接。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=ttnsAddGateway %}

### 在 The Things Industries 上添加设备

我们需要在 [The Things Industries 云](https://www.thethingsindustries.com/){:target="_blank"} 上添加设备。

要添加设备，请按以下步骤操作：

{% assign ttns = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-2.png,
        title: 进入 **应用** 页面。然后选择您的应用并点击其名称。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-3.png,
        title: 点击 **注册终端设备** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-4.png,
        title: 将 **APP EUI** 值填入 **JoinEUI** 字段。然后点击 **确认** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-5.png,
        title: 填写其余参数并点击 **注册终端设备** 按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=ttns %}

### 配置 Payload Formatter

进入 **Payload formatters** 页面，将 **Formatter type** 选择为 **Custom JavaScript formatter**。将解码函数粘贴到编辑器中，点击 **Save changes** 按钮。

{% assign ttn1 = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/ttn-6.png,
        title: 进入 **Payload formatters** 页面，将 **Formatter type** 选择为 **Custom JavaScript formatter**。将解码函数粘贴到编辑器中，点击 **Save changes** 按钮。
'
%}

{% include images-gallery.liquid imageCollection=ttn1 %}

{% include {{ converterFilePath }} %}

### 在 ThingsBoard 中创建集成

接下来，我们将在 **ThingsBoard** 中创建「**The Things Industries**」集成。

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

在「**连接**」步骤中，您需要以下参数：

- **Region（区域）**：*eu1*（在 The Things Industries 控制台中注册应用所在区域）；
- **Username（用户名）**：*thingsboard-application-2025-05@lansitec-testplan*（使用 The Things Stack Industries 集成中的 **用户名**）；
- **Password（密码）**：使用 The Things Industries 集成中的 **密码**。

现在，进入「**集成中心**」部分下的「**集成**」页面，按以下步骤操作：

{% assign tbIntergration = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-intergrations-1.png,
        title: 点击右上角的「**加号**」图标添加新集成。选择类型「**The Things Industries 集成**」。然后点击「**下一步**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-intergrations-2.png,
        title: 将先前复制的脚本粘贴到解码器函数区域。点击「**下一步**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-intergrations-3.png,
        title: 将「**下行数据转换器**」字段留空。点击「**跳过**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-intergrations-4.png,
        title: 填写您的参数，然后点击「**添加**」按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=tbIntergration %}
