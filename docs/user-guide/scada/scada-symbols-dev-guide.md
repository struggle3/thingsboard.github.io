---
layout: docwithnav
assignees:
- ashvayka
title: SCADA symbols 开发指南
description: SCADA 符号开发指南

upload-svg-file-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/upload-svg-file-1-ce.png
        title: '进入 "SCADA symbols" 的 "Resources" 页面，点击 "Upload SCADA symbol" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/upload-svg-file-2-ce.png
        title: '将 "fan.svg" 文件拖入相应区域，或从电脑文件夹上传，重命名为 "Fan"，点击 "Upload"。'

explore-scada-editor-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/explore-scada-editor-1-ce.png
        title: 'SCADA symbol 编辑器分为两栏：左侧显示已上传的 SVG 文件，右侧包含 "General"、"Tags"、"Behavior"、"Properties" 等标签。'

explore-scada-editor-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/explore-scada-editor-2-ce.png
        title: '填写描述和搜索标签，然后点击 "Apply"。'

scada-editor-actions-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/scada-editor-actions-1-ce.png
        title: '填写描述和搜索标签，然后点击 "Apply"。'

scada-editor-actions-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/scada-editor-actions-2-ce.png
        title: 'SCADA 编辑器操作。'

widget-size-and-aspect-ratio-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/widget-size-and-aspect-ratio-1-ce.png
        title: '"Widget size" 设置影响部件的宽高比，理想情况下应与 SVG 的宽高比一致。'

tags-definition-via-editor-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/tags-definition-via-editor-1-ce.png
        title: '进入 "Tags" 标签。在编辑器左侧点击目标 SVG 元素，点击 "+Add tag" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/tags-definition-via-editor-2-ce.png
        title: '输入 tag 名称并点击 "Apply" 图标；'
    2:
        image: /images/user-guide/scada/symbols-dev-guide/tags-definition-via-editor-3-ce.png
        title: 'Tag 已添加；'
    3:
        image: /images/user-guide/scada/symbols-dev-guide/tags-definition-via-editor-4-ce.png
        title: '定义其他所有 tag。'

operations-with-tag-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/operations-with-tag-1-ce.png
        title: '将鼠标悬停在 tag 上，点击 "Update tag" 图标；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/operations-with-tag-2-ce.png
        title: '修改 tag 名称并点击 "Apply"。'

operations-with-tag-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/operations-with-tag-3-ce.png
        title: '将鼠标悬停在 tag 上，点击 "Tag settings" 图标；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/operations-with-tag-4-ce.png
        title: '弹出菜单中可为每个 tag 分配两类函数："State render function" 和 "On click action"。我们将在 "Tag configuration" 小节中详细说明。'

operations-with-tag-3:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/operations-with-tag-5-ce.png
        title: '将鼠标悬停在 tag 上，点击 "Remove tag" 图标；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/operations-with-tag-6-ce.png
        title: '在对话框中确认删除 tag。'

add-tags-to-on-button-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-tags-to-on-button-1-ce.png
        title: '切换到 "XML" 编辑器模式，按截图所示选中 XML 代码；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-tags-to-on-button-2-ce.png
        title: '粘贴从文档复制的 XML 代码；'
    2:
        image: /images/user-guide/scada/symbols-dev-guide/add-tags-to-on-button-3-ce.png
        title: '返回 "SVG" 编辑器模式。您将看到 tag 已添加到 "On" 按钮元素。'

tags-definition-via-xml-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/tags-definition-via-xml-1-ce.png
        title: '进入 "XML" 编辑器模式；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/tags-definition-via-xml-2-ce.png
        title: '在对应窗口中添加 XML 代码；'
    2:
        image: /images/user-guide/scada/symbols-dev-guide/tags-definition-via-xml-3-ce.png
        title: '返回 "SVG" 编辑器模式。您可看到已定义的 tag。随后应用更改。'

behavior-scada-developer-end-user-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/behavior-scada-developer-end-user-configuration-1-ce.png
        title: 'SCADA 开发者配置的行为项列表；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/behavior-scada-developer-end-user-configuration-2-ce.png
        title: '最终用户部件配置中的元素列表。'

add-behavior-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-behavior-1-ce.png
        title: '进入 "Behavior" 标签，点击 "Add behavior" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-behavior-2-ce.png
        title: '填写必填字段并点击 "Add"。'

types-of-behavior-parameters-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/types-of-behavior-parameters-1-ce.png
        title: '行为参数列表由所选 SCADA symbol 决定，完全由 symbol 作者控制。行为参数有三种类型："Value"、"Action" 和 "Widget action"。'

five-types-of-actions-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/five-types-of-actions-1-ce.png
        title: '"Do nothing" action 类型使用用户定义的常量。'

five-types-of-actions-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/five-types-of-actions-2-ce.png
        title: '"Execute RPC" action 类型向目标 device 发送命令以获取值。该值在创建部件时解析一次。'

five-types-of-actions-3:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/five-types-of-actions-3-ce.png
        title: '"Get attribute" action 类型订阅目标实体的 attribute 值，attribute 变更时部件会更新。'

five-types-of-actions-4:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/five-types-of-actions-4-ce.png
        title: '"Get time series" action 类型订阅目标实体的 time series 字段，新数据到达时部件会更新。'

five-types-of-actions-5:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/five-types-of-actions-5-ce.png
        title: '"Get alarm status" action 类型订阅目标实体的 alarm 状态字段，根据 alarm 类型更新部件状态。'

five-types-of-actions-6:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/five-types-of-actions-6-ce.png
        title: '"Get dashboard state" action 类型使用当前 dashboard 状态的名称，适用于与 device 状态无关的特定场景。'

value-types-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/value-types-1-ce.png
        title: '"Value" 和 "Action" 行为项有多种类型，包括 "String"、"Integer"、"Double"、"Boolean" 和 "JSON"。每种类型有各自的配置参数。'

add-fan-on-behavior-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-fan-on-behavior-1-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-fan-on-behavior-2-ce.png
        title: ''
    2:
        image: /images/user-guide/scada/symbols-dev-guide/add-fan-on-behavior-3-ce.png
        title: ''

add-fan-speed-behavior-1:
  0:
        image: /images/user-guide/scada/symbols-dev-guide/add-fan-speed-behavior-1-ce.png
        title: ''
  1:
        image: /images/user-guide/scada/symbols-dev-guide/add-fan-speed-behavior-2-ce.png
        title: ''

three-types-of-actions-for-interacting-with-target-entity-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/three-types-of-actions-for-interacting-with-target-entity-1-ce.png
        title: ''

three-types-of-actions-for-interacting-with-target-entity-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/three-types-of-actions-for-interacting-with-target-entity-2-ce.png
        title: ''

three-types-of-actions-for-interacting-with-target-entity-3:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/three-types-of-actions-for-interacting-with-target-entity-3-ce.png
        title: ''

widget-action-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/widget-action-1-ce.png
        title: 'Widget action 行为项用于触发与当前 dashboard 部件相关的操作，而非目标 device。可能的 widget action 详见 "Widget Actions" 文档。'

add-on-btn-click-behavior-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-on-btn-click-behavior-1-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-on-btn-click-behavior-2-ce.png
        title: ''

add-off-btn-click-behavior-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-off-btn-click-behavior-1-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-off-btn-click-behavior-2-ce.png
        title: ''

widget-action-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/widget-action-2-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/widget-action-3-ce.png
        title: ''

properties-scada-developer-end-user-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/properties-scada-developer-end-user-configuration-1-ce.png
        title: 'SCADA 开发者配置的 property 列表；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/properties-scada-developer-end-user-configuration-2-ce.png
        title: '最终用户部件配置中的 property 列表。'

add-properties-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-properties-1-ce.png
        title: '进入 "Property" 标签，点击 "Add property" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-properties-2-ce.png
        title: '填写必填字段并点击 "Add"。'
  
add-on-btn-label-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-on-btn-label-1-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-on-btn-label-2-ce.png
        title: ''

add-on-btn-color-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-on-btn-color-1-ce.png
        title: ''

add-on-btn-disabled-color-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-on-btn-disabled-color-1-ce.png
        title: ''

add-off-btn-label-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-off-btn-label-1-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-off-btn-label-2-ce.png
        title: ''

add-off-btn-color-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-off-btn-color-1-ce.png
        title: ''
  
add-off-btn-disabled-color-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-off-btn-disabled-color-1-ce.png
        title: ''
  
add-fan-on-color-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-fan-on-color-1-ce.png
        title: ''
  
add-fan-off-color-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-fan-off-color-1-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/add-fan-off-color-2-ce.png
        title: ''

add-show-rotation-speed-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-show-rotation-speed-1-ce.png
        title: ''
  
add-rotation-speed-unit-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-rotation-speed-unit-1-ce.png
        title: ''

add-rotation-speed-font-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-rotation-speed-font-1-ce.png
        title: ''

add-rotation-speed-color-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/add-rotation-speed-color-1-ce.png
        title: ''

configured-properties-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/configured-properties-1-ce.png
        title: '已配置的 property 列表应如上所示。'

state-render-function-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/state-render-function-1-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/state-render-function-2-ce.png
        title: ''

on-click-action-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/on-click-action-1-ce.png
        title: ''
    1:
        image: /images/user-guide/scada/symbols-dev-guide/on-click-action-2-ce.png
        title: ''

on-button-text-tag-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/on-button-text-tag-configuration-1-ce.png
        title: '进入 "onButtonText" tag 的 "Tag settings"，点击 "State rendering function" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/on-button-text-tag-configuration-2-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'


off-button-text-tag-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/off-button-text-tag-configuration-1-ce.png
        title: '进入 "offButtonText" tag 的 "Tag settings"，点击 "State rendering function" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/off-button-text-tag-configuration-2-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

on-button-background-tag-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/on-button-background-tag-configuration-1-ce.png
        title: '进入 "onButtonBackground" tag 的 "Tag settings"，点击 "State rendering function" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/on-button-background-tag-configuration-2-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

off-button-background-tag-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/off-button-background-tag-configuration-1-ce.png
        title: '进入 "offButtonBackground" tag 的 "Tag settings"，点击 "State rendering function" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/off-button-background-tag-configuration-2-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

on-button-tag-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/on-button-tag-configuration-1-ce.png
        title: '进入 "onButton" tag 的 "Tag settings"，点击 "State rendering function" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/on-button-tag-configuration-2-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

on-button-tag-configuration-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/on-button-tag-configuration-3-ce.png
        title: '进入 "onButton" tag 的 "Tag settings"，点击 "On click action" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/on-button-tag-configuration-4-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

off-button-tag-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/off-button-tag-configuration-1-ce.png
        title: '进入 "offButton" tag 的 "Tag settings"，点击 "State rendering function" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/off-button-tag-configuration-2-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

off-button-tag-configuration-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/off-button-tag-configuration-3-ce.png
        title: '进入 "offButton" tag 的 "Tag settings"，点击 "On click action" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/off-button-tag-configuration-4-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

rotation-speed-text-tag-configuration-1:
    0:
      image: /images/user-guide/scada/symbols-dev-guide/rotation-speed-text-tag-configuration-1-ce.png
      title: '进入 "rotationSpeedText" tag 的 "Tag settings"，点击 "State rendering function" 的 "+ Add" 按钮；'
    1:
      image: /images/user-guide/scada/symbols-dev-guide/rotation-speed-text-tag-configuration-2-ce.png
      title: 'Paste the previously copied function from the documentation into the appropriate window. Click "Apply".'

fan-tag-configuration-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/fan-tag-configuration-1-ce.png
        title: '进入 "fan" tag 的 "Tag settings"，点击 "State rendering function" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/fan-tag-configuration-2-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

fan-tag-configuration-2:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/fan-tag-configuration-3-ce.png
        title: '进入 "fan" tag 的 "Tag settings"，点击 "On click action" 的 "+ Add" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/fan-tag-configuration-4-ce.png
        title: '将文档中复制的函数粘贴到相应窗口。点击 "Apply"。'

preview-mode-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/preview-mode-1-ce.png
        title: '要进入预览模式，点击窗口右侧的 "Preview" 按钮；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/preview-mode-2-ce.png
        title: 'SVG 显示在左侧面板，部件配置显示在右侧。测试部件行为：按下绿色 "On" 按钮；'
    2:
        image: /images/user-guide/scada/symbols-dev-guide/preview-mode-3-ce.png
        title: '按钮颜色应变灰，风扇会由红变绿并开始旋转。风扇下方将显示 RPM。此时 "Off" 按钮将激活并由灰变红。点击它；'
    3:
        image: /images/user-guide/scada/symbols-dev-guide/preview-mode-4-ce.png
        title: '风扇应停止，"Off" 按钮将再次不可点击，颜色恢复为灰色。'

create-widget-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/create-widget-1-ce.png
        title: '点击右上角的 "Create widget" 按钮。'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/create-widget-2-ce.png
        title: '在新窗口中输入部件名称，指定已有 widget bundle 或创建新的。我们将创建新的。输入名称后点击 "Create new widget bundle"；'
    2:
        image: /images/user-guide/scada/symbols-dev-guide/create-widget-3-ce.png
        title: '（可选）为 widget bundle 添加预览图片并点击 "Add"；'
    3:
        image: /images/user-guide/scada/symbols-dev-guide/create-widget-4-ce.png
        title: '点击 "Create" 按钮确认创建部件。'

test-widget-on-dashboard-1:
    0:
        image: /images/user-guide/scada/symbols-dev-guide/test-widget-on-dashboard-1-ce.png
        title: '创建并打开新 dashboard。进入 "Layouts" 面板，将 layout 从 "Default" 改为 "SCADA"。点击 "Save"；'
    1:
        image: /images/user-guide/scada/symbols-dev-guide/test-widget-on-dashboard-2-ce.png
        title: '点击屏幕顶部的 "Add widget" 按钮或中央的 "Add new widget" 大图标；'
    2:
        image: /images/user-guide/scada/symbols-dev-guide/test-widget-on-dashboard-3-ce.png
        title: '找到 "My SCADA widgets" widget bundle 并点击；'
    3:
        image: /images/user-guide/scada/symbols-dev-guide/test-widget-on-dashboard-4-ce.png
        title: '点击 "Fan" 部件以将其添加到 dashboard；'
    4:
        image: /images/user-guide/scada/symbols-dev-guide/test-widget-on-dashboard-5-ce.png
        title: '指定目标 device（使用任意 device），点击 "Add"；'
    5:
        image: /images/user-guide/scada/symbols-dev-guide/test-widget-on-dashboard-6-ce.png
        title: '部件已添加。点击 "Save" 保存 dashboard 更改；'
    6:
        image: /images/user-guide/scada/symbols-dev-guide/test-widget-on-dashboard-7-ce.png
        title: '点击绿色 "On" 按钮。按钮将不可点击、颜色变灰，风扇由红变绿并开始旋转，RPM 显示在下方；'
    7:
        image: /images/user-guide/scada/symbols-dev-guide/test-widget-on-dashboard-8-ce.png
        title: 'Meanwhile, the "Off" button will become active and change its color from gray to red. Press it. The fan should stop, the “Off” button will become unclickable, and its color will turn gray again.'

download-scada-symbol-1:
  0:
    image: /images/user-guide/scada/symbols-dev-guide/download-scada-symbol-1-ce.png
    title: '您可下载包含所有设置的 SCADA symbol。点击 SCADA symbol 编辑器左侧的 "Download SCADA symbol" 按钮。SVG 文件将保存到您的电脑。'

---

{% include docs/user-guide/scada/scada-symbols-dev-guide.md %}