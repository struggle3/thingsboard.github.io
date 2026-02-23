为简化流程，我们将在界面中手动创建设备。



{% assign provisionDeviceCE = '

    ===

        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-1-ce.png,

        title: 登录 ThingsBoard 实例并进入 **实体 > 设备** 页面。

    ===

        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-2-ce.png,

        title: 点击右上角 **"+"** 按钮并选择 **添加新设备**。

    ===

        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-3-ce.png,

        title: 输入**设备名称**，例如 "My Device"。其他字段可保持默认，点击 **添加** 创建设备。

    ===

        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-4-ce.png,

        title: 设备已添加完成。

    '

%}



{% assign provisionDevicePE = '

    ===

        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-1-pe.png,

        title: 登录 ThingsBoard 实例并进入 **实体 > 设备** 页面。

    ===

        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-2-pe.png,

        title: 默认将进入设备组「全部」。点击右上角 **"+"** 按钮并选择 **添加新设备**。

    ===

        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-3-pe.png,

        title: 输入**设备名称**，例如 "My Device"。其他字段可保持默认，点击 **添加** 创建设备。

    ===

        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-4-pe.png,

        title: 首个设备已添加完成。

    '

%}



{% assign provisionDeviceEdgeCE = '

    ===

        image: /images/edge/config/general/1-provision-device-ce.webp,

        title: 登录 ThingsBoard Edge 实例并进入 **实体 > 设备** 页面。点击右上角 **"+"** 按钮并选择 **添加新设备**。

    ===

        image: /images/edge/config/general/2-provision-device-ce.webp,

        title: 输入**设备名称**，例如 "My Device"。其他字段可保持默认，点击 **添加** 创建设备。

    ===

        image: /images/edge/config/general/3-provision-device-ce.webp,

        title: 首个设备已添加完成。

'

%}



{% assign provisionDeviceEdgePE = '

    ===

        image: /images/edge/config/general/1-provision-device-pe.webp,

        title: 登录 ThingsBoard Edge 实例并进入 **实体 > 设备** 页面。点击右上角 **"+"** 按钮并选择 **添加新设备**。

    ===

        image: /images/edge/config/general/2-provision-device-pe.webp,

        title: 输入**设备名称**，例如 "My Device"。其他字段可保持默认，点击 **添加** 创建设备。

    ===

        image: /images/edge/config/general/3-provision-device-pe.webp,

        title: 首个设备已添加完成。

'

%}



{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}

    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDevicePE %}

{% elsif page.docsPrefix == "pe/edge/" %}

    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDeviceEdgePE %}

{% elsif page.docsPrefix == "edge/" %}

    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDeviceEdgeCE %}

{% else %}

    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDeviceCE %}

{% endif %} 