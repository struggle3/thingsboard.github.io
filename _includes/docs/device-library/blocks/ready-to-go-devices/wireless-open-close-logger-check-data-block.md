触发传输以检查设备是否向 ThingsBoard 实例发送数据。  
点击菜单（右上角三个点 -> Trigger transmission）。  
若配置正确，您将在 ThingsBoard 中看到数据。点击设备，设备的最新数据将显示在「最新遥测」选项卡中。

{% assign checkEfentoSensorDataPE = '
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/check-device-data-1-pe.png,
        title: 点击设备，设备的最新数据将显示在「最新遥测」选项卡中。
'
%}

{% assign checkEfentoSensorDataCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/check-device-data-1-ce.png,
        title: 点击设备，设备的最新数据将显示在「最新遥测」选项卡中。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
{% include images-gallery.liquid showListImageTitles="false" imageCollection=checkEfentoSensorDataPE %}
{% else %}  
{% include images-gallery.liquid showListImageTitles="false" imageCollection=checkEfentoSensorDataCE %}
{% endif %}

{% capture effento-offer %}

**重要！**  
订购超过 250 台设备时，Efento 可为您预配置设备，使设备开箱即可向 ThingsBoard 实例发送数据，无需在传感器端进行配置。  
Efento 将提供 csv 文件，便于您在 ThingsBoard 实例上[批量配置所有设备](/docs/{{page.docsPrefix}}user-guide/bulk-provisioning/)。  

{% endcapture %}

{% include templates/info-banner.md content=effento-offer %}
