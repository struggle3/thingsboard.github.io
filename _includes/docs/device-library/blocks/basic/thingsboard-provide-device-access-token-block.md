连接设备前，需先获取其凭证。  
{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}**ThingsBoard Edge**{% else %}**ThingsBoard**{% endif %} 支持多种设备凭证类型，本指南使用默认自动生成的访问令牌（access token）。  

{% assign provisionDeviceCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-1-ce.png,
        title: 点击设备列表中的行以打开设备详情。
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-2-ce.png,
        title: 点击「**复制访问令牌**」。令牌将复制到剪贴板，请妥善保存。
    '
%}

{% assign provisionDevicePE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-1-pe.png,
        title: 点击设备列表中的行以打开设备详情。
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-2-pe.png,
        title: 点击「**复制访问令牌**」。令牌将复制到剪贴板，请妥善保存。
    '
%}

{% assign provisionDeviceEdgeCE = '
    ===
        image: /images/edge/config/general/connect-device-1-ce.webp,
        title: 点击设备以打开设备详情。
    ===
        image: /images/edge/config/general/connect-device-2-ce.webp,
        title: 点击 **「复制访问令牌」**。令牌将复制到剪贴板，请妥善保存。
'
%}

{% assign provisionDeviceEdgePE = '
    ===
        image: /images/edge/config/general/connect-device-1-pe.webp,
        title: 点击设备以打开设备详情。
    ===
        image: /images/edge/config/general/connect-device-2-pe.webp,
        title: 点击 **「复制访问令牌」** 按钮。令牌将复制到剪贴板，请妥善保存。
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