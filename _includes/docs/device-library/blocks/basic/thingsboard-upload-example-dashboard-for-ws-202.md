
{% assign importDashboardCE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-ce.png,
        title: 进入 **仪表板** 页面，点击右上角 **+** 按钮并选择 **导入仪表板**。
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-ce.png,
        title: 在仪表板导入窗口中上传 JSON 文件并点击 **导入** 按钮。
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-3-ce.png,
        title: 仪表板已导入。
'
%}

{% assign importDashboardPE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-pe.png,
        title: 进入 **仪表板** 页面。默认进入仪表板组 "All"。点击右上角 **+** 图标，选择 **导入仪表板**。
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-ws202-2-pe.png,
        title: 在仪表板导入窗口中上传 JSON 文件并点击 **导入** 按钮。
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-ws202-3-pe.png,
        title: 仪表板已导入。
'
%}

{% assign exampleDashboardPath = "/docs/devices-library/resources/dashboards/microcontrollers/basic/dashboard.json" %}
{% if boardLedCount == 3 %}
{% assign exampleDashboardPath = "/docs/devices-library/resources/dashboards/microcontrollers/rgb-led/dashboard.json" %}
{% endif %}

{% if hasDisplay == "true" %}
{% assign exampleDashboardPath = "/docs/devices-library/resources/dashboards/microcontrollers/display/dashboard.json" %}
{% endif %}

{% if hasCamera == "true" %}
{% assign exampleDashboardPath = "/docs/devices-library/resources/dashboards/microcontrollers/camera/dashboard.json" %}
{% endif %}

{% if include.exampleDashboardPath %}
{% assign exampleDashboardPath = include.exampleDashboardPath %}
{% endif %}

ThingsBoard 支持创建和自定义用于监控与管理数据、设备的交互式可视化（仪表板）。  
通过 ThingsBoard 仪表板，您可以高效管理与监控 IoT 设备及数据。下面为我们的设备创建仪表板。  

将仪表板添加到 ThingsBoard 需要导入。请按以下步骤操作：  

- 首先下载 [检查并控制设备数据仪表板]({{exampleDashboardPath}}){:target="_blank" download="dashboard.json"} 文件。

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or page.docsPrefix == "paas/eu/" or docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importDashboardPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importDashboardCE %}
{% endif %}