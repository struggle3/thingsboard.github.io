### 在 Loriot 上添加设备

要添加设备，请按以下步骤操作：

{% assign addDeviceOnLoriot = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/36.png,
        title: 登录 **Loriot** 服务器。我们使用 **eu2.loriot.io**，具体取决于注册时选择的区域。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/37.png,
        title: 在左侧菜单中进入 **应用** 页面。
===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/38.png,
        title: 打开您的 **应用**。
===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/39.png,
        title: 进入「**注册设备**」页面。使用设备配置中的值填写字段。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/40.png,
        title: 然后点击「**创建设备**」按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addDeviceOnLoriot %}

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

现在，进入 **ThingsBoard 实例** 的 **集成中心** 部分下的 **集成** 页面，按以下步骤操作：

{% assign createIntegrationInThingsBoard = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/41.png,
        title: 点击右上角的「**加号**」图标添加新集成。选择「**Loriot**」集成类型。然后点击「**下一步**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/42.png,
        title: 将先前复制的脚本粘贴到 **解码器函数** 区域。点击「**下一步**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/43.png,
        title: 将「下行数据转换器」字段留空。点击「**跳过**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/44.png,
        title: 填写您的参数，然后点击「**添加**」按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createIntegrationInThingsBoard %}

### 在 ThingsBoard 上检查数据

设备已添加后，若其发送了数据，应会显示在[设备](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}中。要检查数据，您可以在**实体**部分打开**设备**页面。设备应出现在设备列表中。您可以通过点击设备，然后打开**属性**或**最新遥测数据**选项卡来查看数据。

{% assign checkDataOnThingsBoard = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/45.png,
        title: 设备已添加后，若其发送了数据，应会显示在设备中。要检查数据，您可以在 **实体** 部分打开 **设备** 页面。设备应出现在设备列表中。您可以通过点击设备，然后打开 **属性** 或 **最新遥测数据** 选项卡来查看数据。
'
%}

{% include images-gallery.liquid imageCollection=checkDataOnThingsBoard %}
