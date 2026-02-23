---
layout: docwithnav
assignees:
- ashvayka
title: SCADA dashboards
description: 使用 ThingsBoard 的 SCADA IoT dashboards

scada-dashboard-layout-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/add-scada-dashboard-1-ce.png
        title: '进入 "Dashboards" 页面，点击屏幕右上角的 "plus" 图标添加新 dashboard。在出现的下拉菜单中选择 "Create new dashboard"。在打开的对话框中输入 dashboard 标题，点击 "Add" 确认；'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/add-scada-dashboard-2-ce.png
        title: '创建完成后，新 dashboard 会自动打开，您可立即进行配置。点击 dashboard 界面左上角的 "Layouts"；'
    2:
        image: /images/user-guide/scada/scada-dashboards/ce/add-scada-dashboard-3-ce.png
        title: '然后将 layout 从 "Default" 改为 "SCADA"，并保存更改。'

layout-settings-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/layout-settings-1-ce.png
        title: '在 "Manage layouts" 窗口中点击 "gear" 图标；'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/layout-settings-2-ce.png
        title: '将打开包含 layout 设置的小窗口。'

scada-columns-count-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-columns-count-1-ce.png
        title: 'layout 设置中的列数必须能被 24 整除（如 24、48、72，最多 1008）；'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-columns-count-2-ce.png
        title: '列数设为 24；'
    2:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-columns-count-3-ce.png
        title: '列数设为 48。'

scada-minimum-layout-width-1:
      0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-minimum-layout-width-1-ce.png
        title: '默认最小列数为 24。您可增加或减少该值。最小列数为 10。建议该设置值大于或等于列数值；'
      1:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-minimum-layout-width-2-ce.png
        title: '最小列数设为 24。'

scada-background-color-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-background-color-1-ce.png
        title: '要更改背景色，请点击背景色区域右侧小方块中的颜色。在弹出窗口中选择颜色和透明度，然后点击 "Select"；'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-background-color-2-ce.png
        title: '保存更改后，您将看到背景色已改变。'

scada-background-image-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-background-image-1-ce.png
        title: '要从图库选择图片，点击 "Browse from gallery"；'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-background-image-2-ce.png
        title: '选择已上传的图片或添加新图片；'
    2:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-background-image-3-ce.png
        title: '要更精确调整图片位置，点击 "Background size mode" 区域的下拉菜单，选择图片如何填充背景空间；'
    3:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-background-image-4-ce.png
        title: '查看背景如何变化。'

multi-state-scada-dashboard-example-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/multi-state-dashboards-1-ce.png
        title: '点击特定 SCADA 元素将执行自定义操作。不妨一试。'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/multi-state-dashboards-2-ce.png
        title: ''
    2:
        image: /images/user-guide/scada/scada-dashboards/ce/multi-state-dashboards-3-ce.png
        title: ''
    3:
        image: /images/user-guide/scada/scada-dashboards/ce/multi-state-dashboards-4-ce.png
        title: ''

high-performance-scada-symbols:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/high-performance-scada-symbols-1-ce.png
        title: '高性能 SCADA dashboard。'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/high-performance-scada-symbols-2-ce.png
        title: '传统 SCADA dashboard。'

add-scada-symbol-widget-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/add-scada-symbol-widget-1-ce.png
        title: '在 dashboard 编辑模式下，点击屏幕顶部的 "+ Add widget" 图标，或（若为本 dashboard 上的首个部件）点击屏幕中央的 "Add new widget" 大按钮，打开 Select widgets bundle 对话框；'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/add-scada-symbol-widget-2-ce.png
        title: '找到 "SCADA fluid system" 部件包并点击；'
    2:
        image: /images/user-guide/scada/scada-dashboards/ce/add-scada-symbol-widget-3-ce.png
        title: '选择 "Horizontal wheel valve" 部件。'

scada-selected-target-device-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-selected-target-device-1-ce.png
        title: '指定单个实体：device、asset 等。若无需交互行为，可省略目标实体参数。'

scada-symbol-device-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-symbol-device-1-ce.png
        title: '指向库中的特定 SCADA symbol。'

scada-behavior-settings-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-behavior-settings-1-ce.png
        title: '行为参数列表由所选 SCADA symbol 决定，完全由 symbol 作者控制。'

scada-action-do-nothing-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-do-nothing-1-ce.png
        title: '"Do nothing" action 仅使用用户定义的常量。'

scada-action-execute-rpc-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-execute-rpc-1-ce.png
        title: '"Execute RPC" action 会向目标 device 发送命令以获取值。该值在创建部件时解析一次。'

scada-action-get-attribute-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-get-attribute-1-ce.png
        title: '"Get attribute" action 将订阅目标实体属性的值。属性值变更时部件会收到更新。'

scada-action-get-time-series-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-get-time-series-1-ce.png
        title: '"Get time series" action 将订阅目标实体的 time series 字段值。新 time series 数据到达时部件会收到更新。'

scada-action-get-alarm-status-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-get-alarm-status-1-ce.png
        title: '"Get alarm status" action 订阅 alarm 状态字段。部件会根据 alarm 类型收到更新。'

scada-action-get-dashboard-state-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-get-dashboard-state-1-ce.png
        title: '"Get dashboard state" action 使用当前 dashboard 状态的名称。适用于与目标 device 状态无关的特定场景。'

scada-action-left-motor-pump-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-left-motor-pump-1-ce.png
        title: '"On click" action 参数定义用户点击组件时触发的操作。'

scada-action-execute-rpc-to-target-device-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-execute-rpc-to-target-device-1-ce.png
        title: '"Execute RPC" action 会向目标 device 发送命令。您可定义方法及参数。'

scada-action-set-attribute-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-set-attribute-1-ce.png
        title: '"Set attribute" action 会向目标 device 发送命令。您可定义要设置的 attribute 的 scope、key 和 value。'

scada-action-add-time-series-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-action-add-time-series-1-ce.png
        title: '"Add time series" action 会向目标 device 添加新的 time series 值。您可定义新 time series 数据的 key 和 value。'

example-of-parameters-scada-symbol-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/example-of-parameters-scada-symbol-1-ce.png
        title: '首个参数 "Opened" 控制 SCADA symbol "Horizontal Wheel Valve" 的视觉表现，通常根据 device 的 attribute 或 time series 值动态变化。对于本阀门，该参数决定阀门为 "Open" 还是 "Closed"；'
    1:
        image: /images/user-guide/scada/scada-dashboards/ce/example-of-parameters-scada-symbol-2-ce.png
        title: '"Open" action 将 "open" attribute 设为 "true"；'
    2:
        image: /images/user-guide/scada/scada-dashboards/ce/example-of-parameters-scada-symbol-3-ce.png
        title: '"Close" action 将 "open" attribute 设为 "false"。'

scada-appearance-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-appearance-1-ce.png
        title: '所有 SCADA symbol 均有通用外观参数（如 symbol 标题和图标）。其他参数由所选 SCADA symbol 决定，由 symbol 作者控制。'

scada-card-appearance-1:
    0:
        image: /images/user-guide/scada/scada-dashboards/ce/scada-card-appearance-1-ce.png
        title: 'Card 外观设置为所有 SCADA symbol 通用，包括背景（默认透明）、启用的 card 按钮列表、card 圆角和内边距等参数。'


---

{% include docs/user-guide/scada.md %}