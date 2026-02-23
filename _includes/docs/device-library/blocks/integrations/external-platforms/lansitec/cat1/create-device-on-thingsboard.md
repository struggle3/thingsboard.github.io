## 在 ThingsBoard 上创建设备

{% assign tbDevice = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-device-1.png,
        title: 进入 **设备** 页面，点击 **添加设备** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-device-2.png,
        title: 填写设备信息并点击 **下一步：凭证** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-device-3.png,
        title: 在 ThingsBoard 上添加设备时，将设备的 IMEI 号（例如 862990061908629）作为访问令牌填写。该设备通过 MQTT 协议直接连接 ThingsBoard 平台，并以 JSON 格式推送数据。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-device-4.png,
        title: 填写设备 **访问令牌** 并点击 **添加** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-device-5.png,
        title: 点击设备查看详细信息。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/tb-device-6.png,
        title: 点击 **最新遥测数据** 查看设备上报的数据。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=tbDevice %}
