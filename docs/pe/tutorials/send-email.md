---
layout: docwithnav-pe
assignees:
- stitenko
title: 告警时发送邮件
description: 发送邮件工作流

add-recipients:
    0:
        image: /images/tutorials/send-email/send-email-add-recipients-1-pe.png
        title: '指定通知接收人。'

add-template:
    0:
        image: /images/tutorials/send-email/send-email-add-template-1-pe.png
        title: '选择递送方式。'
    1:
        image: /images/tutorials/send-email/send-email-add-template-2-pe.png
        title: '定义通知内容。'

add-rule:
    0:
        image: /images/tutorials/send-email/send-email-add-rule-1-pe.png
        title: '指定触发器、模板及通知接收人。'
    1:
        image: /images/tutorials/send-email/send-email-add-rule-2-pe.png
        title: '配置触发条件。'

verification:
    0:
        image: /images/tutorials/send-email/send-email-verification-1.png
        title: '邮件通知已发送给客户 A 的所有用户。'
    1:
        image: /images/tutorials/send-email/send-email-verification-2.png
        title: '邮件包含设备名称和上报的温度值。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/tutorials/send-email.md %}