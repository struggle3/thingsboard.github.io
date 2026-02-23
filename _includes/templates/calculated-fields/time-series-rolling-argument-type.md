使用指定时间窗口内的**历史时序数据**进行趋势分析。

**示例：**speed、voltage

**配置：**
- **参数类型**：Time series rolling
- 指定**时序键**。
- 设置**参数名称**，即脚本逻辑中使用的变量名。
- 定义**数据采集时间窗口**，确定用于计算的历史遥测时间范围。
- 设置可处理的**最大数据点数**（该设置由系统管理员在[租户配置](/docs/{{docsPrefix}}user-guide/tenant-profiles/#api-limits--usage){:target="_blank"}中配置。）

{% assign rollingArgumentTypeCE = '
    ===
        image: /images/user-guide/calculated-fields/argument-time-series-rolling-1-ce.png
        title: 选择 **time series rolling** 参数类型(3)，指定**时序键**(4)，设置**参数名称**(5)。定义**数据采集时间窗口**(6)和最大数据点数(7)，然后点击 **Add**(8)。
'
%}

{% assign rollingArgumentTypePE = '
    ===
        image: /images/user-guide/calculated-fields/argument-time-series-rolling-1-pe.png
        title: 选择 **time series rolling** 参数类型(3)，指定**时序键**(4)，设置**参数名称**(5)。定义**数据采集时间窗口**(6)和最大数据点数(7)，然后点击 **Add**(8)。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=rollingArgumentTypePE %}
{% else %}  
{% include images-gallery.liquid imageCollection=rollingArgumentTypeCE %}
{% endif %}