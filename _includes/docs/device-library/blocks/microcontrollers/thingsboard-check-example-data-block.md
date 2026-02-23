
检查并控制设备数据仪表板结构：  

{% assign generalViewOfDashboardPath = "/images/devices-library/basic/microcontrollers/dashboard/thingsboard-general-view-of-example-dashboard.png" %}

{% if boardLedCount == 3 %}
{% assign generalViewOfDashboardPath = "/images/devices-library/basic/microcontrollers/dashboard/thingsboard-general-view-of-example-dashboard-rgb-led.png" %}
{% elsif hasCamera == "true" %}
{% assign generalViewOfDashboardPath = "/images/devices-library/basic/microcontrollers/dashboard/thingsboard-general-view-of-example-dashboard-camera.png" %}
{% endif %}

{% assign checkDataDashboard='
    ===
        image: /images/devices-library/paas/thingsboard-open-dashboard-click-on-row.png,
        title: 点击表格中的仪表板以打开导入的仪表板，查看设备数据。
    ===
        image: ' | append: generalViewOfDashboardPath | append: ',
        title: 检查数据和控制设备的仪表板视图。
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-device-attributes.png,
        title: 从设备接收的属性。
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-device-info.png,
        title: ThingsBoard 服务器上的设备信息。
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-led-mode-history.png,
        title: 查看 LED 模式变化历史的部件。
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-temperature-history.png,
        title: 查看模拟温度历史的部件。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=checkDataDashboard %}
