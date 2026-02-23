---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用告警
description: 使用 ThingsBoard 告警功能进行 IoT 设备告警管理

alarm-type:
    0:
        image: /images/user-guide/alarms/alarms-type-pe.png

alarm-severity:
    0:
        image: /images/user-guide/alarms/alarms-severity-pe.png

relations-to-asset:
    0:
        image: /images/user-guide/alarms/propagation-1-pe.png
        title: '要查找与办公室 A 相关的设备，请进入「资产」页面，点击对应资产并在资产详情窗口中切换到「关系」选项卡。与办公室 A 关联的设备如下：Thermometer A1、Thermometer B1、Thermometer B2 和 Thermometer C3。'

alarm-creation-time-simple:
    0:
        image: /images/user-guide/alarms/alarm-creation-time-simple-pe.png
        title: '若超过阈值，告警会立即创建。'
        
alarm-creation-time-duration:
    0:
        image: /images/user-guide/alarms/alarm-creation-time-duration-pe.png
        title: '若超过阈值的持续时间超过设定值，则创建告警。'
    
alarm-creation-time-repeating:
    0:
        image: /images/user-guide/alarms/alarm-creation-time-repeating-pe.png
        title: '若超过阈值的次数达到指定次数，则创建告警。'

propagate-alarm-to-related-entities:
    0:
        image: /images/user-guide/alarms/propagation-5-pe.png
        title: '在设备档案的告警规则设置中，勾选「向相关实体传播告警」。'

propagate-alias:
    0:
        image: /images/user-guide/alarms/propagation-2-pe.png
        title: '创建用于筛选所选资产「办公室 A」的别名。'

add-alarms-widget:
    0:
        image: /images/user-guide/alarms/propagation-3-pe.png
        title: '添加告警表部件。将之前创建的别名指定为告警来源。请务必启用「搜索传播告警」选项以搜索传播的告警。'
    1:
        image: /images/user-guide/alarms/propagation-4-pe.png
        title: '告警表部件已添加。'

propagate-send-telemetry:
    0:
        image: /images/user-guide/alarms/propagation-6-pe.png
        title: '向超过告警规则中设定阈值的其中一台设备发送遥测数据以触发告警。'
        
propagate-alarm-created:
    0:
        image: /images/user-guide/alarms/propagation-7-pe.png
        title: '设备上已创建告警，根据我们的设置，告警已传播到相关资产。'
    1:
        image: /images/user-guide/alarms/propagation-8-pe.png
        title: '您也可以在资产详情窗口的「告警」选项卡中查看已创建的告警。'

find-alarms:
    0:
        image: /images/user-guide/alarms/find-alarms-1-pe.png
        title: '使用左侧菜单中的「告警」页面查看告警。在此以列表形式查看所有告警及以下信息：创建时间、来源、告警类型、严重程度、指派对象和告警状态。'
    1:
        image: /images/user-guide/alarms/find-alarms-2-pe.png
        title: '要查看告警详情，请点击目标告警「详情」列中的省略号（…）。'

find-alarm-for-specific-device:
    0:
        image: /images/user-guide/alarms/find-alarm-for-specific-device-pe.png
        title: '进入相应实体页面查找特定实体的告警。本例中为「设备」页面。点击目标实体（设备）打开其详情，并切换到「告警」选项卡。'

assignee-alarm-1:
    0:
        image: /images/user-guide/alarms/assign-alarm-to-user-3-pe.png
        title: '进入「告警」页面，在目标告警的「指派对象」列中指定用户。'
    1:
        image: /images/user-guide/alarms/assign-alarm-to-user-4-pe.png
        title: '进入包含告警表部件的「仪表板」页面，在目标告警的「指派对象」列中指定用户；'
    2:
        image: /images/user-guide/alarms/assign-alarm-to-user-1-pe.png
        title: '在所选实体的详情窗口中切换到「告警」选项卡，并在「指派对象」列中指定用户。'

assignee-alarm-2:
    0:
        image: /images/user-guide/alarms/assign-alarm-to-user-2-pe.png
        title: '告警指派给用户后，该用户将收到相关通知。'

acknowledge-alarm:
    0:
        image: /images/user-guide/alarms/acknowledge-alarm-1-pe.png
        title: '在告警表部件中点击「确认」图标。'
    1:
        image: /images/user-guide/alarms/acknowledge-alarm-2-pe.png
        title: '在告警详情窗口中点击「确认」按钮。'

clear-alarm:
    0:
        image: /images/user-guide/alarms/clear-alarm-1-pe.png
        title: '在告警表部件中点击「清除」图标。'
    1:
        image: /images/user-guide/alarms/clear-alarm-2-pe.png
        title: '在告警详情窗口中点击「清除」按钮。'
        
alarm-comments-1:
    0:
        image: /images/user-guide/alarms/alarm-comments-1-pe.png
        title: '要查看告警评论并添加自己的评论，请打开所选告警的详情。'
    1:
        image: /images/user-guide/alarms/alarm-comments-2-pe.png
        title: '在此可查看系统评论、其他用户的评论并添加自己的评论。'

visualize-alarms-on-dashboard-1:
    0:
        image: /images/user-guide/alarms/visualize-alarms-on-dashboard-1-pe.png
        title: '「告警表」部件可根据定义的时间范围和筛选条件，为所选实体方便地展示告警。'

visualize-alarms-on-dashboard-2:
    0:
        image: /images/user-guide/alarms/visualize-alarms-on-dashboard-2-pe.png
        title: '「告警数量」部件根据所选筛选条件显示告警数量。本例中显示活动告警数量。'

notification-about-alarm:
    0:
        image: /images/user-guide/alarms/notification-about-alarm-pe.png

propagation-settings:
    0:
        image: /images/user-guide/alarms/propagation-settings-pe.png

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/alarms.md %}