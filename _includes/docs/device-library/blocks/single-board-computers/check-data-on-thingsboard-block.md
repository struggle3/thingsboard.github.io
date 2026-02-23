成功发布属性和遥测后，数据将立即出现在 **「最新遥测」** 选项卡中：

{% assign deviceTelemetryCE = '
    ===
        image: /images/helloworld/getting-started-ce/check-telemetry-ce.webp,
        title: 点击设备以打开 **设备详情** 页面，并选择 **「最新遥测」** 选项卡。
    '
%}

{% assign deviceTelemetryPE = '
    ===
        image: /images/helloworld/getting-started-pe/check-telemetry-pe.webp,
        title: 点击设备以打开 **设备详情** 页面，并选择 **「最新遥测」** 选项卡。
    '
%}

{% assign deviceTelemetryEdgeCE = '
    ===
        image: /images/edge/config/general/connect-device-3-ce.webp,
        title: 点击设备以打开 **设备详情** 页面，并选择 **「最新遥测」** 选项卡。
'
%}

{% assign deviceTelemetryEdgePE = '
    ===
        image: /images/edge/config/general/connect-device-3-pe.webp,
        title: 点击设备以打开 **设备详情** 页面，并选择 **「最新遥测」** 选项卡。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryPE %}
{% elsif page.docsPrefix == "pe/edge/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryEdgePE %}
{% elsif page.docsPrefix == "edge/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryEdgeCE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryCE %}
{% endif %} 

还可将单板机的属性和遥测显示在仪表板上。
您可以**使用自定义部件创建自己的仪表板**，或**导入**现成仪表板。
 
{% capture minicomputerstogglespec %}
导入的仪表板%,%importedDashboard%,%templates/device-library/single-board-computers/device-imported-dashboard.md%br%
新建仪表板%,%newDashboard%,%templates/device-library/single-board-computers/device-new-dashboard.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="minicomputersDashboard" toggle-spec=minicomputerstogglespec %}  