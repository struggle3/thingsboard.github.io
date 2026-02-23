---
layout: docwithnav-pe 
title: ChirpStack 集成
description: ChirpStack 集成指南 

api-keys:
    0:
        image: /images/user-guide/integrations/chirpstack/chirpstack-api-key-1.png
        title: '进入 "API keys" 页面，点击 "Add API key"；'
    1:
        image: /images/user-guide/integrations/chirpstack/chirpstack-api-key-2.png
        title: '输入 API key 名称，点击 "Submit"；'
    2:
        image: /images/user-guide/integrations/chirpstack/chirpstack-api-key-3.png
        title: 'API key 已创建。复制 API token。'

configure-chirpstack-integration:
    0:
        image: /images/user-guide/integrations/chirpstack/chirpstack-configure-integration-1.png
        title: '在 ChirpStack Network server 用户界面左侧菜单进入 "Applications" 页面，点击 "Add application" 按钮；'
    1:
        image: /images/user-guide/integrations/chirpstack/chirpstack-configure-integration-2.png
        title: '命名后点击 "Submit" 按钮；'
    2:
        image: /images/user-guide/integrations/chirpstack/chirpstack-configure-integration-3.png
        title: 'Application 已创建。现在进入 "Integrations" 选项卡；'
    3:
        image: /images/user-guide/integrations/chirpstack/chirpstack-configure-integration-4.png
        title: '点击 "+" 图标找到并添加 "HTTP" integration；'
    4:
        image: /images/user-guide/integrations/chirpstack/chirpstack-configure-integration-5.png
        title: '在字段中填入此前从 ThingsBoard 中 ChirpStack integration 复制的 "HTTP endpoint URL"。然后点击 "Submit" 按钮；'
    5:
        image: /images/user-guide/integrations/chirpstack/chirpstack-configure-integration-6.png
        title: 'HTTP integration 已创建。'

device:
    0:
        image: /images/user-guide/integrations/chirpstack/device-created-1-pe.png
        title: '当设备发送 uplink 消息时，ThingsBoard 用户界面中会出现新设备。'

uplink-message-in-integration:
    0:
        image: /images/user-guide/integrations/chirpstack/integration-uplink-message-event-1.png
        title: '您将在 ChirpStack integration 中收到 uplink 事件。'
    1:
        image: /images/user-guide/integrations/chirpstack/integration-uplink-message-event-2.png
        title: ''

uplink-converter-events:
    0:
        image: /images/user-guide/integrations/chirpstack/converter-event-1-pe.png
        title: '可在 uplink converter 的 "Events" 选项卡的 "In" 和 "Out" 块中查看接收数据；'
    1:
        image: /images/user-guide/integrations/chirpstack/converter-event-2-pe.png
        title: '从 ChirpStack 传入 converter 的数据'
    2:
        image: /images/user-guide/integrations/chirpstack/converter-event-3-pe.png
        title: 'converter 传出数据。'

solution-templates:
    0:
        image: /images/user-guide/integrations/http/http-solution-templates.png
        title: 'converter 传出数据。'

downlink-rule-chain:
    0:
        image: /images/user-guide/integrations/chirpstack/import-downlink-rule-chain-1.png
        title: '进入 "Rule Chains" 页面。要导入此 JSON 文件，点击屏幕右上角 "+" 图标并选择 "Import rule chain"。将下载的 JSON 文件拖入导入 rule chain 窗口。点击 "Import"；'
    1:
        image: /images/user-guide/integrations/chirpstack/import-downlink-rule-chain-2.png
        title: '"Downlink to Chirpstack" rule chain 将打开。双击 "integration downlink" 节点；'
    2:
        image: /images/user-guide/integrations/chirpstack/import-downlink-rule-chain-4.png
        title: '在 "Integration" 字段中指定 ChirpStack integration；' 
    3:
        image: /images/user-guide/integrations/chirpstack/import-downlink-rule-chain-5.png
        title: '点击对勾保存 rule chain。'

root-rule-chain:
    0:
        image: /images/user-guide/integrations/chirpstack/edit-root-rule-chain-1.png
        title: '打开 "Root Rule Chain"，找到 "check relation presence" 节点；'
    1:
        image: /images/user-guide/integrations/chirpstack/edit-root-rule-chain-2.png
        title: '将其拖入 rule chain。命名为 "Check relation to ChirpStack integration"，选择方向 "To originator"，指定 relation type "ManagedByOriginator"。指定 ChirpStack integration 并点击 "Add"；'
    2:
        image: /images/user-guide/integrations/chirpstack/edit-root-rule-chain-3.png
        title: '点击 "message type switch" 节点右侧灰色圆圈，拖至 "check relation presence" 节点左侧。在此添加 "Attributes Updated" 链接，点击 "Add"；'
    3:
        image: /images/user-guide/integrations/chirpstack/edit-root-rule-chain-4.png
        title: '找到 "rule chain" 节点；'
    4:
        image: /images/user-guide/integrations/chirpstack/edit-root-rule-chain-5.png
        title: '将其拖入 rule chain。命名为 "Downlink to Chirpstack"，指定 "Downlink to Chirpstack" rule chain，点击 "Add"；'
    5:
        image: /images/user-guide/integrations/chirpstack/edit-root-rule-chain-6.png
        title: 'Tap on the right grey circle of the "check relation presence" node and drag this circle to left side of “rule chain” node. Here, select the "True" link, and click "Add". Finally, save Root Rule Chain.'

add-shared-attribute:
    0:
        image: /images/user-guide/integrations/chirpstack/add-shared-attribute-1.png
        title: '进入 "Devices" 页面。选择设备并进入 "Attributes" 选项卡。选择 "Shared attributes" 并点击 "plus" 图标添加新属性。然后输入属性名和值（例如 key 为 &#39;downlink&#39;，value 为 &#39;01040203&#39;）并点击 "Add"。'

downlink-events:
    0:
        image: /images/user-guide/integrations/chirpstack/downlink-event-1.png
        title: '可在 downlink converter 的 "Events" 选项卡的 "In" 和 "Out" 块中查看接收数据；'
    1:
        image: /images/user-guide/integrations/chirpstack/downlink-event-2.png
        title: '传入 downlink converter 的输入数据；'
    2:
        image: /images/user-guide/integrations/chirpstack/downlink-event-3.png
        title: 'downlink converter 输出数据。'

---
{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsTag="pe" %}
{% include docs/pe/user-guide/integrations/chirpstack.md %}