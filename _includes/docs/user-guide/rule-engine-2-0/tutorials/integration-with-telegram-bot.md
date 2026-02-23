* TOC
{:toc}

## 概述

Telegram 支持创建 Telegram Bot，作为第三方应用。 
本教程将演示如何创建 Telegram Bot，<br>
并配置 ThingsBoard rule engine，通过 REST API Call 扩展向 Telegram App 发送通知。

## 使用场景

本教程基于 [create & clear alarms](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/#use-case) 教程及其使用场景。 
我们将复用前述教程的 rule chains，并添加若干 rule 节点以集成 Telegram。   

假设设备使用 DHT22 传感器采集温度读数并推送到 ThingsBoard。 
DHT22 适用于 -40 到 80°C。温度超出该范围时生成 Alarm，alarm 创建时向 Telegram App 发送通知。

本教程将配置 ThingsBoard Rule Engine，实现： 

- alarm 创建时向用户发送消息通知。

- 使用 Script Transform 节点将当前 alarm 类型及其 originator 加入消息正文。

## 前置条件 

请确保已完成以下指南并阅读所列文章：

  * [Getting Started](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南。
  * [Rule Engine Overview](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。
  * [Create & clear alarms](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 指南。

## 消息流  

本节说明本教程中各节点的作用：

- Node A：[**Transform Script**](/docs/user-guide/rule-engine-2-0/nodes/transformation/script/) 节点。
  - 用于构建 Telegram 消息通知的正文。  
- Node B：[**REST API Call**](/docs/user-guide/rule-engine-2-0/nodes/external/rest-api-call/) 节点。
  - 将 Telegram 消息 payload 发送到配置的 REST 端点。本示例中为 Telegram REST API。

## 创建 Telegram 机器人

[BotFather](https://telegram.me/botfather) 是帮助您[创建](https://core.telegram.org/bots#6-botfather)新机器人和修改其设置的主机器人。

创建完成后，可为新机器人生成授权令牌。
令牌是一个类似 **'110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw'** 的字符串，用于授权机器人。
    
前置条件：

 - ThingsBoard 已运行
 - 已创建 Telegram 机器人

### 获取 Chat ID

下一步需要获取 Chat ID。Chat ID 用于通过 HTTP API 发送消息。

获取 Chat ID 的几种方式：

 - 首先，需向机器人发送一条消息：
 
    - 在私聊中；
    
       ![image](/images/gateway/telegram-bot/private-msg-to-bot.png)    
    
    - 在已将机器人添加为成员的群组中。
    
       ![image](/images/gateway/telegram-bot/msg-to-bot-in-chat.png)    
      
    <br> 其中 **ThingsBoard_Bot** 为 Telegram 机器人的名称。

 - 随后，在浏览器中打开并访问以下 URL：

```bash
https://api.telegram.org/bot"YOUR_BOT_TOKEN"/getUpdates

"YOUR_BOT_TOKEN" has to be replaced by the authentication token of your bot, e.g.:

https://api.telegram.org/bot110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw/getUpdates
```



在返回数据中可找到 **'id'** 字段，即 chat_id。

 - 第一种方式：

![image](/images/gateway/telegram-bot/first-option.png)

 - 第二种方式：

![image](/images/gateway/telegram-bot/second-option.png)

此后即可开始配置规则引擎以使用 REST API Call 扩展。

## 配置规则链

本教程使用 [create & clear alarms](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 教程中的规则链。
在 [消息流](#message-flow) 章节所述的节点基础上，修改了规则链 **Create & Clear Alarms**<br>
并将其重命名为：**Create/Clear Alarms & send notifications to Telegram**。

<br>以下截图展示了上述规则链的大致结构：
 
  - **Create/Clear Alarms & send notifications to Telegram：**

![image](/images/gateway/telegram-bot/send-to-telegram-chain.png)

 - **Root Rule Chain：**

![image](/images/gateway/telegram-bot/root-rule-chain.png)

<br> 


以下章节说明如何从零修改该规则链。
<br> 

### 修改 **Create/Clear Alarm & Send Email**

#### 添加所需节点

在该规则链中，将创建 2 个节点，如下节所述：
 
##### 节点 A：**Transform Script**

- 添加 **Transform Script** 节点，并以 relation type **Created** 连接到 **Create Alarm** 节点。
 <br>该节点用于构建消息通知正文。
 <br>正文模板需包含 2 个参数： 
  
   - chat_id；
  
   - text。
  
   出站消息示例：
  
```json
{"chat_id" : "PUT YOUR CHOSEN CHAT_ID", "text" : "SOME MESSAGE YOU WANT TO RECEIVE"}
```
  
 - 使用以下脚本实现： 
 
 {% highlight javascript %}
 var newMsg ={};
 newMsg.text = '"' +  msg.name + '"' + " alarm was created for device: " + '"' + metadata.deviceName + '"';
 newMsg.chat_id = 337878729; //has to be replaced by the actual chat id
 return {msg: newMsg, metadata: metadata, msgType: msgType};{% endhighlight %}
      
- 在 Name 字段填入 **New telegram message**。  
  
![image](/images/gateway/telegram-bot/transform-script.png)
   
##### 节点 B：**REST API Call**
- 添加 **REST API Call** 节点，并以 relation type **Success** 连接到 **Transform Script** 节点。
  <br>该节点将完整 Message payload 发送到配置的 REST 端点。本例中为 Telegram REST API。
  <br>本教程将使用 **'/sendMessage'** 作为 Telegram Bot API 的 action path 来发送消息。

  
- 按下表填写各字段： 
  
  <table>
    <thead>
        <tr>
            <td><b>字段</b></td><td><b>输入数据</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Name</td>
            <td>REST API telegram Call</td>
        </tr>
        <tr>
            <td>Endpoint URL pattern</td>
            <td>https://api.telegram.org/bot"YOUR_BOT_TOKEN"/sendMessage</td>
        </tr>
        <tr>
            <td>Request method</td>
            <td>POST</td>
        </tr>
        <tr>
            <td>Header</td>
            <td>Content-Type</td>
        </tr>
        <tr>
            <td>Value</td>
            <td>application/json</td>
        </tr>
     </tbody>
  </table>

![image](/images/gateway/telegram-bot/rest-api-telegram-node.png)


## 发布 telemetry 并验证

发布设备 telemetry 将使用 REST API：[Telemetry upload APIs](/docs/{{docsPrefix}}reference/http-api/#telemetry-upload-api)。为此需从设备 **Thermostat Home** 复制设备访问令牌。 

![image](/images/gateway/telegram-bot/copy-token.png)


发布 temperature = 99。此时应创建 alarm：

{% highlight bash %}
curl -v -X POST -d '{"temperature":99}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"

**需将$ACCESS_TOKEN替换为实际设备令牌**
{% endhighlight %}

需注意，alarm 更新时不会向 Telegram App 发送消息，仅在 alarm 创建时会发送。 

最后，可确认消息已正确接收：

- 第一种方式：

![image](/images/gateway/telegram-bot/msg-received-first-way.png)


- 第二种方式： 

![image](/images/gateway/telegram-bot/msg-received-second-way.png)


此外，您可以：

  - 在 Create 和 Clear Alarm 节点中配置 Alarm Details 功能。

  - 在 Dashboard 中添加 alarm 部件以可视化 alarm。

  - 定义其他 alarm 处理逻辑，例如发送电子邮件。

请参阅 **See Also** 部分的链接了解具体操作。

<br>

## 参见

- [Create & Clear Alarms: alarm details](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#step-2-createupdate-alarm) 指南 — 了解如何在 Alarm 节点中配置 Alarm Details 功能

- [Create & Clear Alarms: configure dashboard](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#configure-device-and-dashboard) 指南 — 了解如何向 dashboard 添加 Alarm 部件

- [Send Email](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 教程

## 下一步

{% assign currentGuide = "HardwareSamples" %}{% include templates/multi-project-guides-banner.md %}
