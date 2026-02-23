### 在 The Things Stack 社区版上添加设备

我们需要在 [The Things Stack 社区版](https://console.cloud.thethings.network){:target="_blank"} 上添加设备。

要添加设备，请按以下步骤操作：

{% assign addGatewaySteps = '
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/1-tts-login.png,
        title: 登录云端并打开控制台。
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/create-device-step-0.png,
        title: 进入 **应用** 页面。然后选择您的应用并点击应用名称。
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/create-device-step-1.png,
        title: 点击 **注册终端设备** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/create-device-step-3.png,
        title: 将 **APP EUI** 值填入 **JoinEUI** 字段。点击 **确认** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/create-device-step-4.png,
        title: 填写其余参数并点击 **注册终端设备** 按钮。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addGatewaySteps %}


{% include /docs/device-library/blocks/integrations/converters/basic/add-or-change-converter-block.md integration-type="thethingsstack" integration-type-correct-name="The Things Stack" %}
