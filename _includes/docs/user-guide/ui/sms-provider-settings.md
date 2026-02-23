* TOC
{:toc}

ThingsBoard 系统管理员可配置 SMS 提供商，供 SMS 网关向客户或用户发送短信。
例如，当传感器检测到异常时可向用户发送 SMS 告警。

{% unless docsPrefix == null %}
在 tenant administrator 级别，可使用系统管理员的 SMS 提供商设置或输入自有设置。
{% endunless %}

Tenant administrator 可配置 [**sms rule node**](/docs/user-guide/rule-engine-2-0/nodes/external/send-sms/) 以分发 [**rule engine**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 产生的告警。

在 ThingsBoard 中配置 SMS 提供商，请按下列步骤操作：

{% include images-gallery.html imageCollection="smsProviderSettings" showListImageTitles="true" %}

<br>
请参阅 [AWS SNS](https://docs.aws.amazon.com/sns/latest/dg/sms_publish-to-phone.html)、[Twilio](https://www.twilio.com/docs/sms) 或 [SMPP](https://smpp.org/) 文档，以了解如何搭配对应系统使用。
