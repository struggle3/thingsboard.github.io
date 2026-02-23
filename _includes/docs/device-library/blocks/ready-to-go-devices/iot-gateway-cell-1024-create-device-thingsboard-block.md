在浏览器中打开您的平台实例或 ThingsBoard [云端]({{thingsboardInstanceLink}}){:target="_blank"}，以租户管理员身份登录。

{% assign deviceCreation = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-create-device-cell-1.png,
        title: 进入「<b>设备组</b>」选项卡 ->「<b>全部</b>」，点击「加号」按钮添加新设备。输入设备名称，选择现有或创建新设备配置文件，点击「<b>添加</b>」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-create-device-cell-2.png,
        title: 设备已创建。打开设备详情，点击「复制访问令牌」按钮复制自动生成的 <b>访问令牌</b>。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceCreation %}
