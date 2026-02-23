
* TOC
{:toc}

本指南介绍如何配置 ThingsBoard，在创建告警时自动向用户发送邮件通知。   
通过 Notification Center 下发基于告警的邮件通知，扩展了 [创建与清除告警](/docs/{{docsPrefix}}tutorials/create-clear-alarms){:target="_blank"} 的使用场景。

<hr>

## 使用场景

假设制冷设备定期向 ThingsBoard 上报温度遥测。
- 正常工作温度范围：2 °C 至 5 °C
- 超出该范围的任何值均视为异常。

当满足该条件时：
- 告警规则将创建告警。
- 向责任人用户发送邮件通知。

该配置可及时感知设备问题并加快响应。

<hr>

## 前置条件

在继续前，请确保已完成以下步骤：
1. 完成 [创建与清除告警](/docs/tutorials/create-clear-alarms){:target="_blank"} 教程，已配置告警创建与清除规则。 
2. 至少添加一个 [Customer User](/docs/{{docsPrefix}}user-guide/ui/customers/#create-customer-user){:target="_blank"}，用于接收告警通知。
3. [配置邮件服务器](/docs/{{docsPrefix}}user-guide/ui/mail-settings/){:target="_blank"}，用于发送邮件通知。

建议先阅读以下 ThingsBoard 文档：
- [Notification center](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}：配置通知下发与接收人
- [告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules){:target="_blank"}：定义告警触发条件

这些概念对理解和正确配置下文的方案很重要。

<hr>

## 配置 Notification Center

Notification Center 负责向用户下发通知。

由三个核心部分组成：
- **Recipients**：定义接收通知的用户。
- **Templates**：定义通知内容和下发方式。
- **Rules**：定义发送通知的条件。

上述三部分均需配置才能启用基于告警的通知。

<hr>

### 步骤 1：配置通知接收人

**Recipients** 定义接收通知的目标用户。
1. 进入 **Notification Center &#8702; Recipients**。 
2. 点击 **&#43; Add recipient**。 
3. 配置接收人组：   
   &#8194;&#8226;&#8194;**Name**：Refrigeration operators   
   &#8194;&#8226;&#8194;**Type**：Platform users   
   &#8194;&#8226;&#8194;**User filter**：Customer users   
   &#8194;&#8226;&#8194;**Customer**：Customer A（请指定您的 customer）
4. 点击 **Add**。

**Customer A** 代表负责监控制冷设备的所有 customer 用户。

{% include images-gallery.html imageCollection="add-recipients" %}

<hr>

### 步骤 2：创建通知模板

**Templates** 定义通知内容和下发方式。
1. 进入 **Notification Center &#8702; Templates**。 
2. 点击 **&#43; Add template**。 
3. 配置通用设置：   
   &#8194;&#8226;&#8194;**Name**：Device temperature notification   
   &#8194;&#8226;&#8194;**Type**：Alarm   
   &#8194;&#8226;&#8194;**Delivery methods**：Email   
4. 点击 **Next**。 
5. 定义邮件内容：   
   &#8194;&#8226;&#8194;**Subject**
   ```text
   ${alarmType} on ${alarmOriginatorName} device
   ```
   {:.copy-code}
   &#8194;&#8226;&#8194;**Message**   
   ```text
   A ${alarmType} has been detected on the ${alarmOriginatorName} device: ${details.data} °C.
   ```
   {:.copy-code}
   模板变量：   
   &#8194;&#8226;&#8194;${alarmOriginatorName} – 触发告警的设备名称。   
   &#8194;&#8226;&#8194;${details.data} – 由告警规则填充的告警详情。
 6. 点击 **Add** 保存模板。

{% include images-gallery.html imageCollection="add-template" %}

<hr>

### 步骤 3：创建通知规则

通知 **Rules** 定义何时发送通知以及使用哪些组件。
1. 进入 **Notification Center &#8702; Rules**。 
2. 点击 **&#43; Add rule**。 
3. 配置规则参数：   
   &#8194;&#8226;&#8194;**Rule name**：Unacceptable device temperature   
   &#8194;&#8226;&#8194;**Trigger**：Alarm   
   &#8194;&#8226;&#8194;**Template**：Device temperature notification   
   &#8194;&#8226;&#8194;**Recipients**：Refrigeration operators
4. 点击 **Next**。
5. 配置触发条件：   
   &#8194;&#8226;&#8194;**Alarm type list**：Any type   
   &#8194;&#8226;&#8194;**Alarm severity list**：Any severity   
   &#8194;&#8226;&#8194;**Notify on**：Alarm created
6. 点击 **Add**。

此规则确保仅在创建新告警时发送邮件。

{% include images-gallery.html imageCollection="add-rule" %}

<hr>

## 验证

为验证配置，请上报超过设定温度阈值的遥测。

**发布测试遥测**   
示例：上报温度值 **7 °C**，以触发高温告警。
{% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:7}"
   ```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
   ```bash
curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:7}"
   ```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/eu/" %}
   ```bash
curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:7}"
   ```
{: .copy-code}
{% endif %}

⚠️ 请将 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;**$THINGSBOARD_HOST_NAME** 替换为您的 ThingsBoard 主机名或 IP 地址。   
&#8194;&#8226;&#8194;{% endunless %}**$ACCESS_TOKEN** 替换为设备访问令牌。

**预期结果**
- 为设备创建新告警。
- 向 Customer A 的所有用户发送邮件通知。
- 邮件包含设备名称和上报的温度值。

{% include images-gallery.html imageCollection="verification" %}

如未收到邮件，请检查垃圾邮件文件夹并确认邮件服务器配置。

> 仅在新创建告警时发送邮件通知，更新已有告警时不会发送。

<hr>

## 另请参阅

- [发送邮件给 customer](/docs/user-guide/rule-engine-2-0/tutorials/send-email-to-customer/) 指南。
- [设备离线时创建告警](/docs/user-guide/rule-engine-2-0/tutorials/create-inactivity-alarm/) 指南。
- [创建带详情的告警](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/) 指南。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}
