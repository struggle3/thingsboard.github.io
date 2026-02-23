### 在 The Things Industries 上添加设备

我们需要在 [The Things Industries 云](https://www.thethingsindustries.com/){:target="_blank"} 上添加设备。

要添加设备，请按以下步骤操作：

{% assign addDeviceSteps = '
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/1-login-page.png,
        title: 登录云端并打开控制台。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/the-things-industries-create-device-1.png,
        title: 进入 **应用** 页面。然后选择您的应用并点击应用名称。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/the-things-industries-create-device-2.png,
        title: 点击 **注册终端设备** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/the-things-industries-create-device-3.png,
        title: 将 **APP EUI** 值填入 **JoinEUI** 字段。点击 **确认** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/the-things-industries-create-device-4.png,
        title: 填写其余参数并点击 **注册终端设备** 按钮。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addDeviceSteps %}


{% include /docs/device-library/blocks/integrations/converters/basic/add-or-change-converter-block.md integration-type="thethingsindustries" integration-type-correct-name="The Things Industries" %}
