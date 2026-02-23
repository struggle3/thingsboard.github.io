### Check data on ThingsBoard

设备已添加，若其发送了数据，将显示在 **设备** 中。  
可在 **实体** 部分打开 **设备** 页面查看。
设备将出现在设备列表中，点击设备并打开 **属性** 或 **最新遥测** 选项卡即可查看数据。

![Check telemetry on device](/images/devices-library/ready-to-go-devices/ws101-smart-button/check-telemetry-on-device.png)

<br>
为获得更直观的视图，可使用[仪表板](/docs/pe/user-guide/dashboards){: target="_blank"}。  
可下载适用于本设备的简易仪表板，该仪表板配置为显示设备名称为 "*eui-24e124538b223213*" 的设备的 "press" 和 "battery" 遥测数据。  

{% include /docs/device-library/blocks/basic/thingsboard-upload-example-dashboard.md exampleDashboardPath="/docs/devices-library/resources/dashboards/ready-to-go-devices/ws_101_smart_button.json" %}

{% include /docs/device-library/blocks/basic/thingsboard-change-entity-alias-block.md exampleDashboardPath="/docs/devices-library/resources/dashboards/ready-to-go-devices/ws_101_smart_button.json" %}

带数据的仪表板示例：  

![Dashboard](/images/devices-library/ready-to-go-devices/ws101-smart-button/example-of-the-dashboard-pe.png)