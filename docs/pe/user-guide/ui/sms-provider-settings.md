---
layout: docwithnav-pe
assignees:
- ashvayka
title: SMS 提供商设置
description: ThingsBoard IoT 平台 SMS 提供商设置
smsProviderSettings:
    0:
        image: /images/user-guide/ui/sms/sms-provider-settings-step-2-pe.png
        title: '登录ThingsBoard UI。导航至"Settings"页面。然后进入"Notificatons"选项卡。在此窗口中选择可用提供商之一：AWS SNS、Twilio或SMPP；'
    1:
        image: /images/user-guide/ui/sms/sms-provider-settings-step-3-pe.png
        title: '若选择AWS SNS，请填写AWS Access Key ID和Secret access key。点击"Save"按钮；'
    2:
        image: /images/user-guide/ui/sms/sms-provider-settings-step-4-pe.png
        title: '若选择Twilio，请填写Twilio account SID和Token。指定将用作"sender"的电话号码。点击"Save"按钮；'
    3:
        image: /images/user-guide/ui/sms/sms-provider-settings-step-5-pe.png
        title: '若选择SMPP，请填写System ID和Password。指定SMPP版本、SMPP主机和端口。点击"Save"按钮。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ui/sms-provider-settings.md %}