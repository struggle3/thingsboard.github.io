系统包含14台运行设备：

**热泵**

热泵控制泳池温度，并依据预设温度自动运行。该行为由Swimming Pool Device Rule Chain管理，以实现节能和精确温控。根据温度读数，热泵会自动：
* 在泳池温度超过热泵目标温度，或室外温度高于设定阈值时关闭。
* 在泳池温度与室外温度均低于各自目标值时开启。

![image](/images/solutions/swimming_pool_scada_system/scada-devices/heat-pump.png)

热泵可配置以下选项：

- 开启/关闭热泵；
- 修改当前温度；
- 设置状态告警；
- 启用严重状态动画；
- 桨叶转速调节：根据温度或其他设备参数调整桨叶转速。

<br>

**水泵**

通过开关水泵管理泳池内水循环。

![image](/images/solutions/swimming_pool_scada_system/scada-devices/water-pump.png)

<br>

**pH滤器**

管理过滤与加药流程，使水pH保持在最佳范围。点击pH滤器可在弹窗中打开pH滤器图。

![image](/images/solutions/swimming_pool_scada_system/scada-devices/ph-filter.png)

<br>

**砂滤器**

用于从泳池中高效清除杂物。砂滤器支持多种模式：filtration、wasting、backwashing、recirculation、rinsing，均可通过SCADA系统远程控制。

![image](/images/solutions/swimming_pool_scada_system/scada-devices/sand-filter.png)

<br>

**水位计**

测量泳池水位，提供维持适宜水位和检测渗漏所需数据。

![image](/images/solutions/swimming_pool_scada_system/scada-devices/water-level-meter.png)

<br>

**阀门**

精确控制泳池系统各区域之间的水流。点击阀门可开启或关闭。

![image](/images/solutions/swimming_pool_scada_system/scada-devices/valve.png)
