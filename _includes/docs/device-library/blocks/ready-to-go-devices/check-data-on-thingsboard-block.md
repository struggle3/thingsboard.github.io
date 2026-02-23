完成上述步骤且 {{deviceName}} 已发送数据后，可在设备遥测选项卡中查看：

{% assign deviceTelemetryCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-1-ce.png,
        title: 点击表格中的设备行以打开设备详情；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-3-ce.png,
        title: 导航至遥测选项卡。
    '
%}

{% assign deviceTelemetryPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-1-pe.png,
        title: 点击表格中的设备行以打开设备详情；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-3-pe.png,
        title: 导航至遥测选项卡。
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryCE %}
{% endif %}

可将 {{deviceName}} 的属性和遥测显示在仪表板上。您可以使用自定义部件创建自己的仪表板，或导入现成仪表板。
