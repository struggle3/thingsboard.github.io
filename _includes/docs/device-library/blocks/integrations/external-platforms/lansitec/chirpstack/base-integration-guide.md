{% assign vendorLowerCase = page.vendor | downcase %}
{% assign deviceNameInPath = page.deviceImageFileName | split: "." | first %}
{% assign converterFilePath = "/docs/device-library/blocks/integrations/external-platforms/" | append: vendorLowerCase | append: "/chirpstack/" | append: deviceNameInPath | append: "-uplink-converter.md" %}

### 在 ChirpStack 上添加网关

我们需要在 [ChirpStack](https://chirpstack.io/){:target="_blank"} 上添加网关。

要添加网关，请按以下步骤操作：

{% assign gateway = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/gateway-1.png,
        title: 登录 ChirpStack 服务器。进入「**网关**」页面，点击「**添加网关**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/gateway-2.png,
        title: 填写 **名称**、**网关 ID**（根据您的网关而定，可在网关控制面板上查看），向下滚动并点击「**提交**」按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/gateway-3.png,
        title: 网关已添加。在网关选项卡中可查看其状态。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=gateway %}

### 在 ChirpStack 上添加设备配置文件

{% assign deviceProfiles = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/device-profiles-1.png,
        title: 登录 ChirpStack 服务器。进入「**设备配置文件**」页面，点击 **添加设备配置文件** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/device-profiles-2.png,
        title: 填写必填字段。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/device-profiles-3.png,
        title: 进入 **Codec** 选项卡，在 **Payload codec** 下拉菜单中选择 **JavaScript functions**，粘贴解码器函数。然后点击 **提交** 按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceProfiles %}

{% include {{ converterFilePath }} %}

### 在 ChirpStack 上添加设备

{% assign application = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/application-1.png,
        title: 进入 **应用** 页面，点击 **添加应用** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/application-2.png,
        title: 输入名称并点击 **提交** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/application-3.png,
        title: 点击 **添加设备**。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/application-4.png,
        title: 使用设备信息填写必填字段，并指定之前创建设备配置文件。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/application-5.png,
        title: 进入 **Variables** 选项卡，输入 **ThingsBoardAccessToken** 的值，点击 **提交** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/application-6.png,
        title: 将 **应用密钥** 填入对应字段，点击 **提交** 按钮保存设备。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=application %}

### 配置应用与 ThingsBoard 的集成

{% assign thingsboard = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/thingsboard-1.png,
        title: 进入 **集成** 页面，找到并选择 **ThingsBoard**。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/thingsboard-2.png,
        title: 输入 **ThingsBoard 服务器 URL**，点击 **提交** 按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=thingsboard %}

### 在 ThingsBoard 上创建设备

{% assign devices = '
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/devices-1.png,
        title: 进入 **设备** 页面。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/devices-2.png,
        title: 点击 **添加设备** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/devices-3.png,
        title: 填写设备名称并点击 **下一步：凭证** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/devices-4.png,
        title: 输入设备 **访问令牌**（先前复制的 **Device EUI** 值）并点击 **添加** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/devices-5.png,
        title: 点击设备打开设备信息窗口。
    ===
        image: /images/devices-library/ready-to-go-devices/lansitec-lorawan/devices-6.png,
        title: 进入 **最新遥测数据** 选项卡查看设备上报的数据。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=devices %}
