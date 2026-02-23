
此时 MI-8 应已配置完成并可与 ThingsBoard 通信。  
可按以下步骤检查传入数据：  

- 打开 ThingsBoard，进入 Device Groups，然后进入 <b>All</b>。  
- 点击刚与 MI-8 关联的设备，进入 <b>Latest Telemetry</b> 选项卡。  

![](/images/devices-library/ready-to-go-devices/mixed-input-8-channel-analog-cellular-logger/open-device-timeseries.png)

- 还可查看设备接收的属性。  
    进入 **属性** 选项卡即可。  
    属性是 MI-8 发送至 ThingsBoard 的附加数据，通常相对固定，例如调制解调器 IMEI、SIM 卡 ID（ICCID）及 MI-8 固件版本。 

![](/images/devices-library/ready-to-go-devices/mixed-input-8-channel-analog-cellular-logger/check-attributes.png)

MI-8 上电并建立蜂窝连接后，处于活动状态的 MI-8 触发器中所配置的所有传感器值应会显示。  
注意：GPS 值仅在首次定位后才开始传输，可能需要数分钟，具体取决于距上次定位的时间及 MI-8 的移动距离。  
GPS 值（lat、lon 和 alt）至少传输一次后才会出现在遥测窗口中。  
  

