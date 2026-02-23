---
layout: docwithnav-pe
title: Azure Event Hub 集成
description: Azure Event Hub 集成指南

create_eventhub: 
    0: 
        image: /images/azure-event-hub/create_a_resource.png
        title: '在 Azure 门户中，点击 "Create a resource" 按钮；'
    1:
        image: /images/azure-event-hub/select_iot_hub.png
        title: '在搜索框中输入 "IoT Hub" 并从列表中选择匹配项；'
    2:
        image: /images/azure-event-hub/create_iot_hub.png
        title: '点击 "Create"；'
    3:
        image: /images/azure-event-hub/basics_iot_hub.png
        title: '在配置页面，点击 "Create new"，指定资源组和 IoT hub 名称，然后点击 "Review + create"；'
    4:
        image: /images/azure-event-hub/create_basics_iot_hub.png
        title: '在下一页，点击 "Create"；'
    5:
        image: /images/azure-event-hub/deployment_is_in_progress.png
        title: '等待部署流程完成；'
    6:
        image: /images/azure-event-hub/go_to_resource.png
        title: '点击 "Go to resource"。'

create_device:
    0:
        image: /images/azure-event-hub/iot_devices.png
        title: '从上下文菜单进入 "IoT devices" 页面；'
    1:
        image: /images/azure-event-hub/iot_devices_new.png
        title: '点击 "+ New" 按钮；'
    2:
        image: /images/azure-event-hub/save_device_id.png
        title: '在弹窗中输入 "Device ID" 并点击 "Save"；'
    3:
        image: /images/azure-event-hub/your_devices.png
        title: '完成！已成功创建新设备。'

container:
    0:
        image: /images/user-guide/integrations/azure-event-hub/container-1.png
        title: '在 Azure 门户中，点击 "Storage account"；'
    1:
        image: /images/user-guide/integrations/azure-event-hub/container-2.png
        title: '进入 "Data storage" 部分的 "Containers" 页面。在此找到 container 并保存其名称。'

connection-string:
    0:
        image: /images/user-guide/integrations/azure-event-hub/storage-connection-string-1.png
        title: '要查找 storage connection string 值，请进入 "Security + networking" 部分的 "Access keys" 页面。'

event-hub-compatible-endpoint:
    0:
        image: /images/azure-event-hub/built_in_endpoints.png
        title: '在 Azure 门户中，导航至 "IoT Hub" 资源，从上下文菜单打开 "Built-in endpoints" 页面；'
    1:
        image: /images/azure-event-hub/event_hub_compatible_endpoint.png
        title: '复制并保存 "Event Hub-compatible endpoint" 值。'

rule-chain-generator-node:
    0: 
        image: /images/user-guide/integrations/azure-event-hub/test-azure-event-hub-integration-1-pe.png
        title: '进入 "<b>Rule chains</b>" 页面并选择其中一个 rule chain。在搜索节点框中输入 &#39;gen&#39; 以在菜单中找到 <b>generator</b> 节点。将其拖至画布。在弹窗中指定 generator 的 <b>name</b>、<b>number of messages</b> 和 <b>generate function</b>（可使用我们的示例）。最后点击 "<b>Add</b>"；'

primary-key:
    0: 
        image: /images/azure-event-hub/your_devices.png
        title: '现在查找设备的 <b>Primary key</b>。进入 Azure 门户，导航至 <b>IoT devices</b> 选项卡，选择设备；'
    1: 
        image: /images/azure-event-hub/primary_key.png
        title: '找到 "<b>Primary key</b>" 字段。复制并保存以备后用。'

rule-chain-iot-node:
    0:
        image: /images/user-guide/integrations/azure-event-hub/test-azure-event-hub-integration-2-pe.png
        title: '返回 ThingsBoard 实例。我们需找到另一个 rule node。在搜索节点框中输入 &#39;iot&#39; 并选择 <b>azure iot hub</b> 节点。将其拖至画布。在弹窗中指定 <b>node name</b>，将 <b>Topic</b> 中的 <b>&#60;device_id&#62;</b> 替换为 Device Name，并从 Azure 门户的 "<b>IoT Hub</b>" 资源获取 <b>Hostname</b> 填入。将 Device Name 作为 <b>Device ID</b> 填入，并添加此前从设备凭证复制的 <b>SAS Key</b>（<b>Primary Key</b>）。如需监控事件，请启用 Debug mode；'

link-generator-iot-nodes:
    0:
        image: /images/user-guide/integrations/azure-event-hub/test-azure-event-hub-integration-3-pe.png
        title: '将 <b>generator</b> 连接到 <b>azure iot hub</b>。点击 "<b>generator</b>" 节点右侧灰色圆圈，拖至 <b>azure iot hub</b> 节点左侧。选择 "<b>Success</b>" 链接并点击 "<b>Add</b>"。<b>Save</b> rule chain 后前往 integration；'

event-uplink:
    0:
        image: /images/user-guide/integrations/azure-event-hub/test-azure-event-hub-integration-4-pe.png
        title: '进入 "<b>Integrations</b>" 页面并选择您的 <b>Azure Event Hub integration</b>。若在 integration 的 "Events" 部分看到 "Uplink" 类型消息，则配置正常。'

event-hub-compatible-name:
    0:
        image: /images/azure-event-hub/event_hub_compatible_name.png
        title: '打开 Azure 门户并导航至 "IoT Hub" 资源。从上下文菜单进入 "Built-in endpoints" 页面。查找并复制 "Event Hub-compatible name" 的值——即 IoT Hub 名称。'

adding-downlink-converter:
    0:
        image: /images/user-guide/integrations/azure-event-hub/adding-azure-event-hub-downlink-converter-1-pe.png
        title: '进入 "Integrations" 页面，选择 Azure Event Hub integration 打开详情，点击 "pencil" 图标进入编辑模式；'
    1:
        image: /images/user-guide/integrations/azure-event-hub/adding-azure-event-hub-downlink-converter-2-pe.png
        title: '为 downlink data converter 命名并点击 "Create new converter"；'
    2:
        image: /images/user-guide/integrations/azure-event-hub/adding-azure-event-hub-downlink-converter-3-pe.png
        title: '将所需脚本粘贴到 Encoder function 部分。点击 "Add"；'
    3:
        image: /images/user-guide/integrations/azure-event-hub/adding-azure-event-hub-downlink-converter-4-pe.png
        title: '在高级设置中，在对应字段添加 "IoT Hub name"。点击 "Apply changes" 保存配置。'

device_groups_all:
    0:
        image: /images/azure-event-hub/device_groups_all_device profile.png
    1:
        image: /images/azure-event-hub/device_profiles_rule_chain.png
        

downlink_rule_node:
    0:
        image: /images/azure-event-hub/add_rule_node_integration_downlink.png
    1:
        image: /images/azure-event-hub/rule_chain_attributes_updated_and_downlink.png

device_last_part:
    0:
        image: /images/azure-event-hub/add_shared_attributes.png
    1:
        image: /images/azure-event-hub/integrations_events_downlink.png

advanced_testing:
    0:
        image: /images/azure-event-hub/iot_integration_first.png
    1:
        image: /images/azure-event-hub/iot_integration_second.png
    2:
        image: /images/azure-event-hub/uplink_received.png
    3:
        image: /images/azure-event-hub/uplink_message.png

downlink_result:
    0:
        image: /images/azure-event-hub/azure_cloud_to_device_message_count.png

solution_templates:
    0:
        image: /images/user-guide/integrations/use-solution-templates.png

---
{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsTag="pe" %}
{% include docs/pe/user-guide/integrations/azure-event-hub.md %}
