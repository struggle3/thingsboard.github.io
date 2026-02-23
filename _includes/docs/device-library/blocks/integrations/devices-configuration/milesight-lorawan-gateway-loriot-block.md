### 配置网关以发送数据

要将网关连接并发送数据到 Loriot，需要配置网关。
请按以下步骤操作：

{% assign connectGatewayToNS = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-add-new-forwarder.png,
        title: 打开网关控制面板。进入「**Packet Forwarder**」页面，点击「**加号**」按钮添加新转发器。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-loriot-configuration-window.png,
        title: 在 **服务器地址** 中填入您的服务器地址，我们的示例为 **eu2.loriot.io**。将端口设置为 **1780**。点击「**保存**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-loriot-configuration-after.png,
        title: 点击「**保存并应用**」按钮。
    ===
        image: /images/devices-library/basic/integrations/loriot/gateway-added-connected.png,
        title: 现在可以在 Loriot 上检查网关状态，应显示为已连接。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=connectGatewayToNS %}

至此，网关已能够向网络服务器发送数据。
