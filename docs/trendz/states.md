---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 状态
description: Trendz 状态说明
---

* TOC
{:toc}

&nbsp;
<div id="video">  
    <div  id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/FrubZ-odF1s" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## States

### Simple state

![image](/images/trendz/state-simple-view.png)

本例中**Machine**设备上报零件产量。目标是分析设备生产率。

定义states：
* **Low Production** - 产量 < 75
* **Moderate Production** - 产量在75到110之间
* **High Production** - 产量 > 110

判断设备是否处于**Low Production** state 的条件：
{% highlight javascript %}
    var okRate = none(Machine.okDetails);
    return okRate < 75;
{% endhighlight %}  

操作步骤：
* 创建**Bar** chart
* 在**X-axis**添加**Date(RAW)**
* 添加**State**字段，标题改为**Low Production**
* 字段聚合改为**DURATION_PERCENT**
* 编写**Low Production**公式
* 对**Moderate Production**和**High Production**重复上述3步
* 在view settings中启用stack模式、100% stacked bar和labels

![image](/images/trendz/state-simple-config-drop.png)

![image](/images/trendz/state-simple-config.png)

视图已就绪，可查看设备在各state下的停留时间占比。

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/state-simple-view.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-state-duration-percent.webm" type="video/webm">                 
        </video> 
    </div>
</div>


### State with multiple fields

![image](/images/trendz/state-multiple-view.png)

也可使用来自不同assets\devices的多个字段计算state。本例分析设备处于critical state的时间占比。
该可视化有助于对比设备表现并判断何时维护以预防downtime。

当**pressure**上升且**rotation speed**下降时，设备处于critical state。计算处于critical state的时间。

**Critical** state的形式化定义：
{% highlight javascript %}
    var pressure = none(Machine.pressure);
    var speed = none(Machine.rotationSpeed);
    return pressure > 700 && speed < 35;
{% endhighlight %}  

* 创建**Heatmap** chart
* 添加**State**字段，标题改为**Critical**
* 字段聚合改为**DURATION_PERCENT**
* 编写**Critical** state公式
* 在**By**字段选择**hour vs day of week**

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/state-multiple-view.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-state-multiple-heatmap.webm" type="video/webm">                 
        </video> 
    </div>
</div>

### State Aggregation

state字段支持的聚合函数：
* Duration - 组内处于该state的总时间。单位：小时、分钟、秒等。
* Duration percent - 组内处于该state的时间占比。

### Get original field value

在应用 transformation 前需获取原始字段值的引用。示例：

```
var temp = none(Machine.temperature);
```

* none() - 聚合函数
* Machine - Entity Name（可为Asset Type或Device Type）
* temperature - Field Name

**三部分缺一不可**，没有聚合函数无法访问原始字段值。

若原始字段值为attribute、entity name或owner name，应使用**uniq()**聚合函数。

此模板可用于比较文本字段：

```
var currentState = none(machine.status);
return "running" === currentState;
```

### Supported Aggregation Functions

State字段仅支持**none()**聚合函数。

每个函数只接受1个参数——格式为EntityName.fieldName的字段引用。例如：

```
none(Machine.temperature)
```

States常用于计算设备/asset在各state下的停留时间。

### Language

State字段使用Javascript编写 transformation 函数。内置 Engine 完全支持ECMAScript 5.1。

## Next Steps

{% assign currentGuide = "States" %}{% include templates/trndz-guides-banner.md %}
