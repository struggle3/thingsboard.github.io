### 配置网关以发送数据

要将网关连接并发送数据到 The Things Industries 云，需要配置网关。
请按以下步骤操作：

{% assign connectGatewayToNS = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-add-new-forwarder.png,
        title: 打开网关控制面板。进入「**Packet Forwarder**」页面，点击「**加号**」按钮添加新转发器。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-the-things-industries-window.png,
        title: 在「**服务器地址**」中填入网络服务器的地址。点击「**保存**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-the-things-industries-after.png,
        title: 点击「**保存并应用**」按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=connectGatewayToNS %}

至此，网关已能够向网络服务器发送数据。
