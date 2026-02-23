---
layout: docwithnav-pe
assignees:
- stitenko
title: 基于两台设备遥测的数据函数
description: 使用计算字段功能，基于两台设备遥测的数据函数

adding-asset:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/adding-asset-1-pe.png
        title: '前往「实体」部分的「资产」页面。点击表格右上角的「+」图标，从下拉菜单中选择「添加新资产」。创建新资产及其对应的资产配置，将资产命名为「仓库 A」，配置命名为「warehouse」。'

added-devices:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/adding-devices-1-pe.png
        title: '前往「实体」部分的「设备」页面。创建两个分别名为「室内温度计」和「室外温度计」的设备。创建名为「thermometer」的设备配置并分配给这两个设备。'
    
adding-relation-from-devices:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/adding-relation-from-devices-1-pe.png
        title: '在「仓库 A」资产与「室内温度计」和「室外温度计」设备之间创建关系。'

thermostat-emulator-nodes:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/thermostat-emulator-nodes-1-pe.png
        title: '添加两个生成器节点，用于定期生成包含随机温度读数的消息。将这些节点的消息路由到设备配置节点。'
    1:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/thermostat-emulator-nodes-2-pe.png
        title: '「室内温度计」设备的生成器节点。'
    2:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/thermostat-emulator-nodes-3-pe.png
        title: '「室外温度计」设备的生成器节点。'

thermometer-telemetry:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/indoor-thermometer-telemetry-1-pe.png
        title: '前往「实体」部分的「设备」页面。选择「室内温度计」设备并打开「最新遥测」选项卡，即可查看生成的遥测数据。'
    1:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/outdoor-thermometer-telemetry-1-pe.png
        title: '选择「室外温度计」设备并打开「最新遥测」选项卡，即可查看生成的遥测数据。'

create-calculated-field-1:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/create-calculated-field-1-pe.png
        title: '返回设备并打开其详情，进入「计算字段」选项卡。点击「+」图标按钮，从下拉菜单中选择「创建新计算字段」。'

create-calculated-field-2:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/create-calculated-field-2-pe.png
        title: '将打开计算字段配置窗口。输入计算字段的描述性标题，选择「简单」作为计算字段类型。此类型支持基本的数学运算和函数。'

create-calculated-field-3:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/create-calculated-field-3-pe.png
        title: '点击「添加参数」按钮，输入「indoorTemperature」作为参数名称，选择「室内温度计」设备作为实体，保持参数类型为「最新遥测」，将「temperature」设为时序键，然后点击「添加」。'

create-calculated-field-4:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/create-calculated-field-4-pe.png
        title: '再次点击「添加参数」按钮，输入「outdoorTemperature」作为参数名称，选择「室外温度计」设备作为实体，保持参数类型为「最新遥测」，将「temperature」设为时序键，最后点击「添加」按钮。'

create-calculated-field-5:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/create-calculated-field-5-pe.png
        title: '使用「参数」部分中定义的变量输入计算公式的数学表达式。'

create-calculated-field-6:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/create-calculated-field-6-pe.png
        title: '将「时序」设为输出类型。将「deltaTemperature」设为用于存储计算结果的变量名。可选指定小数位数。点击「添加」完成计算字段的添加。'
    1:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/create-calculated-field-7-pe.png
        title: '计算字段已成功添加到设备。'

check-calculated-field-configuration:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/check-calculated-field-configuration-1-pe.png
        title: '要验证配置是否正确，请前往「仓库 A」资产的「最新遥测」选项卡。如果一切配置正确，您应能看到「deltaTemperature」键及其值。'

delta-temperature-dashboard:
    0:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/delta-temperature-dashboard-1-pe.png
        title: '下载并导入专为此示例准备的仪表板，以实时监控温差。'
    1:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/delta-temperature-dashboard-2-pe.png
        title: '导入后，需要在实体别名的资产中指定「仓库 A」以正确显示数据。'
    2:
        image: /images/tutorials/function-based-on-telemetry-from-two-devices/delta-temperature-dashboard-3-pe.png
        title: '完成后，仪表板将显示「仓库 A」资产两台温度计之间的温差数据。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/tutorials/function-based-on-telemetry-from-two-devices.md %}