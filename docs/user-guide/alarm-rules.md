---
layout: docwithnav
assignees:
- stitenko
title: 告警规则
description: 创建告警规则

step-1-add-alarm-rule-1:
    0:
        image: /images/user-guide/alarm-rules/step-1-add-alarm-rule-1-ce.png
        title: '在左侧菜单中打开 <b>Alarms</b> 页面，进入 <b>Alarm rules</b> 选项卡。<br>该页面可集中管理系统中的所有告警规则（适用于单个实体和 profile）。'

step-1-add-alarm-rule-2:
    0:
        image: /images/user-guide/alarm-rules/step-1-add-alarm-rule-2-ce.png
        title: '- 进入 <b>Alarms</b> 页面 &#8702; <b>Alarm rules</b> 选项卡。<br>- 点击右上角「<b>+</b>」按钮，在下拉菜单中选择 <b>Create new alarm rule</b>。'

step-2-general-section-1:
    0:
        image: /images/user-guide/alarm-rules/step-2-general-section-1-ce.png
        title: '指定 <b>alarm type</b> — 告警的名称和唯一标识符。<br>- 设置 <b>entity type</b> — 告警规则将应用的目标实体或 entity profile。'

step-3-arguments-1:
    0:
        image: /images/user-guide/alarm-rules/step-3-arguments-1-ce.png
        title: '定义告警条件前，需至少添加一个 <b>argument</b> — 规则评估时使用的数据源。点击 <b>Add argument</b> 并配置以下参数。'

step-3-arguments-2:
    0:
        image: /images/user-guide/alarm-rules/step-3-arguments-2-ce.png
        title: '<b>Entity type</b> 定义 argument 值的来源。'

step-3-arguments-3:
    0:
        image: /images/user-guide/alarm-rules/step-3-arguments-3-ce.png
        title: '<b>Argument type</b> 定义 argument 所代表的数据类型。'

step-3-arguments-4:
    0:
        image: /images/user-guide/alarm-rules/step-3-arguments-4-ce.png
        title: '<b>Argument name</b> — 在公式和条件中使用的标识符。<br>配置完成后点击 <b>Add</b>。'
    1:
        image: /images/user-guide/alarm-rules/step-3-arguments-5-ce.png

step-4-creation-conditions-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-creation-conditions-1-ce.png
        title: '本步骤定义告警规则的核心逻辑。<br>点击 <b>Add trigger condition</b> 并配置以下参数。'

step-4-creation-conditions-severity-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-creation-conditions-severity-1-ce.png
        title: '<b>Severity</b> 定义告警创建时的严重程度。<br>影响事件优先级、界面展示及自动化流程（Rule Engine、通知规则等）。'

step-4-creation-condition-add-filter-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-1-ce.png
        title: '点击 <b>Add condition</b>。'
    1:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-2-ce.png
        title: '通过定义一个或多个 filter 配置告警触发逻辑。点击 <b>Add argument filter</b>。'
    2:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-3-ce.png
        title: '<b>General configuration</b>：<br>- <b>Argument</b> — 要比较的变量（如 temperature）。<br>- <b>Value type</b> — 评估值的数据类型（Numeric、Boolean、String 等）。'
    3:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-4-ce.png
        title: '<b>Configure filters</b>：<br>- <b>Operation</b> — 比较运算符。<br>- <b>Value source</b> — 选择以下之一。<br>- <b>Value</b> — 指定要比较的值。<br>- 添加所有需要的 filter 后点击 <b>Add</b> 保存条件。'
    4:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-5-ce.png

step-4-creation-condition-types-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-types-1-ce.png
        title: 'ThingsBoard 支持三种条件类型：<br>- <b>Simple.</b> 表达式为真时立即触发。<br>- <b>Duration.</b> 条件需连续满足指定时长。<br>- <b>Repeating.</b> 条件发生指定次数后才触发。'

step-4-schedule-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-schedule-1-ce.png
        title: '<b>Schedule</b> 定义告警创建规则的生效时间段。系统仅在当前时间处于允许区间内时才评估创建条件。'
    1:
        image: /images/user-guide/alarm-rules/step-4-schedule-2-ce.png
        title: '若创建条件在 <b>定义的时间段之外</b> 为真，告警 <b>不会创建</b> — 即使逻辑表达式为真。'

step-4-schedule-types-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-schedule-types-1-ce.png
        title: '<b>Active all time</b> — 始终生效'
    1:
        image: /images/user-guide/alarm-rules/step-4-schedule-types-2-ce.png
        title: '<b>Active at a specific time range</b> <i>示例：</i> 周一至周五 09:00–18:00'
    2:
        image: /images/user-guide/alarm-rules/step-4-schedule-types-3-ce.png
        title: '<b>Custom schedule</b> — 为每周每天定义不同时间区间'
  
step-4-schedule-dynamic-mode-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-schedule-dynamic-mode-1-ce.png
        title: '<b>Dynamic mode</b><br>不手动配置 schedule，可通过 attribute 或 telemetry 提供 JSON 对象。适用于不同设备或 Customer 需要不同 schedule 的场景。'

step-5-clear-conditions-1:
    0:
        image: /images/user-guide/alarm-rules/step-5-clear-conditions-1-ce.png
        title: '点击 <b>Add clear condition</b>。'

step-5-clearing-condition-add-filter-1:
    0:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-1-ce.png
        title: '点击 <b>Add condition</b>。'
    1:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-2-ce.png
        title: '通过定义一个或多个 filter 配置告警清除逻辑。点击 <b>Add argument filter</b>。'
    2:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-3-ce.png
        title: '- <b>Argument</b> — 要比较的变量（如 temperature）<br>- <b>Value type</b> — 评估值的数据类型（Numeric、Boolean、String 等）'
    3:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-4-ce.png
        title: '<b>Configure filters</b>。<br>- <b>Operation</b> — 比较运算符。<br>- <b>Value source</b> — 选择以下之一。<br>- <b>Value</b> — 指定要比较的值<br>- 添加所有需要的 filter 后点击 <b>Add</b> 保存条件。'

step-5-clearing-condition-types-1:
    0:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-5-ce.png
        title: 'ThingsBoard 支持三种条件类型：<br>- <b>Simple.</b> 条件为真时立即清除。<br>- <b>Duration.</b> 需持续满足指定时长才清除。<br>- <b>Repeating.</b> 条件满足指定次数后才清除。'

step-5-schedule-1:
    0:
        image: /images/user-guide/alarm-rules/step-5-schedule-1-ce.png
        title: '<b>clear schedule</b> 定义清除条件 <i>何时</i> 允许触发。'
    1:
        image: /images/user-guide/alarm-rules/step-5-schedule-2-ce.png
        title: '示例场景：<br>- 仅在工作时间允许自动清除<br>- 仅在夜间允许清除<br>- 限定在特定时间段内才能清除'

step-6-propagate-alarm-1:
    0:
        image: /images/user-guide/alarm-rules/step-6-propagate-alarm-1-ce.png
        title: '<b>Propagate alarm to related entities</b>。<br>启用后，告警对 originator 的所有相关实体可见，与关系类型无关。'

step-6-propagate-alarm-2:
    0:
        image: /images/user-guide/alarm-rules/step-6-propagate-alarm-2-ce.png
        title: '<b>Propagate alarm to the owner (Customer / Tenant)</b>。<br>使告警对 originator 的直接所有者（Customer 或 Tenant）可见。'

step-6-propagate-alarm-4:
    0:
        image: /images/user-guide/alarm-rules/step-6-propagate-alarm-3-ce.png
        title: '<b>Propagate alarm to Tenant</b>。<br>使告警在 Tenant 级别可见，与所有权或关系无关。'

step-7-save-rule-1:
    0:
        image: /images/user-guide/alarm-rules/step-7-save-rule-1-ce.png
        title: '点击 <b>Add</b> 保存规则配置。'
    1:
        image: /images/user-guide/alarm-rules/step-7-save-rule-2-ce.png
        title: '保存后，ThingsBoard 将根据您定义的条件、schedule 和传播设置自动创建、更新和处理告警。'

alarm-rules-parameters-1:
    0:
        image: /images/user-guide/alarm-rules/alarm-rules-parameters-1-ce.png
        title: '在 Alarm rules 列表中管理告警规则。'

alarm-rules-parameters-2:
    0:
        image: /images/user-guide/alarm-rules/alarm-rules-parameters-2-ce.png
        title: '点击告警规则可查看其详细信息。'

alarm-rules-parameters-3:
    0:
        image: /images/user-guide/alarm-rules/alarm-rules-parameters-3-ce.png
        title: '要修改告警规则，点击该规则打开告警规则详情窗口。<br>点击 <b>橙色铅笔</b> 图标切换到 <b>edit mode</b>。'
    1:
        image: /images/user-guide/alarm-rules/alarm-rules-parameters-4-ce.png
        title: '完成修改后，点击 <b>橙色对勾</b> 图标应用并保存更改。'

export-alarm-rule-1:
    0:
        image: /images/user-guide/alarm-rules/export-alarm-rule-1-ce.png
        title: '进入 <b>Alarms</b> 页面 &#8702; <b>Alarm rules</b> 选项卡。<br>在对应告警规则行中点击 <b>Export</b> 按钮。'

import-alarm-rule-1:
    0:
        image: /images/user-guide/alarm-rules/import-alarm-rule-1-ce.png
        title: '- 进入 <b>Alarms</b> 页面 &#8702; <b>Alarm rules</b> 选项卡。<br>- 点击右上角「<b>+</b>」按钮，在下拉菜单中选择 <b>Import alarm rule</b>。'
    1:
        image: /images/user-guide/alarm-rules/import-alarm-rule-2-ce.png
        title: '- 在导入对话框中拖放 JSON 文件或手动选择。<br>- 点击 <b>Import</b> 上传配置。'
    2:
        image: /images/user-guide/alarm-rules/import-alarm-rule-3-ce.png
        title: '- 为导入的告警规则指定 <b>目标 profile 或实体</b>。<br>- 最后点击 <b>Add</b> 保存规则。'

alarm-rules-example-prepare-device-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-prepare-device-1-ce.png
        title: '创建名为 <b>Thermometer</b> 的设备，用于发送温度 telemetry。'
  
alarm-rules-example-simple-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-1-ce.png
        title: '进入 <b>Alarms</b> 下的 <b>Alarm rules</b> 页面。<br>点击右上角「<b>+</b>」按钮，在下拉菜单中选择 <b>Create new alarm rule</b>。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-2-ce.png
        title: '在 <b>General</b> 部分：<br>- 将 <b>Alarm type</b> 设为 <i>High temperature</i>。<br>- 选择 <b>Target entity type</b>：<i>Device</i>。<br>- 指定 <b>target device</b>：<i>Thermometer</i>。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-3-ce.png
        title: '在 <b>Arguments</b> 部分添加新 argument。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-4-ce.png
        title: '在 <b>Trigger conditions</b> 部分点击 <b>Add trigger condition</b>。'
    4:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-5-ce.png
        title: '- <b>Severity:</b> Critical<br>- 点击 <b>Add condition</b>。'
    5:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-6-ce.png
        title: '点击 <b>Add argument filter</b>。'
    6:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-7-ce.png
        title: '<b>Argument:</b> temperature；<b>Value type:</b> Numeric；<b>Operation:</b> greater than；<b>Static value:</b> 10。'
    7:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-8-ce.png
        title: '<b>Condition type:</b> Simple。点击 <b>Save</b>。'
    8:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-9-ce.png
        title: '点击 <b>Add</b>。'
    9:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-10-ce.png
        title: '规则将在温度超过 <b>10°C</b> 时立即创建 <b>critical</b> 告警。'

alarm-rule-example-clear-condition-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-1-ce.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-2-ce.png
        title: '滚动到 <b>Clear condition</b> 部分，点击 <b>Add clear condition</b>。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-3-ce.png
        title: '点击 <b>Add condition</b>。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-4-ce.png
        title: '点击 <b>Add argument filter</b>。'
    4:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-5-ce.png
        title: '<b>Argument:</b> temperature；<b>Value type:</b> Numeric；<b>Operation:</b> less or equal；<b>Static value:</b> 4。<br>点击 <b>Add</b>。'
    5:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-6-ce.png
        title: '点击 <b>Save</b>。'
    6:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-7-ce.png
        title: '应用更改。'

alarm-rules-example-condition-duration-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-duration-1-ce.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-duration-2-ce.png
        title: '滚动到 <b>Trigger condition</b> 部分，编辑现有条件。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-duration-3-ce.png
        title: '<b>Condition type:</b> Duration；<b>Duration value:</b> 1 minute。<br>点击 <b>Save</b>。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-duration-4-ce.png
        title: '应用更改。'

alarm-rules-example-condition-with-dynamic-duration-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-1-ce.png
        title: '为 <b>Thermometer</b> 设备添加 <b>highTemperatureDurationThreshold</b> server attribute。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-2-ce.png
        title: '该值将作为告警规则的 duration 要求被使用。'

alarm-rules-example-condition-with-dynamic-duration-2:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-3-ce.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-4-ce.png
        title: '在 <b>Arguments</b> 部分添加将用于 <b>Duration</b> 条件的新 argument。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-5-ce.png
        title: '滚动到 <b>Trigger condition</b> 部分，编辑现有条件。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-6-ce.png
        title: '<b>Condition type:</b> Duration；<b>Dynamic value:</b> <b>Argument</b> highTemperatureDurationThreshold；<b>Time unit:</b> minutes。<br>点击 <b>Save</b>。'
    4:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-7-ce.png
        title: '应用更改。'

alarm-rules-example-condition-repeating-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-repeating-1-ce.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-repeating-2-ce.png
        title: '滚动到 <b>Trigger condition</b> 部分，编辑现有条件。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-repeating-3-ce.png
        title: 'Condition type：「<b>Repeating</b>」。<b>Count of events</b>：3。保存条件。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-repeating-4-ce.png
        title: '应用更改。'

alarm-rules-example-schedule-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-schedule-1-ce.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-schedule-2-ce.png
        title: '打开告警 trigger condition 的 schedule 设置。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-schedule-3-ce.png
        title: '选择 schedule type：<i>Active at a specific time</i>。<br>将规则配置为仅在工作日 10:00 至 19:00 生效。点击 <b>Save</b>。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-schedule-4-ce.png
        title: '应用更改。'

alarm-rules-example-advanced-thresholds-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-1-ce.png
        title: '为 <b>Thermometer</b> 设备添加 <b>temperatureAlarmFlag</b> <i>server attribute</i>。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-2-ce.png
        title: '该 attribute 决定告警规则对该设备是否生效。'

alarm-rules-example-advanced-thresholds-2:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-3-ce.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-4-ce.png
        title: '在 <b>Arguments</b> 部分添加将用于 <b>creation</b> 条件的新 argument。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-5-ce.png
        title: '滚动到 <b>Trigger condition</b> 部分，编辑现有条件。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-6-ce.png
        title: '点击 <b>Add argument filter</b>。'
    4:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-7-ce.png
        title: '<b>Argument:</b> <i>temperatureAlarmFlag</i>；<b>Value type:</b> <i>Boolean</i>；<b>Operation:</b> <i>equal</i>；<b>Static value:</b> <i>True</i>。<br>点击 <b>Add</b>。'
    5:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-8-ce.png
        title: '点击 <b>Save</b>。'
    6:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-9-ce.png
        title: '应用更改。'

---

{% include get-hosts-name.html %}
{% include docs/user-guide/alarm-rules.md %}