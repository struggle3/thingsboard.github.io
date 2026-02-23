---
layout: docwithnav
title: 检查实体间 Relation
description: 检查实体关系

---
本教程演示如何使用 [**check relation presence**](/docs/user-guide/rule-engine-2-0/nodes/filter/check-relation-presence/) 节点检查实体间的 relation。

* TOC
{:toc}

## Use case

Let’s assume the following use case:

 - 有 2 个设备：

   - **Smoke Detector**：带 **Smoke Sensor**，检测到烟雾时向ThingsBoard发送数据。

   - **Fire Alarm System**：检测到烟雾时触发火灾警报。

该场景有多种实现方式，例如可使用 **Switch** 节点将入站消息路由到一个或多个输出链。<br>
更多关于 **Switch** 节点的用法，请参阅 [**See Also**](/docs/user-guide/rule-engine-2-0/tutorials/check-relation-tutorial/#see-also) 中的 **Switch Node** 文章。

## 前置条件

开始本教程前请阅读以下指南：

  * [Getting Started](/docs/getting-started-guides/helloworld/)。
  * [Rule Engine Overview](/docs/user-guide/rule-engine-2-0/overview/)。

## Adding the devices and creating the relation between them

  在ThingsBoard中添加两个 Device 实体：

   - Smoke Detector 表示为 Device，名称为 **Smoke Detector**，类型为 **Smoke Sensor**。

   - Fire Alarm System 表示为 Device，名称为 **Fire Alarm System**，类型为 **Fire Alarm Device**。

  创建类型为 Uses 的 relation：

   - 从 Smoke Detector 指向 Fire Alarm System；

  以下截图展示操作步骤：

   ![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/smoke-sensor.png) ![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/fire-alarm-system.png) <br>
   ![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/add-relation.png)

<br>

## 消息流

本节说明本教程中各节点的作用：

- Node A：[**check relation presence**](/docs/user-guide/rule-engine-2-0/nodes/filter/check-relation-presence/) 节点。
  - 按 relation 类型和方向，检查从设备 **Fire Alarm System** 到消息 originator **Smoke Detector** 的 relation 是否存在。 
- Node B：[**change originator**](/docs/user-guide/rule-engine-2-0/nodes/transformation/change-originator/) 节点。
  - 将 originator 从设备 **Smoke Detector** 改为关联设备 **Fire Alarm System**，后续消息按来自 **Fire Alarm System** 处理。
- Node C：[**transformation script**](/docs/user-guide/rule-engine-2-0/nodes/transformation/script/) 节点。
  - 将原始消息转换为 RPC request 消息。 
- Node D：[**RPC call request**](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-request/) 节点。
  - 将消息 payload 作为响应发送给 **Fire Alarm System**。
- Node E：[**filter script**](/docs/user-guide/rule-engine-2-0/nodes/filter/script/) 节点。
  - 检查入站消息的数据是否为 **smoke**。
- Node F：[**clear alarm**](/docs/user-guide/rule-engine-2-0/nodes/action/clear-alarm/) 节点。
  - 加载 Message Originator **Smoke Detector** 的、配置了 Alarm Type 的最新 Alarm，若存在则清除。  
- Node G：[**create alarm**](/docs/user-guide/rule-engine-2-0/nodes/action/create-alarm/) 节点。
  - 尝试加载 Message Originator（即 **Smoke Detector**）的、配置了 Alarm Type 的最新 Alarm。  
- Node H：[**rule chain**](/docs/user-guide/rule-engine-2-0/nodes/flow/rule-chain/) 节点。
  - 将入站消息转发到指定 Rule Chain **Related Fire Alarm System**。 

<br>

## 配置 Rule Chains

本教程中修改了 **Root Rule Chain** 并新建了 Rule Chain **Related Fire Alarm System**

<br>以下截图展示上述 Rule Chains 的布局：

  - **Related Fire Alarm System:**

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/fire-alarm-chain.png)

 - **Root Rule Chain:**

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/chain.png)

<br>

下载附带的 json [**file**](/docs/user-guide/rule-engine-2-0/tutorials/resources/check-relation-tutorial.json) 作为 **Root Rule Chain**。请勿忘记将该 rule chain 标记为 **root**。

<br>

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/root-chain.png)

Also, you need to create **Related Fire Alarm System** Rule Chain or you can download the attached json [**file**](/docs/user-guide/rule-engine-2-0/tutorials/resources/related_fire_alarm_system.json) for this Chain and import it.
<br>
<br>

 The following section shows you how to create it.

### Create new Rule Chain (**Related Fire Alarm System**)

Go to **Rule Chains** -> **Add new Rule Chain**

Configuration:

- Name : **Related Fire Alarm System**

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/add-fire-alarm-chain.png)

New Rule Chain is created. Press **Edit** button and configure Chain.

#### Adding the required nodes

In this rule chain, you will create 4 nodes as it will be explained in the following sections:

#### Node A: **Check Relation**

 - Add the **Check Relation** node and connect it to the **Input** node.<br>

    This node will check the relation from the Device, **Fire Alarm System**, to the originator of the message **Smoke Detector** using the type and direction of relation.
    If the relation exists, the message will be sent through the True chain.

 - Fill in the fields with the input data shown in the following table:

 <table style="width: 25%">
   <thead>
       <tr>
           <td><b>Field</b></td><td><b>Input Data</b></td>
       </tr>
   </thead>
   <tbody>
       <tr>
           <td>Name</td>
           <td>Check Relation</td>
       </tr>
       <tr>
           <td>Direction</td>
           <td>To</td>
       </tr>
       <tr>
           <td>Type</td>
           <td>Device</td>
       </tr>
        <tr>
           <td>Device</td>
           <td>Fire Alarm System</td>
        </tr>
       <tr>
           <td>Relation type</td>
           <td>Uses</td>
       </tr>
    </tbody>
 </table>

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/check-relation.png)

#### Node B: **Change Orignator**

- Add the **Change Orignator** node and connect it to the **Check Relation** node with a relation type **True**. <br>
  This node will change the originator from the Device **Smoke Detector** to the related Device **Fire Alarm System** and the submitted message will be processed as a message from another entity, namely **Fire Alarm System**.

- Fill in the fields with the input data shown in the following table: 

<table style="width: 25%">
  <thead>
      <tr>
          <td><b>Field</b></td><td><b>Input Data</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>Name</td>
          <td>Change Originator</td>
      </tr>
      <tr>
          <td>Originator source</td>
          <td>Related</td>
      </tr>
      <tr>
          <td>Direction</td>
          <td>From</td>
      </tr>
      <tr>
          <td>Max relationship level</td>
          <td>1</td>
      </tr>
      <tr>
          <td>Relation type</td>
          <td>Uses</td>
      </tr>
      <tr>
          <td>Entity type</td>
          <td>Device</td>
      </tr>
   </tbody>
</table>

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/change-originator.png)

#### Node C: **Script Transformation**
 - Add the **Script Transformation** node and connect it to the **Change Orignator** node with a relation type **Success**.

This node will transform an original message into RPC request message. 

- The RPC call will have 2 properties:

    <table style="width: 25%">
      <thead>
          <tr>
              <td><b>Property</b></td><td><b>Value</b></td>
          </tr>
      </thead>
      <tbody>
          <tr>
              <td>method</td>
              <td>ON</td>
          </tr>
          <tr>
              <td>params</td>
              <td>{}</td>
          </tr>
       </tbody>
    </table>

 - In order to do this, add the following Script:

  {% highlight javascript %}
    var newMsg = {};
    if(msg.smoke == 'true'){
        newMsg.method = 'ON';
    }
    newMsg.params={};
    return {msg: newMsg, metadata: metadata, msgType: msgType};{% endhighlight %}


 - Enter the Name field as **New RPC message**.

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/transformation-node.png)

#### Node D: **RPC call request** node
- Add the **RPC call request** node and connect it to the **Script Transformation** node with a relation type **Success**. <br>
  This node takes the message payload and sends it as a response to the Message Originator **Fire Alarm System**.
- Enter the Name field as **Fire Alarm System**.
- Enter the Timeout value as 60 seconds.

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/rpc-call-request.png)

This Rule chain is ready and we should save it.

### Modify Root Rule Chain

The initial Rule Chain has been modified by adding the following nodes:

#### Node E: **Filter Script**
- Add the **Filter Script** node and connect it to the **Save Timeseries** node with a relation type **Success**. <br>
  This node will check if data of incoming message is **smoke** using the following script:

  {% highlight javascript %}return msg.smoke== 'true';{% endhighlight %}

- Enter the Name field as **Smoke Alarm Filter**.

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/alarm-filter.png)

#### Node F: **Clear Alarm**
- Add the **Clear Alarm** node and connect it to the **Filter Script** node with a relation type **False**. <br>
  This node loads the latest Alarm with configured Alarm Type for Message Originator **Smoke Detector** and Clears the Alarm if it exists.

- Enter the Name field as **Clear Smoke Alarm** and the Alarm type as **Smoke Alarm**.

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/clear-alarm.png)

#### Node G: **Create alarm**
- Add the **Create alarm** node and connect it to the **Filter Script** node with a relation type **True**. <br>
  This node tries to load the latest Alarm with configured Alarm Type for Message Originator, namely **Smoke Detector**.

 - Enter the Name field as **Create Smoke Alarm** and the Alarm type as **Smoke Alarm**.

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/create-alarm.png)

#### Node H: **Rule Chain**
- Add the **Rule Chain** node and connect it to the **Filter Script** node with a relation type **True**. <br>
  This node forwards incoming Message to specified Rule Chain **Related Fire Alarm System**.

- Enter the Name field as **Related Fire Alarm System**.

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/add-alarm-chain.png)

The following screenshot shows how the final **Root Rule Chain** should look like:

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/view-chain.png)

<br>
<br>

## How to verify the Rule Chain and Post telemetry

- Use the following javascript code to emulate the **Fire Alarm System** device.

  - [**FireAlarmEmulator.js**](/docs/user-guide/rule-engine-2-0/tutorials/resources/FireAlarmEmulator.js).

  - To run the script, you need to do the following steps:

  - Copy the **Fire Alarm System** device access token, then paste them in the script.  <br>
  You can copy the access token from the Device page. <br> <br>


- Use the Rest APIs, [Telemetry upload APIs](/docs/reference/http-api/#telemetry-upload-api), for posting telemetry from the device **Smoke Detector**. <br>

{% highlight bash %}
curl -v -X POST -d '{"smoke":"true"}' https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"

**you need to replace$ACCESS_TOKENwith the actual device token**
{% endhighlight %}
<br>

  ![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/smoke-telemetry.png)![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/fire-alarm-telemetry.png)

<br>
Also, you can:

  - configure the Dashboard by adding an alarm widget to visualize the alarms.

  - define an additional logic for alarm processing, for example, sending an email.

Please refer to the third and fourth links under the **See Also** section to see how to do this.

<br>

## See Also

- [Switch Node](/docs/user-guide/rule-engine-2-0/nodes/filter/switch/) 指南 — 了解如何在 ThingsBoard 中使用 Switch Node。

- [Validate incoming telemetry](/docs/user-guide/rule-engine-2-0/tutorials/validate-incoming-telemetry/#step-1-adding-temperature-validation-node) 教程 — 了解如何使用 Script Filter 节点验证入站 telemetry。

- [Create & Clear Alarms: configure dashboard](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/#configure-device-and-dashboard) 指南 — 学习如何向 dashboard 添加 Alarm 部件。

- [Send Email](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 教程。

- [RPC capabilities](/docs/user-guide/rpc/#server-side-rpc-api) 指南 — 了解 ThingsBoard 中 RPC 的工作原理。

## Next steps

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}







