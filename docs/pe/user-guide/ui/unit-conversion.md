---
layout: docwithnav-pe
assignees:
- stitenko
title: 单位转换
description: 单位转换

unit-conversion-configuring:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-configuring-1-pe.png
        title: '单位转换在部件设置内的<b>遥测键</b>、<b>Y轴</b>和<b>阈值</b>配置的<b>单位设置</b>中配置。'
    1:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-configuring-2-pe.png
        title: '指定<b>源单位</b>——从服务器接收的传入遥测值的单位，以确保正确转换为目标单位。'
    2:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-configuring-3-pe.png
        title: '通过切换"Enable unit conversion"开关启用单位转换。系统将自动为各单位系统建议常用目标单位（如Metric用°C、Imperial用°F、Hybrid用°C）。您也可以从下拉列表选择其他单位覆盖。然后点击"<b>Apply</b>"保存更改。'
    3:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-configuring-4-pe.png
        title: '启用单位转换后，单位字段中会出现图标表示该功能已激活。'

range-color-settings:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/range-color-settings-1-pe.png
        title: '范围颜色设置使用从服务器接收的原始遥测值（源单位）——在应用任何单位转换之前。'

changing-unit-system:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/changing-unit-system-1-pe.png
        title: '点击屏幕右上角的三点图标，选择"<b>Account</b>"。'
    1:
        image: /images/user-guide/ui/widgets/unit-conversion/changing-unit-system-2-pe.png
        title: '在<b>Profile</b>设置中，从下拉列表选择所需的单位系统。然后应用更改。'

unit-conversion-example-1:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-1-pe.png
        title: '以<b>Temperature & Humidity dashboard</b>为例配置单位转换功能。该仪表板包含显示<b>温度</b>（摄氏度<b>°C</b>）和<b>湿度</b>（百分比<b>%</b>）的部件。'

unit-conversion-example-2:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-2-pe.png
        title: '切换到"Temperature and Humidity history"图表部件的编辑模式。首先配置"temperature"遥测键的单位转换：点击"temperature"键字段中的"Units"行。'
    1:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-3-pe.png
        title: '源单位已设为Celsius(°C)，符合需求。启用转换：打开"Enable unit conversion"选项，并为各单位系统指定目标单位（如Imperial用°F、Metric和Hybrid用°C）。然后点击"Apply"。'

unit-conversion-example-3:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-4-pe.png
        title: '对Y轴重复相同步骤以转换温度值——启用单位转换并为各测量系统指定目标单位。点击"Apply"。'
    1:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-5-pe.png
        title: '对于阈值，同样启用单位转换并为各单位系统指定目标单位。然后应用所有更改。'

unit-conversion-example-4:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-6-pe.png
        title: '切换到"Temperature"卡片部件的编辑模式。'
    1:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-7-pe.png
        title: '在"Unit settings"对话框中，如前所述启用单位转换并为各单位系统提供相应单位。应用更改并保存仪表板。'

unit-conversion-example-5:
    0:        
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-8-pe.png
        title: '由于当前单位系统设为<b>Metric</b>，温度值以摄氏度(<b>°C</b>)显示。'

unit-conversion-example-6:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-9-pe.png
        title: '点击屏幕右上角的三点图标，选择"<b>Account</b>"。'
    1:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-10-pe.png
        title: '在<b>Profile</b>设置中，从下拉列表选择<b>Imperial</b>单位系统。然后应用更改。'

unit-conversion-example-7:
    0:
        image: /images/user-guide/ui/widgets/unit-conversion/unit-conversion-example-11-pe.png
        title: '返回仪表板——您将看到温度值、Y轴标签和阈值已根据所选单位系统从摄氏度转换为华氏度。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ui/unit-conversion.md %}