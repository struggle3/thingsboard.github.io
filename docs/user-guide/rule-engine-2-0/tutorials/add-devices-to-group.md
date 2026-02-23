---
layout: docwithnav
title: 动态将设备添加/移出分组
description: 根据设备上报数据动态添加/移除设备至分组

---
{% assign hostName = "thingsboard.cloud" %}

{% assign feature = "Device & Asset Groups" %}{% include templates/pe-feature-banner.md %}

本教程演示如何根据设备上报的数据，动态将设备添加或移出设备分组。 

* TOC
{:toc}

## 使用场景

假设设备向ThingsBoard上报温度读数，您希望可视化那些上报温度 > 50°C 的设备。 

本教程将配置ThingsBoard Rule Engine，根据设备上报的温度读数自动更新「高温设备」分组的成员。
您可以将本教程作为基础，实现更复杂的过滤逻辑。

## 前置条件 

请确保已完成以下指南并阅读所列文章：

  * [Getting Started](/docs/getting-started-guides/helloworld/) 指南。
  * [Rule Engine Overview](/docs/user-guide/rule-engine-2-0/overview/)。

## 模型定义

我们将使用名为「Sensor A」、类型为「DHT22」的温度传感器设备。

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/add-device.png)

## 消息流

本节说明本教程中各节点的作用。 

### Root rule chain

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/root-rule-chain.png)

  * **Node A**：Rule Chain 节点

    * 修改默认 root rule chain，将所有 telemetry 转发到新的「Add device to group」rule chain

### 新建「Add device to group」rule chain

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/rule-chain.png)

  * **Node B**：Script filter 节点

    * 检查入站消息是否包含温度读数
    * 若包含温度读数，则转发至 Node C

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/has-temperature-node.png)

  * **Node C**：Script filter 节点

    * 检查入站消息温度是否 > 50°C
    * 若温度 > 50°C，消息转发至 Node D
    * 若温度 <= 50°C，消息转发至 Node E

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/high-temperature-node.png)

  * **Node D**：Add to Group 节点

    * 将设备加入分组
    * 通过替换 deviceType 的 metadata 值构建分组名
    * 需要时自动创建设备分组

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/add-group-node.png)

  * **Node E**：Remove from Group 节点

    * 将设备从分组中移除
    * 通过替换 deviceType 的 metadata 值构建分组名

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/remove-group-node.png)


## 配置 Rule Chain

下载并 [**import**](/docs/user-guide/ui/rule-chains/#rule-chains-importexport) 附带的 json [**file**](/docs/user-guide/rule-engine-2-0/pe/tutorials/add_device_to_group.json) 作为新的「Add device to group」rule chain。 
注意所有节点均已开启 debug，会影响性能。在 root rule chain 中按上图创建 Node A，将 telemetry 转发到新的 rule chain。

## 验证流程

代表新设备 [Publish](/docs/getting-started-guides/helloworld/#pushing-data-from-the-device) 温度读数，并观察新分组是否自动创建： 

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/results.png)   

## Next steps

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}


 






