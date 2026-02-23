---
layout: docwithnav-pe
title: CoAP 集成
description: CoAP 集成指南

coap-integration-setup:
    0:
        image: /images/user-guide/integrations/coap/coap-integration-setup-1-pe.png
        title: '进入 Integrations 部分，点击 Add new integration。命名为 CoAP Integration，选择类型 COAP。'
    1:
        image: /images/user-guide/integrations/coap/coap-integration-setup-2-pe.png
        title: '添加刚创建的 CoAP Uplink Converter。'
    2:
        image: /images/user-guide/integrations/coap/coap-integration-setup-3-pe.png
        title: '复制 CoAP endpoint URL，后续将在 coap-client 中用于测试 CoAP 集成。点击「Add」创建集成。'

---
{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsTag="pe" %}
{% include docs/pe/user-guide/integrations/coap.md %}
