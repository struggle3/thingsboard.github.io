### Check data on ThingsBoard

设备已添加，若其发送了数据，将显示在 **设备** 中。  
可在 **实体** 部分打开 **设备** 页面查看。
设备将出现在设备列表中，点击设备并打开 **属性** 或 **最新遥测** 选项卡即可查看数据。

{% assign checkTelemetryOnDevice = '
    ===
        image: /images/devices-library/ready-to-go-devices/am308/check-telemetry-on-device.png,
        title: Open "Devices" page in "Entities" section. The device should be in devices list. You can check the data by clicking the device and navigate to the "Attributes" or "Latest telemetry" tab.
'
%}

{% include images-gallery.liquid imageCollection=checkTelemetryOnDevice %}

<br>
为获得更直观的视图，可使用[仪表板](/docs/pe/user-guide/dashboards){: target="_blank"}。  
You can download a simple dashboard for this device, it is configured to display a data from "pir", "light level", "beep", "battery level", "Temperature", "Humidity", "CO2", "Pressure", "TVOC", "PM2.5", "PM10" and "Signal strength" telemetry keys for device with name "eui-24e124538b223213".

{% include /docs/device-library/blocks/basic/thingsboard-upload-example-dashboard.md exampleDashboardPath="/docs/devices-library/resources/dashboards/ready-to-go-devices/am308-device-dashboard.json" %}

{% include /docs/device-library/blocks/basic/thingsboard-change-entity-alias-block.md exampleDashboardPath="/docs/devices-library/resources/dashboards/ready-to-go-devices/am308-device-dashboard.json" %}

带数据的仪表板示例：

{% assign dashboard = '
    ===
        image: /images/devices-library/ready-to-go-devices/am308/am308-example-of-the-dashboard-pe.png,
        title: Example of the dashboard with data.
'
%}

{% include images-gallery.liquid imageCollection=dashboard %}