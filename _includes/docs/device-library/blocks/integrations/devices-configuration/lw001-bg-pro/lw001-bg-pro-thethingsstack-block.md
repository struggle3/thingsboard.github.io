### 在 The Things Stack 上添加设备

要添加设备，请按以下步骤操作：

{% assign addDeviceOnThingsStack = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/15.png,
        title: 登录云端并打开控制台。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/16.png,
        title: 进入 **应用** 页面。然后选择您的 **应用** 并点击其名称。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/17.png,
        title: 点击 **+ 注册终端设备** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/18.png,
        title: 选择「**手动输入终端设备规格**」。然后，将 **APP EUI** 值填入 **JoinEUI** 字段。点击 **确认** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/19.png,
        title: 填写其余参数并点击 **注册终端设备** 按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addDeviceOnThingsStack %}

### 配置 Payload Formatter

- [下载 JSON 文件](https://github.com/LoRaWAN-Product-Decoder/MOKOSMART-LoRaWAN-Product-Decoder/blob/main/LW001-BG%20PRO%20V2/LW001-BG%20PRO%20V2%20on%20TTN.js){:target="_blank"}（包含上行数据转换器配置）。

{% assign ConfigurePayloadFormatter = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/20.png,
        title: 进入 **Payload formatters** 页面，为 Formatter type 选择 **Custom Javascript formatter**。粘贴解码函数并点击 **Save changes** 按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=ConfigurePayloadFormatter %}

### 在 ThingsBoard 中创建集成

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
- Region（区域）：*eu1*（在 The Things Stack 社区中注册应用所在区域）
- Username（用户名）：*thingsboard-application-2025-06@ttn*（使用 TTS 集成中的用户名）  
- Password（密码）：使用 The Things Stack 社区集成中的 **密码**

现在，进入 **ThingsBoard 实例** 的 **集成中心** 部分下的 **集成** 页面，按以下步骤操作：

{% assign createIntegrationInThingsBoard = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/21.png,
        title: 点击右上角的「**加号**」图标添加新集成。选择「**The Things Stack 社区**」集成类型。然后点击「**下一步**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/22.png,
        title: 将先前复制的脚本粘贴到 **解码器函数** 区域。点击「**下一步**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/23.png,
        title: 将「下行数据转换器」字段留空。点击「**跳过**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/24.png,
        title: 填写您的参数，然后点击「**添加**」按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createIntegrationInThingsBoard %}

### 在 ThingsBoard 上检查数据

设备已添加后，若其发送了数据，应会显示在[设备](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}中。要检查数据，您可以在**实体**部分打开**设备**页面。设备应出现在设备列表中。您可以通过点击设备，然后打开**属性**或**最新遥测数据**选项卡来查看数据。

{% assign checkDataOnThingsBoard = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/25.png,
        title: 设备已添加后，若其发送了数据，应会显示在设备中。要检查数据，您可以在 **实体** 部分打开 **设备** 页面。设备应出现在设备列表中。您可以通过点击设备，然后打开 **属性** 或 **最新遥测数据** 选项卡来查看数据。
'
%}

{% include images-gallery.liquid imageCollection=checkDataOnThingsBoard %}
