---
layout: docwithnav-paas-eu
assignees:
- stitenko
title: 第4课：告警管理

dashboard-lesson-4:
    0:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/dashboard-final-lesson-4-1-pe.png
    1:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/dashboard-final-lesson-4-2-pe.png
    2:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/dashboard-final-lesson-4-3-pe.png
    3:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/dashboard-final-lesson-4-4-pe.png

high-temperature-alarm-rule-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-1-pe.png
        title: '- 进入<b>Alarms</b>页面(1)的<b>Alarm rules</b>标签页(2)。<br>- 点击右上角的「<b>+</b>」按钮(3)，选择<b>Create new alarm rule</b>(4)。'

high-temperature-alarm-rule-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-2-pe.png
        title: '在<b>General</b>区域中指定以下设置：<br>- <b>Alarm type</b>(5)：High temperature<br>- <b>Entity type</b>(6)：Device profile<br>- <b>Device profile</b>(7)：air-sensor'

high-temperature-alarm-rule-3:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-3-pe.png
        title: '添加参数(8)——其数据将用于规则条件的变量。'

high-temperature-alarm-rule-4:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-4-pe.png
        title: '<b>Add trigger condition</b>(10)：<br>将严重级别设为<b>Critical</b>(11)，点击<b>Add condition</b>(12)。'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-5-pe.png
        title: '点击<b>Add argument filter</b>(13)。'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-6-pe.png
        title: '<b>General(14)：</b><b>Argument：</b>temperature（先前添加的参数）。<b>Value type：</b>Numeric<br><b>Filters：</b>点击<b>Add</b>添加新过滤器(15)：<b>Operation(16)：</b>greater than；<b>Value source：</b>Static；<b>Value：</b>26。<br>点击<b>Add</b>(17)。'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-7-pe.png
        title: '点击<b>Save</b>(18)。'

high-temperature-alarm-rule-5:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-8-pe.png
        title: '点击<b>Add trigger condition</b>(19)。'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-9-pe.png
        title: '将<b>severity</b>级别设为<b>Major</b>(20)，点击<b>Add condition</b>(21)。'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-10-pe.png
        title: '点击<b>Add argument filter</b>(22)。'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-11-pe.png
        title: '<b>General(23)：</b><b>Argument：</b>temperature；<b>Value type：</b>Numeric<br><b>Filters：</b>点击<b>Add</b>添加过滤器(24)：<b>Operation(25)：</b>greater than；<b>Value source：</b>Static；<b>Value：</b>24。'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-12-pe.png
        title: '添加另一过滤器(26)：<b>Operation(27)：</b>less or equal；<b>Value source：</b>Static；<b>Value：</b>26。点击<b>Add</b>(28)。'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-13-pe.png
        title: '点击<b>Save</b>(29)。'

high-temperature-alarm-rule-6:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-14-pe.png
        title: '现在添加清除告警的条件。点击<b>Add clear condition</b>(30)。'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-15-pe.png
        title: '点击<b>Add condition</b>(31)。'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-16-pe.png
        title: '点击<b>Add argument filter</b>(32)。'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-17-pe.png
        title: '<b>General(33)：</b><b>Argument：</b>temperature；<b>Value type：</b>Numeric<br><b>Filters：</b>点击<b>Add</b>添加新过滤器(34)：<b>Operation(35)：</b>less or equal；<b>Value source：</b>Static；<b>Value：</b>24。<br>点击<b>Add</b>(36)。'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-18-pe.png
        title: '点击<b>Save</b>(37)。'

high-temperature-alarm-rule-7:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-19-pe.png
        title: '展开高级设置(38)。<br>- 开启<b>Propagate alarm to related entities</b>选项(39)，并指定设备-资产关系中使用的<b>Relation type</b>：<b>Contains</b>(40)。<br>最后点击<b>Add</b>(41)。'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-20-pe.png
        title: '「High temperature」告警规则已创建并立即生效。'

all-alarms-rules:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-21-pe.png
        title: '- 进入<b>Alarms</b>页面→<b>Alarm rules</b>标签页。<br>- 点击右上角「<b>+</b>」按钮，从下拉菜单中选择<b>Import alarm rule</b>。'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-22-pe.png
        title: '在导入对话框中拖放 JSON 文件或手动选择。点击<b>Import</b>上传配置。'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-23-pe.png
        title: '将「air-sensor」设备配置设为目标实体的告警规则。<br>最后点击<b>Add</b>保存规则。'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/high-temperature-alarm-rule-24-pe.png
        title: '为「air-sensor」设备配置定义的所有告警规则。'

final-low-temperature-alarm-rules:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/final-low-temperature-alarm-rules-1-pe.png
        title: '同样，添加低温告警的创建和清除规则：温度低于 20°C 但不低于 18°C（含）时创建「Major」类型告警；温度低于 18°C 时创建「Critical」类型告警。温度再次升至 20°C 以上时自动清除告警。'

final-high-humidity-alarm-rules:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/final-high-humidity-alarm-rules-1-pe.png
        title: '添加高湿度告警的创建和清除规则：湿度在 60% 至 65% 之间时触发「Major」严重类型告警；湿度超过 65% 时触发「Critical」告警。湿度再次降至 60% 以下时自动清除告警。'
  
final-low-humidity-alarm-rules:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/final-low-humidity-alarm-rules-1-pe.png
        title: '添加低湿度告警的创建和清除规则：湿度低于 40% 但不低于 35%（含）时创建「Major」严重类型告警；湿度低于 35% 时创建「Critical」严重类型告警。湿度再次升至 40% 以上时自动清除告警。'

final-co2-alarm-rules:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/final-co2-alarm-rules-1-pe.png
        title: '最后添加高 CO2 告警的创建和清除规则：CO2 超过 490 ppm 时触发「Major」严重类型告警；超过 500 ppm 时触发「Critical」严重类型告警。CO2 再次降至 490 ppm 以下时自动清除告警。'

customizing-rule-chain-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/customizing-rule-chain-1-pe.png
        title: '进入「Rule chains」页面，打开「Device Telemetry Emulators」规则链。移除所有从「generator」节点到「save telemetry」节点的链接；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/customizing-rule-chain-2-pe.png
        title: '在节点库中找到「device profile」节点，将其拖入规则链画布；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/customizing-rule-chain-3-pe.png
        title: '将打开节点配置窗口。命名为「Device profile node」，点击「Add」；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/customizing-rule-chain-4-pe.png
        title: '将「generator」节点链接到「device profile」节点。为这些连接选择「Success」链接。将「device profile」节点链接到「save timeseries」节点，同样选择「Success」链接。之后保存规则链。'

adding-alarms-table-widget-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-1-pe.png
        title: '点击「办公室传感器列表」部件中的「Indoor Air Quality Sensor」设备行以切换到其状态；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-2-pe.png
        title: '进入仪表板编辑模式；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-3-pe.png
        title: '点击屏幕顶部的「+ Add widget」按钮；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-4-pe.png
        title: '找到「Alarm widgets」部件包并点击；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-5-pe.png
        title: '选择「Alarms table」部件；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-6-pe.png
        title: '将「Selected entity」别名指定为数据源。在过滤器区域的告警状态列表中勾选「Active」以仅显示活动告警；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-7-pe.png
        title: '移除「assignee」列；'
    7:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-8-pe.png
        title: '将部件标题改为「Air sensor alarms」。在「Table buttons」中仅保留开启「Allow alarms acknowledgment」和「Allow alarms clear」；'
    8:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-9-pe.png
        title: '取消勾选「Card appearance」中的「Data export」。然后点击「Add」确认添加部件；'
    9:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-10-pe.png
        title: '已添加用于显示设备活动告警的部件。将「Air sensor alarms」部件放置在仪表板空白处，拖拽右下角调整大小。然后保存仪表板。'

final-air-sensor-state-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/adding-alarms-table-widget-11-pe.png
        title: '<b>air_sensor</b>状态的最终效果。'

alarm-send-telemetry-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/send-telemetry-1-pe.png
        title: '进入「Devices」页面。选择「Indoor Air Quality Sensor」设备，在「Device details」窗口中点击「Check connectivity」按钮；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/send-telemetry-2-pe.png
        title: '在打开窗口中选择所需消息协议和操作系统。必要时安装所需客户端工具。然后复制提供的包含遥测数据的命令；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/send-telemetry-3-pe.png
        title: '打开<b>Terminal</b>并粘贴复制的命令。该命令将向 ThingsBoard 服务器发送包含 {"temperature":25} 的 POST 请求。执行命令。成功执行后「temperature」读数将发布。然后关闭连接窗口。'

alarm-send-telemetry-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/send-telemetry-4-pe.png
        title: '返回<b>air_sensor</b>仪表板状态。在 Alarms table 部件中应出现告警，显示创建时间、告警来源、严重程度和状态。'

alarm-send-telemetry-3:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/send-telemetry-5-pe.png
        title: '您还将在通知中心收到告警触发的通知。'

acknowledge-alarm-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/acknowledge-alarm-1-pe.png
        title: '要确认告警，点击「Acknowledge」图标；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/acknowledge-alarm-2-pe.png
        title: '点击「Yes」确认确认告警；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/acknowledge-alarm-3-pe.png
        title: '告警状态已变更为「Active Acknowledged」。'

clear-alarm-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/clear-alarm-1-pe.png
        title: '要清除告警，点击「Clear」图标；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/clear-alarm-2-pe.png
        title: '点击「Yes」确认清除告警；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/clear-alarm-3-pe.png
        title: '告警已清除。'

add-alarm-widget-to-office-state-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-1-pe.png
        title: '进入<b>air_sensor</b>状态，进入仪表板编辑模式；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-2-pe.png
        title: '右键点击告警部件，从下拉菜单中选择「Copy」；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-3-pe.png
        title: '进入<b>office</b>状态，在仪表板空白处右键点击，选择「Paste」；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-4-pe.png
        title: '将部件放置在仪表板空白处并调整大小。然后保存仪表板；'

add-alarm-widget-to-office-state-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-5-pe.png
        title: '保存更改后，将自动跳转回<b>air_sensor</b>状态。切换到<b>Office A</b>状态查看结果。'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-6-pe.png
        title: '您可能注意到活动告警未在部件中显示。这是因为当前选择的是 Office A 实体，而告警是在与该办公室有关联的设备上创建的。此前我们在告警规则中指定告警应传播到相关实体。现在需要配置部件以搜索这些传播的告警。'

add-alarm-widget-to-office-state-3:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-7-pe.png
        title: '进入仪表板编辑模式，点击告警部件上的「铅笔」图标进行编辑；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-8-pe.png
        title: '将告警来源改为「Office sensors」实体别名。开启「Search propagated alarms」选项。该选项可在存在关联的情况下显示所选实体及其子实体的告警；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-9-pe.png
        title: '将部件标题改为「Office alarms」。然后应用更改；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-10-pe.png
        title: '保存仪表板。'

final-office-state-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-office-state-11-pe.png
        title: '现在如您所见，部件显示与所选办公室有关联的设备的告警。'

add-alarm-widget-to-building-a-state-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-building-state-1-pe.png
        title: '在<b>office</b>状态下，进入仪表板编辑模式。右键点击告警部件，从下拉菜单中选择「Copy」；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-building-state-2-pe.png
        title: '进入<b>Buildings</b>（默认）状态，在仪表板空白处右键点击，选择「Paste」；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-building-state-3-pe.png
        title: '将部件放置在仪表板空白处并调整大小。点击告警部件上的「铅笔」图标进行编辑；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-building-state-4-pe.png
        title: '将告警来源改为「Building offices」实体别名；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-building-state-5-pe.png
        title: '将部件标题改为「Building alarms」。然后应用更改；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-building-state-6-pe.png
        title: '保存仪表板。'

add-alarm-widget-to-building-a-state-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-building-state-7-pe.png
        title: '告警部件显示与所选楼宇关联的设备的告警。'

add-alarm-widget-to-buildings-state-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-buildings-state-1-pe.png
        title: '在<b>office</b>状态下，进入仪表板编辑模式。右键点击告警部件，从下拉菜单中选择「Copy」；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-buildings-state-2-pe.png
        title: '进入<b>Buildings</b>（默认）状态，在仪表板空白处右键点击，选择「Paste」；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-buildings-state-3-pe.png
        title: '将部件放置在仪表板空白处并调整大小。然后点击告警部件上的「铅笔」图标进行编辑；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-buildings-state-4-pe.png
        title: '将告警来源改为「Buildings」实体别名；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-buildings-state-5-pe.png
        title: '将部件重命名为「All alarms」，应用更改；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-buildings-state-6-pe.png
        title: '最后保存仪表板。'

add-alarm-widget-to-buildings-state-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/add-alarm-widget-to-buildings-state-7-pe.png
        title: '现在，如果设备上有告警，它们将显示在<b>Building</b>（默认）状态的告警部件中。'

dashboard-final-lesson-4:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/dashboard-final-lesson-4-1-pe.png
        title: '默认状态；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/dashboard-final-lesson-4-2-pe.png
        title: '楼宇状态'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/dashboard-final-lesson-4-3-pe.png
        title: '办公室状态'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-4/dashboard-final-lesson-4-4-pe.png
        title: '室内空气质量传感器状态；'

---

{% assign docsPrefix = "paas/eu/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-4.md %}