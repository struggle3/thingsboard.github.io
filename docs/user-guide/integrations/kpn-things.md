---
layout: docwithnav-pe
title: KPN Things 集成
description: KPN Things 集成指南

kpn-create-integration:
    0:
        image: /images/user-guide/integrations/kpn/kpn-add-integration-1-pe.png
        title: '进入 "Integrations center" -> "Integrations" 页面，点击 "plus" 按钮创建新 integration。选择类型 "KPN Things"，点击 "Next"；'
    1:
        image: /images/user-guide/integrations/kpn/kpn-add-integration-2-pe.png
        title: '在此步骤选择 "Create new" uplink converter。新 converter 将包含转换传入数据所需代码，点击 "Next"；'
    2:
        image: /images/user-guide/integrations/kpn/kpn-add-integration-3-pe.png
        title: '在添加 downlink converter 步骤，可选取已创建的或新建 downlink converter。目前先将 "Downlink data converter" 字段留空，点击 "Skip"；'
    3:
        image: /images/user-guide/integrations/kpn/kpn-add-integration-4-pe.png
        title: '指定 base URL。请记录 "HTTP endpoint URL"，后续会用到。然后点击 "Add" 按钮。KPN Things integration 创建完成。'


kpn-things-configure-1:
    0:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-1-pe.png
        title: '进入 "Things manager" 选项卡，点击 "Add new device"；'
    1:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-2-pe.png
        title: '选择 "Device Simulator"，为设备设置名称，点击 "Add device" 按钮；'
    2:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-3-pe.png
        title: '在手机上安装并打开 "KPN Things Device simulator" 应用。按手机提示扫描此 QR 码。然后点击 "Add Network Info" 按钮；'
    3:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-4-pe.png
        title: 'KPN Internet Network 已创建。现在点击 "Finish" 按钮。'

kpn-things-configure-2:
    0:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-5-pe.png
        title: '在左侧菜单进入 "Flows"，点击 "My first flow" 行；'
    1:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-6-pe.png
        title: '在 "Devices" 行点击 "Link Device" 按钮；'
    2:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-7-pe.png
        title: '点击您之前创建的设备旁的 "Link" 按钮；'
    3:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-8-pe.png
        title: '设备已成功关联到 Flow。'

kpn-things-configure-3:
    0:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-9-pe.png
        title: '点击 "My Device" 行；'
    1:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-10-pe.png
        title: '"Device & Connectivity detail" 页面将打开。现在进入 "Flows" 选项卡，点击 "My first flow" 行；'
    2:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-11-pe.png
        title: '点击 "Data Processing" 行打开 "Data Processing details" 页面；'
    3:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-12-pe.png
        title: '将 "Decoders" 部分的开关切换为启用状态；'
    4:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-13-pe.png
        title: '更改已保存。'

kpn-things-configure-4:
    0:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-14-pe.png
        title: '在左侧菜单进入 "Destinations"，点击 "Add new Destination" 按钮；'
    1:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-15-pe.png
        title: '找到 "ThingsBoard" 目标类型，点击 "Choose ThingsBoard" 按钮；'
    2:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-16-pe.png
        title: '为 destination 设置名称。将 ThingsBoard integration 页面的 "HTTP endpoint URL" 粘贴到 "HTTP endpoint URL" 字段。点击 "Generate" 按钮并保存生成的值，我们将在 ThingsBoard 中使用。最后点击 "Add ThingsBoard Destination" 按钮。'

kpn-things-configure-5:
    0:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-17-pe.png
        title: '进入 "Flows" -> "My first flow"，在 "Destinations" 行点击 "Link Destination" 按钮；'
    1:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-18-pe.png
        title: '点击您之前创建的 destination 旁的 "Link" 按钮；'
    2:
        image: /images/user-guide/integrations/kpn/kpn-things-configure-19-pe.png
        title: '"Destination" 已成功关联到 Flow。'

kpn-update-integration:
    0:
        image: /images/user-guide/integrations/kpn/kpn-add-integration-5-pe.png
        title: '进入 "Integrations center" -> "Integrations" 页面，点击您之前创建的 integration。点击 "Edit" 按钮进入编辑模式。'
    1:
        image: /images/user-guide/integrations/kpn/kpn-add-integration-6-pe.png
        title: '将 "Enable security (Headers filter)" 开关切换为启用状态，在 "Headers filter" 部分点击 "Add" 按钮。'
    2:
        image: /images/user-guide/integrations/kpn/kpn-add-integration-7-pe.png
        title: '将 "X-Things-Secret" 填入 "Header" 字段，将生成的 token 填入 "Value" 字段。最后应用更改。'

kpn-send-data-now:
    0:
        image: /images/user-guide/integrations/kpn/kpn-send-data-now.png
        title: '使用 "KPN Things Device simulator" 应用将数据消息发送到 ThingsBoard。点击 "Send data now" 按钮。'
    
kpn-things-device:
    0:
        image: /images/user-guide/integrations/kpn/kpn-things-device-1-pe.png
        title: '进入 "Devices" 页面。此处可看到新的 KPN Device 及其信息，以及我们发送给设备的 telemetry。'

kpn-things-uplink:
  0:
    image: /images/user-guide/integrations/kpn/kpn-things-uplink-1-pe.png
    title: '进入 "Integrations" 页面，选择 "KPN Things integration" 并导航至 "Events" 选项卡。此处可看到 KPN Things integration 消费的消息。'

---
{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsTag="pe" %}
{% include docs/pe/user-guide/integrations/kpn-things.md %}