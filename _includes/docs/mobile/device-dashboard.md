{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

{{appPrefix}}允许配置点击特定类型设备时显示的设备详情仪表板。
设备详情仪表板可在设备配置文件中配置：

1. 通过屏幕左侧主菜单进入**设备配置**；
2. 点击要修改的设备配置；
3. 在打开的设备配置详情中点击**编辑**按钮；
4. 在**移动仪表板**字段中选择所需仪表板；
5. 点击**应用更改**按钮；

{% include images-gallery.html imageCollection="device-dashboard" %}

{% capture dashboard_state_parameter %}
**注意：**要显示特定设备数据，仪表板需要配置为在部件数据源中使用[**仪表板状态中的实体**](/docs/{{docsPrefix}}user-guide/ui/aliases/#entity-from-dashboard-state)别名。
{% endcapture %}
{% include templates/info-banner.md content=dashboard_state_parameter %}

要验证配置，请运行移动应用。然后导航到设备列表，点击已配置仪表板类型的设备。

<br>

<div style="display: flex;">
    <div class="mobile-frame ios">
        <div class="phone-shadow right"></div>
        <div class="frame-image">
            <img src="/images/mobile/{{docsPrefix}}device-dashboard-frame.png" alt="Device dashboard frame">
        </div>
        <div class="frame-video">
            <video autoplay loop preload="auto" muted playsinline>
                 <source src="https://video.thingsboard.io/mobile/{{docsPrefix}}device-dashboard.mp4" type="video/mp4">
                 <source src="https://video.thingsboard.io/mobile/{{docsPrefix}}device-dashboard.webm" type="video/webm">
            </video>
        </div>
    </div>
</div>
