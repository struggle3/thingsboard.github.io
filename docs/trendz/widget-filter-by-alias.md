---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 从 alias 应用 filter
description: 从 alias 应用 filter 说明

---

本指南说明如何将dashboard上的标准ThingsBoard部件与Trendz View连接。
可通过ThingsBoard dashboard aliases和**Trendz widget Bundle**中的**Trendz View Latest**实现。

**示例**：ThingsBoard中有10台**Machine**设备。希望创建一个dashboard，在列表中显示所有**Machine**设备，
选择某一台设备后，dashboard上其他部件显示该设备详情。最终dashboard上有2个部件：
* Entity List——显示设备列表
* Trendz view——显示选中设备温度的折线图 
 
ThingsBoard侧需设置dashboard并添加2个部件。详细步骤不在本教程范围内，简要如下：
* 创建**all_devices** alias，解析类型为**Machine**的所有设备
* 创建**selected_device** alias，类型为**entity form dashboard state**——该alias保存选中设备的引用

![image](/images/trendz/embed-tb-alias.png)
 
* 添加**Entity List**部件，以**all_devices** alias作为数据源
* 配置**On row click**动作，将选中设备保存到**selected_device** alias
* 保存dashboard

**Trendz View**侧：
* 在Trendz中打开视图
* 在filter区域添加**Machine**字段，以便按名称过滤Machine
* 保存视图
* 复制该视图链接

返回ThingsBoard Dashboard：
* 编辑dashboard
* 从**Trendz widget Bundle**添加**Trendz View Latest**到dashboard
* 将**selected_device**设为Trendz View的数据源
* 从alias使用**name**作为键

![image](/images/trendz/embed-trndz-alias.png)

* 切换到**Advanced**选项卡
* 在**View URL**中填入视图链接
* 在**Filter Name**中填入**Machine**——该字段内容需与Trendz View Filter中一致
* 保存Dashboard

![image](/images/trendz/embed-trndz-filter-name.png)
![image](/images/trendz/embed-tb-filter-name.png)

此后，每当**selected_device** alias更新时，其Entity Name的值会传入Trendz View过滤器。

若Trendz View中配置了多个过滤器，系统会按名称匹配对应过滤器。

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/embed-trndz-alias.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-alias-connect.webm" type="video/webm">                 
        </video> 
    </div>
</div>

## Next Steps

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
