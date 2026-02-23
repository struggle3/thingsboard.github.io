使用指定时序键的**最新遥测值**。

**示例：**temperature、humidity、latitude、longitude

**配置：**
- **参数类型**：Latest telemetry
- 指定**时序键**。
- 设置**参数名称**，即脚本逻辑中使用的变量名。
- 可选设置时序的**默认值**。

{% assign latestTelemetryArgumentTypeCE = '
    ===
        image: /images/user-guide/calculated-fields/argument-latest-telemetry-1-ce.png
        title: 选择 **latest telemetry**(3) 参数类型，指定**时序键**(4)，设置**参数名称**(5)。可选定义默认值(6)。最后点击 **Add**(7)。
'
%}

{% assign latestTelemetryArgumentTypePE = '
    ===
        image: /images/user-guide/calculated-fields/argument-latest-telemetry-1-pe.png
        title: 选择 **latest telemetry**(3) 参数类型，指定**时序键**(4)，设置**参数名称**(5)。可选定义默认值(6)。最后点击 **Add**(7)。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=latestTelemetryArgumentTypePE %}
{% else %}  
{% include images-gallery.liquid imageCollection=latestTelemetryArgumentTypeCE %}
{% endif %}