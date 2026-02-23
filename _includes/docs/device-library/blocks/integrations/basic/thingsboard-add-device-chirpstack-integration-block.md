### 在 ChirpStack 上添加设备

我们需要在 [ChirpStack](https://chirpstack.io){: target="_blank"} 上添加设备。

要添加设备，请按以下步骤操作：

{% assign addDeviceSteps = '
    ===
        image: /images/devices-library/basic/integrations/chirpstack/main-page.png,
        title: 登录 ChirpStack 服务器。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/add-device-profile.png,
        title: 进入**设备配置文件**页面，点击**添加设备配置文件**按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-device-profile.png,
        title: 填写字段并点击**提交**按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-device-step-0.png,
        title: 进入**应用**页面，点击您的应用后按**添加设备**按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-device-step-1.png,
        title: 使用设备配置中的值填写参数。然后选择之前创建设备配置文件并点击**提交**按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-device-step-2.png,
        title: 将**应用密钥**填入相应字段并点击**提交**按钮保存设备。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addDeviceSteps %}

{% include /docs/device-library/blocks/integrations/converters/basic/add-or-change-converter-block.md integration-type="chirpstack" integration-type-correct-name="ChirpStack" %}

