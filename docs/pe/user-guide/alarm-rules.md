---
layout: docwithnav-pe
assignees:
- stitenko
title: 告警规则
description: 创建告警规则

step-1-add-alarm-rule-1:
    0:
        image: /images/user-guide/alarm-rules/step-1-add-alarm-rule-1-pe.png
        title: '- 进入 <b>告警</b> 页面 &#8702; <b>告警规则</b> 选项卡。<br>- 点击右上角「<b>+</b>」按钮，在下拉菜单中选择 <b>创建新告警规则</b>。'

step-2-general-section-1:
    0:
        image: /images/user-guide/alarm-rules/step-2-general-section-1-pe.png
        title: '指定 <b>告警类型</b> — 告警的名称和唯一标识符。<br>- 设置 <b>实体类型</b> — 告警规则将应用的目标实体或实体档案。'

step-3-arguments-1:
    0:
        image: /images/user-guide/alarm-rules/step-3-arguments-1-pe.png
        title: '在定义告警条件前，需至少添加一个 <b>参数</b> — 规则评估时使用的数据源。点击 <b>添加参数</b> 并配置以下参数。'

step-3-arguments-2:
    0:
        image: /images/user-guide/alarm-rules/step-3-arguments-2-pe.png
        title: '<b>实体类型</b> 定义参数值的来源。'

step-3-arguments-3:
    0:
        image: /images/user-guide/alarm-rules/step-3-arguments-3-pe.png
        title: '<b>参数类型</b> 定义参数代表的数据类型。'

step-3-arguments-4:
    0:
        image: /images/user-guide/alarm-rules/step-3-arguments-4-pe.png
        title: '<b>参数名称</b> — 在公式和条件中使用的标识符。<br>配置完成后点击 <b>添加</b>。'
    1:
        image: /images/user-guide/alarm-rules/step-3-arguments-5-pe.png

step-4-creation-conditions-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-creation-conditions-1-pe.png
        title: '本步骤定义告警规则的核心逻辑。<br>点击 <b>添加触发条件</b> 并配置以下参数。'

step-4-creation-conditions-severity-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-creation-conditions-severity-1-pe.png
        title: '<b>严重级别</b> 定义告警创建时的紧急程度。<br>影响事件优先级、界面展示以及自动化流程（规则引擎、通知规则等）。'

step-4-creation-condition-add-filter-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-1-pe.png
        title: '点击 <b>添加条件</b>。'
    1:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-2-pe.png
        title: '通过定义一个或多个筛选器配置告警触发逻辑。点击 <b>添加参数筛选器</b>。'
    2:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-3-pe.png
        title: '<b>常规配置</b>：<br>- <b>参数</b> — 要比较的变量（如 temperature）。<br>- <b>值类型</b> — 被评估值的数据类型（数值、布尔、字符串等）。'
    3:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-4-pe.png
        title: '<b>配置筛选器</b>：<br>- <b>操作</b> — 比较运算符。<br>- <b>值来源</b> — 选择以下之一。<br>- <b>值</b> — 指定要比较的值。<br>- 添加所有需要的筛选器后点击 <b>添加</b> 保存条件。'
    4:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-add-filter-5-pe.png

step-4-creation-condition-types-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-creation-condition-types-1-pe.png
        title: 'ThingsBoard 支持三种条件类型：<br>- <b>简单。</b> 表达式为真时立即触发。<br>- <b>持续时间。</b> 条件需在指定时间段内持续为真。<br>- <b>重复。</b> 仅在条件满足指定次数后才触发。'

step-4-schedule-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-schedule-1-pe.png
        title: '<b>计划</b> 定义告警创建规则生效的时间段。系统仅在当前时间处于允许区间内时才评估创建条件。'
    1:
        image: /images/user-guide/alarm-rules/step-4-schedule-2-pe.png
        title: '若创建条件在 <b>定义的时间段之外</b> 为真，告警 <b>将不会创建</b> — 即使逻辑表达式为真。'

step-4-schedule-types-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-schedule-types-1-pe.png
        title: '<b>始终生效</b> — 无时间限制'
    1:
        image: /images/user-guide/alarm-rules/step-4-schedule-types-2-pe.png
        title: '<b>在特定时间段生效</b> <i>示例：</i> 周一至周五 09:00–18:00'
    2:
        image: /images/user-guide/alarm-rules/step-4-schedule-types-3-pe.png
        title: '<b>自定义计划</b> — 为每周每天定义不同的时间段'
  
step-4-schedule-dynamic-mode-1:
    0:
        image: /images/user-guide/alarm-rules/step-4-schedule-dynamic-mode-1-pe.png
        title: '<b>动态模式</b><br>无需手动配置计划，可通过属性或遥测提供 JSON 对象。当不同设备或客户需要不同计划时很有用。'

step-5-clear-conditions-1:
    0:
        image: /images/user-guide/alarm-rules/step-5-clear-conditions-1-pe.png
        title: '点击 <b>添加清除条件</b>。'

step-5-clearing-condition-add-filter-1:
    0:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-1-pe.png
        title: '点击 <b>添加条件</b>。'
    1:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-2-pe.png
        title: '通过定义一个或多个筛选器配置告警触发逻辑。点击 <b>添加参数筛选器</b>。'
    2:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-3-pe.png
        title: '- <b>参数</b> — 要比较的变量（如 temperature）<br>- <b>值类型</b> — 被评估值的数据类型（数值、布尔、字符串等）。'
    3:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-4-pe.png
        title: '<b>配置筛选器</b>。<br>- <b>操作</b> — 比较运算符。<br>- <b>值来源</b> — 选择以下之一。<br>- <b>值</b> — 指定要比较的值<br>- 添加所有需要的筛选器后点击 <b>添加</b> 保存条件。'

step-5-clearing-condition-types-1:
    0:
        image: /images/user-guide/alarm-rules/step-5-clearing-condition-add-filter-5-pe.png
        title: 'ThingsBoard 支持三种条件类型：<br>- <b>简单。</b> 条件为真时立即清除。<br>- <b>持续时间。</b> 需在指定时段内持续为真后才能清除。<br>- <b>重复。</b> 需满足指定次数后才能清除。'

step-5-schedule-1:
    0:
        image: /images/user-guide/alarm-rules/step-5-schedule-1-pe.png
        title: '<b>清除计划</b> 定义 <i>何时</i> 允许触发清除条件。'
    1:
        image: /images/user-guide/alarm-rules/step-5-schedule-2-pe.png
        title: '示例场景：<br>- 仅在工作时间内允许自动清除<br>- 仅允许在夜间清除<br>- 限制在特定时间段内清除。'

step-6-propagate-alarm-1:
    0:
        image: /images/user-guide/alarm-rules/step-6-propagate-alarm-1-pe.png
        title: '<b>向相关实体传播告警</b>。<br>启用后，告警对与 originator 相关的所有实体可见，无论关系类型如何。'

step-6-propagate-alarm-2:
    0:
        image: /images/user-guide/alarm-rules/step-6-propagate-alarm-2-pe.png
        title: '<b>向所有者（客户/租户）传播告警</b>。<br>使告警对 originator 的直接所有者可见 — 客户或租户。'

step-6-propagate-alarm-3:
    0:
        image: /images/user-guide/alarm-rules/step-6-propagate-alarm-3-pe.png
        title: '<b>向实体所有者层级传播告警</b>。<br>沿整个所有权链向上传播告警，确保在每个父级可见：<b>资产 &#8702; 客户 &#8702; 租户</b>。'

step-6-propagate-alarm-4:
    0:
        image: /images/user-guide/alarm-rules/step-6-propagate-alarm-4-pe.png
        title: '<b>向租户传播告警</b>。<br>使告警在租户级别可见，无论所有权或关系如何。'

step-7-save-rule-1:
    0:
        image: /images/user-guide/alarm-rules/step-7-save-rule-1-pe.png
        title: '点击 <b>添加</b> 保存规则配置。'
    1:
        image: /images/user-guide/alarm-rules/step-7-save-rule-2-pe.png
        title: '保存后，ThingsBoard 将根据您定义的条件、计划和传播设置自动创建、更新和处理告警。'

alarm-rules-parameters-1:
    0:
        image: /images/user-guide/alarm-rules/alarm-rules-parameters-1-pe.png
        title: '在告警规则列表中管理告警规则。'

alarm-rules-parameters-2:
    0:
        image: /images/user-guide/alarm-rules/alarm-rules-parameters-2-pe.png
        title: '点击告警规则查看其详细信息。'

alarm-rules-parameters-3:
    0:
        image: /images/user-guide/alarm-rules/alarm-rules-parameters-3-pe.png
        title: '要修改告警规则，点击规则。告警规则详情窗口将打开。<br>点击 <b>橙色铅笔</b> 图标切换到 <b>编辑模式</b>。'
    1:
        image: /images/user-guide/alarm-rules/alarm-rules-parameters-4-pe.png
        title: '完成所需修改后，点击 <b>橙色对勾</b> 图标应用并保存更改。'

export-alarm-rule-1:
    0:
        image: /images/user-guide/alarm-rules/export-alarm-rule-1-pe.png
        title: '进入 <b>告警</b> 页面 &#8702; <b>告警规则</b> 选项卡。<br>点击目标告警规则行中的 <b>导出</b> 按钮。'

import-alarm-rule-1:
    0:
        image: /images/user-guide/alarm-rules/import-alarm-rule-1-pe.png
        title: '- 进入 <b>告警</b> 页面 &#8702; <b>告警规则</b> 选项卡。<br>- 点击右上角「<b>+</b>」按钮，在下拉菜单中选择 <b>导入告警规则</b>。'
    1:
        image: /images/user-guide/alarm-rules/import-alarm-rule-2-pe.png
        title: '- 在导入对话框中拖放 JSON 文件或手动选择。<br>- 点击 <b>导入</b> 上传配置。'
    2:
        image: /images/user-guide/alarm-rules/import-alarm-rule-3-pe.png
        title: '- 为导入的告警规则指定 <b>目标档案或实体</b>。<br>- 最后点击 <b>添加</b> 保存规则。'

alarm-rules-example-prepare-device-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-prepare-device-1-pe.png
        title: '进入 <b>设备</b> 并从 CSV 文件 <b>导入设备配置</b>。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-prepare-device-2-pe.png
        title: '<b>时间序列：</b> temperature。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-prepare-device-3-pe.png
        title: '导入的 <b>Thermometer</b> 设备将 <b>temperature</b> 作为遥测数据发布。'

alarm-rules-example-simple-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-1-pe.png
        title: '进入 <b>告警</b> 下的 <b>告警规则</b> 页面。<br>点击右上角「<b>+</b>」按钮。在下拉菜单中选择 <b>创建新告警规则</b>。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-2-pe.png
        title: '在 <b>常规</b> 部分：<br>- 将 <b>告警类型</b> 设为 <i>High temperature</i>。<br>- 选择 <b>目标实体类型</b>：<i>设备</i>。<br>- 指定 <b>目标设备</b>：<i>Thermometer</i>。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-3-pe.png
        title: '在 <b>参数</b> 部分添加新参数。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-4-pe.png
        title: '在 <b>触发条件</b> 部分点击 <b>添加触发条件</b>。'
    4:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-5-pe.png
        title: '- <b>严重级别：</b> Critical<br>- 点击 <b>添加条件</b>。'
    5:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-6-pe.png
        title: '点击 <b>添加参数筛选器</b>。'
    6:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-7-pe.png
        title: '<b>参数：</b> temperature；<b>值类型：</b> 数值；<b>操作：</b> 大于；<b>静态值：</b> 10。'
    7:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-8-pe.png
        title: '<b>条件类型：</b> 简单。点击 <b>保存</b>。'
    8:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-9-pe.png
        title: '点击 <b>添加</b>。'
    9:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-simple-10-pe.png
        title: '结果：温度超过 <b>10°C</b> 时规则将立即创建 <b>critical</b> 告警。'

alarm-rule-example-clear-condition-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-1-pe.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-2-pe.png
        title: '向下滚动到 <b>清除条件</b> 部分。点击 <b>添加清除条件</b>。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-3-pe.png
        title: '点击 <b>添加条件</b>。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-4-pe.png
        title: '点击 <b>添加参数筛选器</b>。'
    4:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-5-pe.png
        title: '<b>参数：</b> temperature；<b>值类型：</b> 数值；<b>操作：</b> 小于或等于；<b>静态值：</b> 4。<br>点击 <b>添加</b>。'
    5:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-6-pe.png
        title: '点击 <b>保存</b>。'
    6:
        image: /images/user-guide/alarm-rules/examples/alarm-rule-example-clear-condition-7-pe.png
        title: '应用更改。'

alarm-rules-example-condition-duration-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-duration-1-pe.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-duration-2-pe.png
        title: '向下滚动到 <b>触发条件</b> 部分并编辑现有条件。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-duration-3-pe.png
        title: '<b>条件类型：</b> 持续时间；<b>持续时间值：</b> 1 分钟。<br>点击 <b>保存</b>。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-duration-4-pe.png
        title: '应用更改。'

alarm-rules-example-condition-with-dynamic-duration-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-1-pe.png
        title: '向 <b>Thermometer</b> 设备添加 <b>highTemperatureDurationThreshold</b> 服务端属性。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-2-pe.png
        title: '该值将作为持续时间要求被告警规则使用。'

alarm-rules-example-condition-with-dynamic-duration-2:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-3-pe.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-4-pe.png
        title: '在 <b>参数</b> 部分添加将用于 <b>持续时间</b> 条件的新参数。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-5-pe.png
        title: '向下滚动到 <b>触发条件</b> 部分并编辑现有条件。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-6-pe.png
        title: '<b>条件类型：</b> 持续时间；<b>动态值：</b> <b>参数</b> highTemperatureDurationThreshold；<b>时间单位：</b> 分钟。<br>点击 <b>保存</b>。'
    4:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-with-dynamic-duration-7-pe.png
        title: '应用更改。'

alarm-rules-example-condition-repeating-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-repeating-1-pe.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-repeating-2-pe.png
        title: '向下滚动到 <b>触发条件</b> 部分并编辑现有条件。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-repeating-3-pe.png
        title: '条件类型：<b>重复</b>。<b>事件次数</b>：3。保存条件。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-condition-repeating-4-pe.png
        title: '应用更改。'

alarm-rules-example-schedule-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-schedule-1-pe.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-schedule-2-pe.png
        title: '打开告警触发条件的计划设置。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-schedule-3-pe.png
        title: '选择计划类型：<i>在特定时间生效</i>。<br>配置规则仅在工作日 10:00 至 19:00 生效。点击 <b>保存</b>。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-schedule-4-pe.png
        title: '应用更改。'

alarm-rules-example-advanced-thresholds-1:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-1-pe.png
        title: '向 <b>Thermometer</b> 设备添加 <b>temperatureAlarmFlag</b> <i>服务端属性</i>。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-2-pe.png
        title: '该属性决定告警规则对设备是否生效。'

alarm-rules-example-advanced-thresholds-2:
    0:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-3-pe.png
        title: '进入 <b>High Temperature</b> 规则并打开编辑。'
    1:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-4-pe.png
        title: '在 <b>参数</b> 部分添加将用于 <b>创建</b> 条件的新参数。'
    2:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-5-pe.png
        title: '向下滚动到 <b>触发条件</b> 部分并编辑现有条件。'
    3:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-6-pe.png
        title: '点击 <b>添加参数筛选器</b>。'
    4:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-7-pe.png
        title: '<b>参数：</b> <i>temperatureAlarmFlag</i>；<b>值类型：</b> <i>布尔</i>；<b>操作：</b> <i>等于</i>；<b>静态值：</b> <i>True</i>。<br>点击 <b>添加</b>。'
    5:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-8-pe.png
        title: '点击 <b>保存</b>。'
    6:
        image: /images/user-guide/alarm-rules/examples/alarm-rules-example-advanced-thresholds-9-pe.png
        title: '应用更改。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/alarm-rules.md %}