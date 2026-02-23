---
layout: docwithnav
assignees:
- ashvayka
title: 告警管理
description: 使用 ThingsBoard 告警功能管理 IoT 设备告警
redirect_from: "/docs/samples/alarms/basic-rules/"

alarm-type:
    0:
        image: /images/user-guide/alarms/alarms-type-ce.png

alarm-severity:
    0:
        image: /images/user-guide/alarms/alarms-severity-ce.png

find-alarms:
    0:
        image: /images/user-guide/alarms/find-alarms-1-ce.png
        title: '在左侧菜单中进入「Alarms」页面可查看所有告警。列表形式展示：创建时间、来源、告警类型、严重程度、指派对象及告警状态。'
    1:
        image: /images/user-guide/alarms/find-alarms-2-ce.png
        title: '查看告警详情时，请点击该告警所在行「Details」列中的省略号（…）。'

find-alarm-for-specific-device:
    0:
        image: /images/user-guide/alarms/find-alarm-for-specific-device-ce.png
        title: '要查看某实体的告警，请进入对应实体页面（例如「Devices」），点击目标实体打开详情，再切换到「Alarms」选项卡。'
    
notification-about-alarm:
    0:
        image: /images/user-guide/alarms/notification-about-alarm-ce.png

assignee-alarm-1:
    0:
        image: /images/user-guide/alarms/assign-alarm-to-user-3-ce.png
        title: '在「Alarms」页面中，在目标告警的「Assignee」列中指定用户。'
    1:
        image: /images/user-guide/alarms/assign-alarm-to-user-4-ce.png
        title: '在包含 Alarms table 部件的「Dashboards」页面中，在目标告警的「Assignee」列中指定用户；'
    2:
        image: /images/user-guide/alarms/assign-alarm-to-user-1-ce.png
        title: '在实体详情窗口的「Alarms」选项卡中，在目标告警的「Assignee」列中指定用户。'

assignee-alarm-2:
    0:
        image: /images/user-guide/alarms/assign-alarm-to-user-2-ce.png
        title: '告警被指派给某用户后，该用户会收到相应通知。'

acknowledge-alarm:
    0:
        image: /images/user-guide/alarms/acknowledge-alarm-1-ce.png
        title: '在 Alarms table 部件中点击「Acknowledge」图标。'
    1:
        image: /images/user-guide/alarms/acknowledge-alarm-2-ce.png
        title: '在告警详情窗口中点击「Acknowledge」按钮。'

clear-alarm:
    0:
        image: /images/user-guide/alarms/clear-alarm-1-ce.png
        title: '在 Alarms table 部件中点击「Clear」图标。'
    1:
        image: /images/user-guide/alarms/clear-alarm-2-ce.png
        title: '在告警详情窗口中点击「Clear」按钮。'

alarm-comments-1:
    0:
        image: /images/user-guide/alarms/alarm-comments-1-ce.png
        title: '查看告警评论或添加评论，请打开目标告警的详情。'
    1:
        image: /images/user-guide/alarms/alarm-comments-2-ce.png
        title: '在此可查看系统评论、其他用户评论，并可添加自己的评论。'

visualize-alarms-on-dashboard-1:
    0:
        image: /images/user-guide/alarms/visualize-alarms-on-dashboard-1-ce.png
        title: '「Alarms table」部件可按时间范围和筛选条件，为选定实体显示告警。'

visualize-alarms-on-dashboard-2:
    0:
        image: /images/user-guide/alarms/visualize-alarms-on-dashboard-2-ce.png
        title: '「Alarm count」部件根据所选筛选条件显示告警数量，本图所示为活动告警的数量。'

propagation-settings:
    0:
        image: /images/user-guide/alarms/propagation-settings-ce.png
    
relations-to-asset:
    0:
        image: /images/user-guide/alarms/propagation-1-ce.png
        title: '查找与 Office A 相关的设备：进入「Assets」页面，点击目标资产，在资产详情窗口中切换到「Relations」选项卡。与 Office A 关联的设备示例：Thermometer A1、Thermometer B1、Thermometer B2、Thermometer C3。'

alarm-creation-time-simple:
    0:
        image: /images/user-guide/alarms/alarm-creation-time-simple-ce.png
        title: '一旦超过阈值，立即创建告警。'

alarm-creation-time-duration:
    0:
        image: /images/user-guide/alarms/alarm-creation-time-duration-ce.png
        title: '当超过阈值的持续时间达到设定值时才创建告警。'

alarm-creation-time-repeating:
    0:
        image: /images/user-guide/alarms/alarm-creation-time-repeating-ce.png
        title: '当超过阈值的次数达到设定值时才创建告警。'

propagate-alarm-to-related-entities:
    0:
        image: /images/user-guide/alarms/propagation-5-ce.png
        title: '在设备配置文件的告警规则设置中，勾选「Propagate alarm to related entities」。'
    
propagate-alias:
    0:
        image: /images/user-guide/alarms/propagation-2-ce.png
        title: '创建一个筛选目标资产「Office A」的别名。'

add-alarms-widget:
    0:
        image: /images/user-guide/alarms/propagation-3-ce.png
        title: '添加 Alarms table 部件，将之前创建的别名设为告警来源，并启用「Search propagated alarms」以搜索传播的告警。'
    1:
        image: /images/user-guide/alarms/propagation-4-ce.png
        title: 'Alarms table 部件已添加完成。'

propagate-send-telemetry:
    0:
        image: /images/user-guide/alarms/propagation-6-ce.png
        title: '向某设备发送超过告警规则阈值的 telemetry，以触发告警。'

propagate-alarm-created:
    0:
        image: /images/user-guide/alarms/propagation-7-ce.png
        title: '设备上已创建告警，根据设置，告警已传播到相关资产。'
    1:
        image: /images/user-guide/alarms/propagation-8-ce.png
        title: '也可在资产详情窗口的「Alarms」选项卡中查看已创建的告警。'

---

{% include get-hosts-name.html %}
{% include docs/user-guide/alarms.md %}