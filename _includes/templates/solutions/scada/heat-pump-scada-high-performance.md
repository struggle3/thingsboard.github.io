该部件订阅其所用设备配置文件中reminder alarm status字段，从而接收告警创建、类型及严重程度相关更新。

{% include images-gallery.html imageCollection="alarm-widget-configuration-1" %}

当告警规则触发时，热泵左下角会出现告警图标。
图标类型取决于设备配置文件中定义的告警严重程度及部件自身设置。  
例如，若热泵部件检测到严重程度为"Major"、"Minor"、"Warning"或"Indeterminate"的告警，部件处于"Warning"状态，部件旁将显示黄色三角。
若告警严重程度为"Critical"，部件处于"Critical"状态，部件旁将显示红色方块。

{% include images-gallery.html imageCollection="alarm-heat-pump-high-performance-1" %}

点击热泵设备可进入其状态页，查看运行数据与当前告警。详情包括转速、功耗、制冷剂压力等。

{% include images-gallery.html imageCollection="scada-alarms-high-performance-1" %}

切换到"Alarms"标签可查看系统中所有活跃告警，按来源设备及其告警类型、严重程度分组展示。

{% include images-gallery.html imageCollection="scada-alarms-high-performance-2" %}
