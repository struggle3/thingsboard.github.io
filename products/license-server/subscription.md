---
layout: docwithnav-license
assignees:
- ashvayka
title: ThingsBoard 订阅计划定义
description: 按需付费模式的功能与优势

---

 
 <div id="video">  
     <div id="video_wrapper">
         <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/dK-QDFGxWek" frameborder="0" allowfullscreen></iframe>
     </div>
 </div>
 <p></p>


ThingsBoars Inc. 为客户提供两种支付模式：订阅（按需付费）和永久备用。
**按需付费** 是一种计费体系，**ThingsBoard 专业版（TB PE）** 客户以时间为单位购买不同类型许可证（无按消息或按设备收取的额外费用）。换言之，此选项允许订阅 ThingsBoard PE 服务。
有五种预定义订阅计划，分别按设备和/或资产数量及支持优先级进行限制：

- ***Maker***
- ***Prototype***
- ***StartUp***
- ***Business***
- ***Enterprise***

按需付费订阅适合正在起步、希望尽量减少前期许可成本的小公司和初创企业。按需付费模式也适用于已成熟企业在开发和发布物联网解决方案时的需求。有关可用订阅的更多详情，请参见[定价](/pricing/)。
许可证服务器支持购买 ThingsBoard 的月度或年度订阅。要购买订阅，客户可在许可证门户注册，然后按以下步骤操作：
- 前往 ***订阅*** — ***选择产品*** — 选择计划 — 输入 ***账单信息*** — ***创建***

或直接从[定价](/pricing/)选择具体计划。点击 ***获取您的许可证*** 按钮后，您将被引导至许可证门户的认证/注册页面，或若您已登录许可证门户，则直接进入 ***账单信息*** 步骤。


默认情况下，订阅涵盖单个 ThingsBoard PE 实例（服务器进程）。但客户可以向同一订阅添加更多实例。这允许在单一服务器集群中启动使用同一订阅凭据的多个实例。
该功能对基于容器的部署非常有用。

![image](/images/license/manageInstance.png)  

购买订阅后，您可以灵活地升级或降级订阅计划。若订阅在到期前被删除，Stripe 将保留余额。一段时间后（约一小时），[许可证门户的账单部分](/products/license-server/billing-info/)会出现负数应付金额（***账户额度***）及剩余单位。该金额在客户购买新计划或永久许可证时从总费用中扣除。

![image](/images/license/subscription.png)
