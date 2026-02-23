### 在 ThingsBoard 上查看数据

设备已添加，若其发送了数据，将显示在 **设备** 中。  
可在 **实体** 部分打开 **设备** 页面查看。 
设备将出现在设备列表中，点击设备并进入 **属性** 或 **最新遥测** 选项卡即可查看数据。

{% assign checkTelemetryOnDevice = '
    ===
        image: /images/devices-library/ready-to-go-devices/vs121-device/check-telemetry-on-device.png,
        title: 在「实体」部分打开「设备」页面。设备将出现在设备列表中，点击设备并进入「属性」或「最新遥测」选项卡即可查看数据。
'
%}

{% include images-gallery.liquid imageCollection=checkTelemetryOnDevice %}

<br>
为获得更直观的视图，可使用[仪表板](/docs/pe/user-guide/dashboards){: target="_blank"}。
可下载适用于本设备的简易仪表板。该仪表板配置为显示设备名称为 "eui-24e124538b223213" 的设备的 "Count people all"、"Max count people"、"Signal strength"、"Region count" 和 "Occupancy" 时序数据。

{% include /docs/device-library/blocks/basic/thingsboard-upload-example-dashboard.md exampleDashboardPath="/docs/devices-library/resources/dashboards/ready-to-go-devices/vs-121-sensor-dashboard.json" %}  

打开导入的仪表板，点击即可。然后需在仪表板的实体别名中指定您的设备。

按以下步骤操作：

{% assign editAlias = '
    ===
        image: /images/user-guide/dashboards/alias/edit-alias-for-vs-121-sensor-1-pe.png,
        title: 打开仪表板并进入编辑模式。点击「实体别名」图标，在弹出窗口中点击别名旁的「编辑别名」图标。
    ===
        image: /images/user-guide/dashboards/alias/edit-alias-for-vs-121-sensor-2-pe.png,
        title: 在编辑别名窗口的下拉列表中选择您的设备并保存实体别名。
    ===
        image: /images/user-guide/dashboards/alias/edit-alias-for-vs-121-sensor-3-pe.png,
        title: 应用所有更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=editAlias %}

现在应能看到设备的数据。

带数据的仪表板示例：

{% assign dashboard = '
    ===
        image: /images/devices-library/ready-to-go-devices/vs121-device/vs121-example-of-the-dashboard-pe.png,
        title: 带数据的仪表板示例。
'
%}

{% include images-gallery.liquid imageCollection=dashboard %}