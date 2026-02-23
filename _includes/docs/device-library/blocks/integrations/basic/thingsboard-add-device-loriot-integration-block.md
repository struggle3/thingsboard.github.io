### 在 Loriot 上添加设备

我们需要在 [Loriot](https://loriot.io){: target="_blank"} 上添加设备。

要添加设备，请按以下步骤操作：

{% assign addDeviceSteps = '
    ===
        image: /images/devices-library/basic/integrations/loriot/main-page.png,
        title: 登录 Loriot 服务器。我们使用 **eu2.loriot.io**，具体取决于注册时选择的区域。
    ===
        image: /images/devices-library/basic/integrations/loriot/create-device-step-0.png,
        title: 在左侧菜单中进入「**应用**」页面。
    ===
        image: /images/devices-library/basic/integrations/loriot/create-device-step-1.png,
        title: 打开您的应用，我们的示例为「**SampleApp**」。
    ===
        image: /images/devices-library/basic/integrations/loriot/create-device-step-2.png,
        title: 进入「**注册设备**」页面。使用设备配置中的值填写字段，然后点击「**注册**」按钮。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addDeviceSteps %}


{% include /docs/device-library/blocks/integrations/converters/basic/add-or-change-converter-block.md integration-type="loriot" integration-type-correct-name="Loriot" %}
