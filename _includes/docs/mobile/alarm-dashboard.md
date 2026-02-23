{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

{{appPrefix}}允许配置在告警屏幕点击告警时显示的告警详情仪表板。
告警详情仪表板可在设备配置的告警规则中配置：

1. 通过屏幕左侧主菜单进入**设备配置**；
2. 点击要修改的设备配置；
3. 在打开的设备配置详情中导航至**告警规则**选项卡；
4. 点击**编辑**按钮；
5. 在**创建告警规则**表单的**移动仪表板**字段中选择所需仪表板；
6. 点击**应用更改**按钮；

{% include images-gallery.html imageCollection="alarm-dashboard" %}

{% capture dashboard_state_parameter %}
**注意：**要显示特定告警发起者数据，仪表板需要配置为在部件数据源中使用[**仪表板状态中的实体**](/docs/{{docsPrefix}}user-guide/ui/aliases/#entity-from-dashboard-state)别名。
{% endcapture %}
{% include templates/info-banner.md content=dashboard_state_parameter %}

要验证配置，请运行移动应用。然后导航到告警列表，点击已配置仪表板类型的告警。
**注意**，告警仪表板配置仅适用于应用配置后生成的告警。

<br>

<div style="display: flex;">
    <div class="mobile-frame ios">
        <div class="phone-shadow right"></div>
        <div class="frame-image">
            <img src="/images/mobile/{{docsPrefix}}alarm-dashboard-frame.png" alt="Alarm dashboard frame">
        </div>
        <div class="frame-video">
            <video autoplay loop preload="auto" muted playsinline>
                 <source src="https://video.thingsboard.io/mobile/{{docsPrefix}}alarm-dashboard.mp4" type="video/mp4">
                 <source src="https://video.thingsboard.io/mobile/{{docsPrefix}}alarm-dashboard.webm" type="video/webm">
            </video>
        </div>
    </div>
</div>
