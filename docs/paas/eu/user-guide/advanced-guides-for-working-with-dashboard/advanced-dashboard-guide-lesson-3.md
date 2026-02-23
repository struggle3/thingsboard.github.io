---
layout: docwithnav-paas-eu
assignees:
- stitenko
title: 第3课：为每个设备添加和配置单独的状态

dashboard-lesson-3:
    0:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-1-pe.png
    1:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-2-pe.png
    2:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-3-pe.png
    3:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-4-pe.png
    4:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-5-pe.png
    5:
        src: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-6-pe.png

adding-new-rule-chain-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-1-pe.png
        title: '进入「规则链」页面，点击「加号」图标，然后从下拉菜单中选择「创建新规则链」；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-2-pe.png
        title: '将其命名为「Device Telemetry Emulators」，然后点击「Add」；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-3-pe.png
        title: '点击已创建的规则链以打开它。'

adding-new-rule-chain-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-4-pe.png
        title: '找到「generator」节点并将其拖入规则链。借助该节点，我们将生成遥测值以便在仪表板上进行可视化；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-5-pe.png
        title: '将其命名为「Indoor air quality data emulator」。将发送消息数量设为 100，发送周期设为 600。指定设备「SD-001」（室内空气质量传感器）为发起者。从文档复制脚本并粘贴到 generator 函数区域，以模拟温度、湿度和 CO2 的遥测数据。点击「Add」。'

adding-new-rule-chain-3:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-6-pe.png
        title: '将其命名为「Power consumption data emulator」。将发送消息数量设为 100，发送周期设为 600。指定设备「EM-002」（电能表）为发起者。从文档复制脚本并粘贴到 generator 函数区域，以模拟功耗遥测数据。点击「Add」。'

adding-new-rule-chain-4:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-7-pe.png
        title: '将其命名为「Water consumption data emulator」。将发送消息数量设为 100，发送周期设为 600。指定设备「WM-003」（水表）为发起者。从文档复制脚本并粘贴到 generator 函数区域，以模拟用水量和电池电压遥测数据。点击「Add」。'

adding-new-rule-chain-5:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-8-pe.png
        title: '将其命名为「IAQ data emulator」。将发送消息数量设为 100，发送周期设为 600。指定设备「AM-307」（IAQ 传感器）为发起者。从文档复制脚本并粘贴到 generator 函数区域，以模拟用水量和电池电压遥测数据。点击「Add」。'

adding-new-rule-chain-6:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-9-pe.png
        title: '找到「save timeseries」节点并将其拖入规则链；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-10-pe.png
        title: '将其命名为「save time series」，然后点击「Add」；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-11-pe.png
        title: '我们已添加所有必要的节点。'

adding-new-rule-chain-7:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-12-pe.png
        title: '点击「generator」节点右侧的灰色圆圈，将其拖至「save timeseries」节点的左侧。选择「Success」链接并点击「Add」；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-new-rule-chain-13-pe.png
        title: '对每个 generator 节点重复此操作。之后保存规则链。'

incoming-telemetry-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/incoming-telemetry-1-pe.png
        title: '等待 generator 节点中指定的周期过后，您即可在设备的「最新遥测」标签页中查看遥测数据。'

customize-office-sensors-list-widget-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-1-pe.png
        title: '进入仪表板，点击工具栏上的「Edit mode」按钮进入编辑模式；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-2-pe.png
        title: '点击「办公室传感器列表」部件的「铅笔」图标进入其编辑模式；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-3-pe.png
        title: '添加以下数据键对应的列：「temperature」「humidity」「co2」「powerConsumption」「waterConsumption」。然后对部件应用更改；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-4-pe.png
        title: '现在表格显示设备的遥测数据。'

customize-office-sensors-list-widget-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-5-pe.png
        title: '点击铅笔图标再次进入「办公室传感器列表」部件的编辑模式；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-6-pe.png
        title: '添加另一列：命名为「telemetryValue」，点击「Time series」图标添加新键；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-7-pe.png
        title: '将「Name」和「telemetryValue」键的标签分别重命名为「Device name」和「Telemetry value」。接着点击「telemetryValue」行旁的「齿轮」图标打开其设置；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-8-pe.png
        title: '开启「Use cell content function」选项。将文档中的函数插入对应字段。该函数会将多个遥测列合并为单个设备的单一列。然后点击「Save」；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-9-pe.png
        title: '现在需要隐藏不必要的列，如「temperature」「humidity」「co2」「powerConsumption」「waterConsumption」。点击「temperature」旁的「齿轮」图标打开其设置；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-10-pe.png
        title: '在「Default column visibility」菜单中选择「Hidden」。点击「Save」应用该列的更改；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-11-pe.png
        title: '对「humidity」「co2」「powerConsumption」「waterConsumption」列重复上述步骤。确保仅保留「Device name」和「Telemetry value」列可见；'

customize-office-sensors-list-widget-3:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-12-pe.png
        title: '点击「powerConsumption」键的「铅笔」图标；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-13-pe.png
        title: '选择「Sum」作为聚合函数，点击「Save」；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-14-pe.png
        title: '同样，将遥测键「waterConsumption」的聚合函数设为「Sum」。选择聚合后，移除「powerConsumption」和「waterConsumption」键标签上自动添加的前缀；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-15-pe.png
        title: '向上滚动找到时间窗口设置。使用仪表板的时间窗口并对部件应用更改；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-16-pe.png
        title: '保存仪表板的更改。'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-sensors-list-widget-17-pe.png
        title: '现在，「办公室传感器列表」部件中的室内空气质量传感器遥测数据在单列中显示。'

time-window-configuration-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-1-pe.png
        title: '进入仪表板编辑模式；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-2-pe.png
        title: '点击工具栏上的「Edit time window」图标，然后点击「齿轮」图标打开时间窗口设置；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-3-pe.png
        title: '将打开新的设置窗口。从「Realtime」标签页开始。隐藏「Last」标签页的间隔选择参数；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-4-pe.png
        title: '在「Relative」标签页中，点击间隔设置行的「铅笔」图标；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-5-pe.png
        title: '取消勾选除「Current day」「Current week」（周日-周六）和「Current week」（周一-周日）外的所有间隔。将其分组间隔和默认分组间隔设为 1 小时；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-6-pe.png
        title: '同时勾选「Current month」间隔。将分组间隔和默认分组间隔设为 2 小时。点击「Apply」；'

time-window-configuration-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-7-pe.png
        title: '进入「History」标签页。向用户隐藏「Last」间隔选项；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-8-pe.png
        title: '同时向用户隐藏「Range」间隔选项；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-9-pe.png
        title: '对于「Relative」标签页，保留默认设置；将聚合函数设为「Sum」，并通过隐藏确保用户无法修改此参数；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-10-pe.png
        title: '将分组间隔配置为「1 hour」并限制用户修改。点击「Apply」；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-11-pe.png
        title: '选择「Update」将更新的时间窗口设置应用到仪表板；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-12-pe.png
        title: '保存仪表板以确认更改；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/time-window-configuration-13-pe.png
        title: '如您所见，「办公室传感器列表」部件现在显示所选时间段内办公室的能源和用水数据，本例中为当天。'

adding-devices-states-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-devices-states-1-pe.png
        title: '进入仪表板编辑模式；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-devices-states-2-pe.png
        title: '点击「Manage dashboard states」菜单项，然后点击「加号」图标添加新仪表板状态；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-devices-states-3-pe.png
        title: '命名为「Indoor Air Quality Sensor」，输入状态 ID：<b>air_sensor</b>。点击「Add」。'

adding-devices-states-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/adding-devices-states-4-pe.png
        title: '同样，添加带 <b>energy_sensor</b> 状态 ID 的「Energy Meter」和带 <b>water_sensor</b> 状态 ID 的「Water Flow Meter」状态。'

action-go-to-device-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-1-pe.png
        title: '进入「office」状态，进入「办公室传感器列表」部件的编辑模式；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-2-pe.png
        title: '滚动到「Actions」菜单区域，点击「Add action」按钮；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-3-pe.png
        title: '「Actions」窗口将打开。点击屏幕右上角的「加号」图标打开新的「Add action」窗口；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-4-pe.png
        title: '在「Add action」对话框中，选择「On row click」作为操作来源并输入操作名称。然后选择「Custom action」操作类型。选择操作类型后会出现「Custom action function」区域。从文档复制函数并粘贴进去。之后点击「Add」；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-5-pe.png
        title: '在「Actions」窗口中，您可查看已配置的操作，包括其来源、图标和类型。点击「Save」；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-6-pe.png
        title: '点击「Apply」保存部件设置；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-7-pe.png
        title: '点击仪表板页面右上角的「Save」保存仪表板。'

action-go-to-device-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-8-pe.png
        title: '点击任意设备行即可切换到其状态；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-device-state-9-pe.png
        title: '您将切换到所选设备的状态。'

customize-office-plan-widget-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-1-pe.png
        title: '在「office」状态下，进入仪表板编辑模式，点击「办公室传感器列表」部件的「铅笔」图标修改其设置。'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-2-pe.png
        title: '在现有数据键的基础上添加以下键：「temperature」「humidity」「co2」「powerConsumption」「waterConsumption」「batteryLevel」。然后进入「Appearance」标签页；'

customize-office-plan-widget-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-3-pe.png
        title: '向下滚动到「Tooltip」区域，开启「Use tooltip function」选项。然后从文档复制提示函数并粘贴到部件的「Tooltip function」字段。将提示 Y 轴相对于标记的偏移设为 -0.77；'

customize-office-plan-widget-3:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-4-pe.png
        title: '进入「Widget card」标签页。打开「Advanced widget style」并将提供的 CSS 粘贴到「Widget CSS」字段；'

customize-office-plan-widget-4:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-5-pe.png
        title: '进入「Actions」标签页，点击「加号」添加新操作；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-6-pe.png
        title: '在「Add action」对话框中，选择「Tooltip tag action」作为操作来源。输入「sensor_details」作为操作名称。选择「Custom action」作为操作类型，并将指定函数粘贴到「Custom action function」区域。然后点击「Add」；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-7-pe.png
        title: '点击「Apply」保存修改；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-8-pe.png
        title: '点击仪表板右上角的「Save」保存仪表板配置。'

customize-office-plan-widget-5:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-9-pe.png
        title: '点击「办公室平面图」部件上的任意标记可打开提示。每个设备的提示包含可访问该设备详情的行按钮。点击此行。'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/customize-office-plan-widget-10-pe.png
        title: '您将切换到所选设备的状态。'

indoor-air-quality-sensor-card-widgets-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-indoor-ai-quality-state-1-pe.png
        title: '点击「办公室传感器列表」部件中的「Indoor Air Quality Sensor」设备行以切换到其状态；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-temperature-card-widgets-1-pe.png
        title: '进入仪表板编辑模式，点击顶部的「+ Add widget」按钮或屏幕中央的大的「Add new widget」图标；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-temperature-card-widgets-2-pe.png
        title: '找到「Indoor Environment」部件包并点击；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-temperature-card-widgets-3-pe.png
        title: '选择「Indoor temperature card」部件；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-temperature-card-widgets-4-pe.png
        title: '将「Selected entity」别名指定为数据源。用于「提取」温度值的「temperature」键已添加；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-temperature-card-widgets-5-pe.png
        title: '向下滚动到「Icon」区域。使用预定义范围根据温度值自定义图标颜色变化。便于更快估算温度值。设置取值范围及对应颜色。然后点击「Apply」；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-temperature-card-widgets-6-pe.png
        title: '为「Value」区域设置取值范围及对应颜色。应用更改；'
    7:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-temperature-card-widgets-7-pe.png
        title: '清空「Card border radius」值，点击「Add」；'
    8:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-temperature-card-widgets-8-pe.png
        title: '我们已添加显示当前温度的部件。按需调整部件大小。'

indoor-air-quality-sensor-card-widgets-2:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-humidity-card-widgets-1-pe.png
        title: '点击屏幕顶部的「Add widget」按钮；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-humidity-card-widgets-2-pe.png
        title: '进入「Indoor Environment」部件包并选择「Indoor humidity card」部件；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-humidity-card-widgets-3-pe.png
        title: '将「Selected entity」别名指定为数据源。用于「提取」湿度值的「humidity」键已添加；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-humidity-card-widgets-4-pe.png
        title: '向下滚动到「Icon」区域。设置取值范围及对应颜色。然后点击「Apply」；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-humidity-card-widgets-5-pe.png
        title: '为「Value」区域设置取值范围及对应颜色。应用更改；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-humidity-card-widgets-6-pe.png
        title: '清空「Card border radius」值。点击「Add」；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-humidity-card-widgets-7-pe.png
        title: '已添加显示当前湿度的部件。将其放在「Temperature」卡片部件右侧并调整大小。'

indoor-air-quality-sensor-card-widgets-3:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-co2-card-widgets-1-pe.png
        title: '点击屏幕顶部的「+ Add widget」按钮；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-co2-card-widgets-2-pe.png
        title: '选择「Indoor CO2 card」部件。该部件位于「Indoor Environment」部件包中；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-co2-card-widgets-3-pe.png
        title: '将「Selected entity」别名指定为数据源。用于「提取」空气中 CO2 值的「CO2」键已添加；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-co2-card-widgets-4-pe.png
        title: '向下滚动到「Icon」区域。设置取值范围及对应颜色。然后点击「Apply」；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-co2-card-widgets-5-pe.png
        title: '为「Value」区域设置取值范围及对应颜色。应用更改；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-co2-card-widgets-6-pe.png
        title: '清空「Card border radius」值。点击「Add」；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-co2-card-widgets-7-pe.png
        title: '已添加显示当前 CO2 水平的部件。将其放在「Humidity」部件右侧。调整部件大小以匹配仪表板样式，并保存仪表板。'

indoor-air-quality-sensor-card-widgets-4:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/indoor-air-quality-sensor-card-three-widgets-1-pe.png
        title: '现在您可以查看当前的温度、湿度和 CO2 值。'

temperature-and-humidity-history-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-1-pe.png
        title: '进入仪表板编辑模式，点击「+ Add widget」按钮；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-2-pe.png
        title: '找到「Charts」部件包并点击；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-3-pe.png
        title: '选择「Line chart」部件；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-4-pe.png
        title: '使用部件的时间窗口并修改其设置。选择「Relative」，将时间间隔设为「Current day」。聚合函数保持「Average」，分组间隔设为 1 小时。然后点击「Update」；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-5-pe.png
        title: '将「Selected entity」别名指定为数据源。添加数据键「temperature」和「humidity」并指定其标签和单位。然后点击「temperature」键的「齿轮」图标打开其配置窗口；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-6-pe.png
        title: '开启「Show points」和「Point label」选项。点击「Save」。对「humidity」数据键重复此操作；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-7-pe.png
        title: '默认情况下图表在 Y 轴包含一个刻度。将其标为「Temperature」并设置单位为 °C。为「Humidity」添加另一刻度，置于右侧，单位设为 %。将「axis1」刻度应用到「humidity」键；'
    7:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-8-pe.png
        title: '将图表标题改为「Temperature and Humidity history」；'
    8:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-9-pe.png
        title: '将图例位置设为「Bottom」，取消勾选「Show values」中的「Average」；'
    9:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-10-pe.png
        title: '清空「Card border radius」值以简化部件外观。点击「Add」；'
    10:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-11-pe.png
        title: '将部件移至仪表板右上角并调整大小；'
    11:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/temperature-and-humidity-history-12-pe.png
        title: '已添加「Temperature and Humidity history」部件。保存仪表板以应用更改。'

air-quality-widget-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-1-pe.png
        title: '进入仪表板编辑模式，点击「+ Add widget」按钮；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-2-pe.png
        title: '选择「Charts」部件包中的「Line chart」部件；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-3-pe.png
        title: '使用部件的时间窗口。在时间窗口设置中选择「Relative」，将时间间隔设为「Current day」。聚合函数保持「Average」，分组间隔设为 1 小时。然后点击「Update」；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-4-pe.png
        title: '将「Selected entity」别名指定为数据源。添加「co2」作为数据键并设置其标签和单位。然后点击「齿轮」图标配置「co2」数据键设置；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-5-pe.png
        title: '开启「Smooth line」选项使图表线条更平滑。点击「Save」；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-6-pe.png
        title: '为 Y 轴输入名称，如「CO2 level」，单位设为「ppm」；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-7-pe.png
        title: '将图表标题改为「Air Quality」；'
    7:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-8-pe.png
        title: '将图例位置设为「Bottom」。勾选「Show values」中的「Min」「Max」「Average」以在图表上显示这些统计值；'
    8:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-9-pe.png
        title: '清空「Card border radius」值。点击「Add」；'
    9:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/air-quality-widget-10-pe.png
        title: '将此部件放在「Temperature and Humidity history」部件下方、仪表板右下角，并调整大小。保存仪表板以应用更改。'

air-sensor-state:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/smart-sensor-state-1-pe.png
        title: '在单独的仪表板状态中监控当前空气质量并分析其随时间的变化。'

power-consumption-card-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-energy-meter-state-1-pe.png
        title: '点击「办公室传感器列表」部件中的「Energy Meter」设备行以进入其状态；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-1-pe.png
        title: 'Enter dashboard editing mode, and click the "+ Add widget" button;'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-2-pe.png
        title: '在部件库中找到并点击「Industrial widgets」包；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-3-pe.png
        title: '选择「Power consumption card」部件；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-4-pe.png
        title: '将「Selected entity」别名指定为数据源。「powerConsumption」键已指定为数据键。点击「铅笔」图标打开「powerConsumption」数据键配置；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-5-pe.png
        title: '选择「Sum」作为聚合函数以汇总所选时间段内的所有数据点值。点击「Save」；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-6-pe.png
        title: '使用仪表板时间窗口；'
    7:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-7-pe.png
        title: '将部件标签改为「Power consumption」。打开图标颜色设置；'
    8:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-8-pe.png
        title: '按截图所示设置取值范围及对应颜色。然后点击「Apply」；'
    9:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-9-pe.png
        title: '打开字体设置；'
    10:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-10-pe.png
        title: '将字体大小设为 35 像素，点击「Apply」；'
    11:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-11-pe.png
        title: '打开数值颜色设置；'
    12:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-12-pe.png
        title: '按截图所示设置取值范围及对应颜色。然后点击「Apply」；'
    13:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-13-pe.png
        title: '清空「Card border radius」值，点击「Add」；'
    14:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-14-pe.png
        title: '已添加显示仪表板时间窗口指定时间段内总功耗的部件。按需调整部件大小，然后保存仪表板以应用更改。'

power-consumption-range-chart-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-1-pe.png
        title: '进入仪表板编辑模式，点击屏幕顶部的「+ Add widget」按钮；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-2-pe.png
        title: '选择「Charts」部件包中的「Range chart」部件；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-3-pe.png
        title: '使用仪表板时间窗口。将「Selected entity」别名指定为数据源，「powerConsumption」键为数据键。将图表标题改为「Power consumption history」；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-4-pe.png
        title: '将单位改为 kW。然后打开范围颜色设置；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-5-pe.png
        title: '图表线条颜色根据数值所属范围着色，便于通过颜色变化快速了解数据。设置取值范围及对应颜色。点击「Apply」；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-6-pe.png
        title: '进入「Range thresholds settings」，关闭「Label」选项；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-7-pe.png
        title: '打开「Line color」设置，将不透明度设为 40%。应用更改；'
    7:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-8-pe.png
        title: '展开 Y 轴设置。输入「Power consumption」作为轴标签，关闭「Show split lines」选项；'
    8:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-9-pe.png
        title: '取消勾选「Show card buttons」中的「Data export」，移除「Card border radius」的值。点击「Add」完成范围图表部件的添加；'
    9:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/power-consumption-range-chart-10-pe.png
        title: '已添加「Power consumption history」部件。将其放在「Power consumption」部件右侧并调整大小。保存仪表板以应用更改。'

energy-meter-state-final:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/energy-meter-state-final-1-pe.png
        title: '现在您可以监控当天的总能耗并追踪按小时统计的历史能耗数据。'

water-consumption-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/go-to-water-flow-meter-state-1-pe.png
        title: '点击「办公室传感器列表」中的「Water Flow Meter」设备以进入其状态；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-1-pe.png
        title: '进入仪表板编辑模式，点击「+ Add widget」按钮；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-2-pe.png
        title: '进入「Industrial widgets」包并选择任一部件，例如「Flow rate card」；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-3-pe.png
        title: '将「Selected entity」别名指定为数据源。添加「waterConsumption」键作为数据键，点击「铅笔」图标打开其数据键配置；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-4-pe.png
        title: '选择「Sum」作为聚合函数。点击「Save」；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-5-pe.png
        title: '使用仪表板时间窗口。将部件标签改为「Water consumption」。修改部件图标以更好地匹配显示的数据类型。打开「Icons」窗口；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-6-pe.png
        title: '选择新图标；'
    7:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-7-pe.png
        title: '打开图标的颜色设置。设置取值范围及对应颜色。然后点击「Apply」；'
    8:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-8-pe.png
        title: '将单位设为 gallon。打开「Value」选项的颜色设置；'
    9:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-9-pe.png
        title: '按截图所示设置取值范围及对应颜色。然后点击「Apply」；'
    10:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-10-pe.png
        title: '清空「Card border radius」值。点击「Add」；'
    11:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-11-pe.png
        title: '已添加显示仪表板时间窗口指定时间段内总用水量的部件。按需调整部件大小并保存仪表板。'

water-consumption-range-chart-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-range-chart-1-pe.png
        title: '进入「Energy Meter」状态，进入仪表板编辑模式。右键点击「Power consumption history」部件，从下拉菜单中选择「Copy」；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-range-chart-2-pe.png
        title: '进入「Water Flow Meter」状态。在仪表板上右键点击，选择「Paste」以粘贴复制的部件；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-range-chart-3-pe.png
        title: '将此部件放在「Water consumption」部件右侧并调整大小。点击「铅笔」图标进入「Power consumption history」部件设置；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-range-chart-4-pe.png
        title: '保留「Selected entity」别名为数据源。将数据键「powerConsumption」替换为「waterConsumption」。将标题改为「Water consumption history」；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-range-chart-5-pe.png
        title: '将单位改为 gal（gallon）。关闭「Fill area」选项。进入范围颜色设置；'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-range-chart-6-pe.png
        title: '按截图所示设置取值范围及对应颜色。然后点击「Apply」；'
    6:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-range-chart-7-pe.png
        title: '展开 Y 轴设置。将轴标签改为「Water consumption」。点击「Apply」保存更改；'
    7:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-consumption-range-chart-8-pe.png
        title: '已添加「Water consumption history」部件。保存仪表板。'
      
battery-charge-1:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/battery-charge-1-pe.png
        title: '在仪表板编辑模式下点击「+ Add widget」按钮；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/battery-charge-2-pe.png
        title: '选择「Status indicators」部件包中的「Battery level」部件；'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/battery-charge-3-pe.png
        title: '将「Selected entity」别名指定为数据源。「batteryLevel」键已指定为数据键；'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/battery-charge-4-pe.png
        title: '清空「Card border radius」值。点击「Add」；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/battery-charge-5-pe.png
        title: '将此部件放在「Water consumption history」部件右侧并调整大小。最后保存仪表板。'

water-flow-meter-final:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/water-flow-meter-state-final-1-pe.png
        title: '「Water Flow Meter」设备状态已配置完成。可监控当日用水量、追踪按小时统计的历史用水数据，并控制「Water Flow Meter」设备的电池电量。'

dashboard-final-lesson-3:
    0:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-1-pe.png
        title: '默认状态；'
    1:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-2-pe.png
        title: '楼宇状态'
    2:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-3-pe.png
        title: '办公室状态'
    3:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-4-pe.png
        title: '室内空气质量传感器状态；'
    4:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-5-pe.png
        title: '电能表状态'
    5:
        image: /images/user-guide/advanced-guides-for-working-with-dashboard/lesson-3/dashboard-final-lesson-3-6-pe.png
        title: '水表状态'

---

{% assign docsPrefix = "paas/eu/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-3.md %}