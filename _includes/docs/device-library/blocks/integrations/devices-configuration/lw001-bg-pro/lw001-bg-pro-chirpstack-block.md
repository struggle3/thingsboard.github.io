### 在 ChirpStack 上添加设备

要添加设备，请按以下步骤操作：

- [下载 JSON 文件](https://github.com/LoRaWAN-Product-Decoder/MOKOSMART-LoRaWAN-Product-Decoder/blob/main/LW001-BG%20PRO%20V2/LW001-BG%20PRO%20V2%20on%20chirpstack.js){:target="_blank"}（包含上行数据转换器配置）。

{% assign AddDeviceOnChirpstack = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/1.png,
        title: 登录 ChirpStack 服务器。进入 **设备配置文件** 页面，点击 **添加设备配置文件** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/2.png,
        title: 填写字段。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/3.png,
        title: 进入 **Codec** 页面，粘贴刚复制的脚本。点击 **提交** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/4.png,
        title: 进入 **应用** 页面，点击「**添加应用**」。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/5.png,
        title: 为应用命名。**点击提交**。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/6.png,
        title: 打开已创建的应用，点击 **添加设备** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/7.png,
        title: 使用设备配置中的值填写参数，选择之前创建设备配置文件并点击 **提交** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/8.png,
        title: 进入 **Variables** 选项卡，将 **应用密钥** 填入对应字段，点击 **提交** 按钮保存设备。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=AddDeviceOnChirpstack %}

### 配置应用与 ThingsBoard 的集成

{% assign configureApplicationIntegrationWithThingsBoard = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/9.png,
        title: 进入「**集成**」页面，找到并选择 **ThingsBoard**。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/10.png,
        title: 输入 **ThingsBoard** 服务器 URL，点击 **提交** 按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=configureApplicationIntegrationWithThingsBoard %}


### 在 ThingsBoard 上创建设备

要在 ThingsBoard 上创建设备，请按以下步骤操作：

{% assign createDeviceOnThingsBoard = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/11.png,
        title: **登录** 您的 **ThingsBoard** 账户。进入 **设备** 页面，点击「**+**」按钮添加新设备。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/12.png,
        title: 输入 **设备名称** 并点击 **下一步：凭证**。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/13.png,
        title: 在 **凭证** 步骤中，指定设备的 **访问令牌**（使用先前复制的 **Device EUI** 值），然后点击 **添加**。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/14.png,
        title: 设备已创建。点击设备打开其 **详情** 页面。进入 **最新遥测数据** 选项卡查看设备上报的数据。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createDeviceOnThingsBoard %}
