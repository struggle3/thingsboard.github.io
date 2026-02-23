---
layout: docwithnav-pe
title: OPC-UA 集成
description: OPC-UA 集成指南

create_rule_chain:
    0:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-1.png
        title: '下载 airconditioners.json 文件。进入 "Rule Chains" 页面。要导入此 JSON 文件，点击屏幕右上角的 "+" 图标并选择 "Import rule chain"；'
    1:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-2.png
        title: '双击 "integration downlink" 节点；'
    2:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-3.png
        title: '在 integration 字段中指定 "OPC-UA Integration"；'
    3:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-4.png
        title: '应用所有更改。'

create_rule_chain_2:
    0:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-5.png
        title: '打开 "Root Rule Chain"；'
    1:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-7.png
        title: '添加 "rule chain" 节点。将其命名为 "Airconditioners"，选择我们的 "Airconditioners" rule chain 并点击 "Add"；'
    2:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-8.png
        title: '点击 "message type switch" 节点右侧的灰色圆圈，将其拖至 "rule chain" 节点左侧。在此选择 "Attributes Updated"、"Post telemetry" 和 "RPC Request to Device"。然后点击 "Add" 并保存 rule chain。'

---
{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsTag="pe" %}
{% include docs/pe/user-guide/integrations/opc-ua.md %}
