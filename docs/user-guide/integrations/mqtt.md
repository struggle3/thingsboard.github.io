---
layout: docwithnav-pe
title: MQTT 集成
description: MQTT 集成指南
create_dashboard:
    0:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-1-pe.png
        title: '进入 Dashboards 页面，创建名为 MQTT RPC 的仪表板并打开；'
    1:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-2-pe.png
        title: '点击右上角 Entity Aliases 图标添加别名。命名别名（如 Sensor），选择筛选类型「Single Entity」、类型「Device」，选择 SN-001 传感器。点击 Add 再 Save；'
    2:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-4-pe.png
        title: '点击 Add New Widget；'
    3:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-5-pe.png
        title: '从下拉菜单选择 Control Widgets；'
    4:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-6-pe.png
        title: '选择 Knob Control 部件；'
    5:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-7-pe.png
        title: '在 Data 字段选择创建的别名（Sensor）。将 Number of digits after floating point 设为 0；'
    6:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-8-pe.png
        title: '进入 Advanced 标签，将 Minimum value 设为 15、Maximum value 设为 45，其余保持默认。点击 Add 创建部件；'
    7:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-9-pe.png
        title: '保存仪表板更改。'

edit_rule_node:
    0:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-edit-message-type-switch-1-pe.png
    1:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-edit-message-type-switch-2-pe.png
    2:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-edit-message-type-switch-3-pe.png

incoming_messages:
    0:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-incoming-messages-2-pe.png
    1:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-incoming-messages-3-pe.png

add_rule_node:
    0:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-integration-downlink-node-1-pe.png
    1:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-integration-downlink-node-2-pe.png
    2:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-integration-downlink-node-3-pe.png

---
{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsTag="pe" %}
{% include docs/pe/user-guide/integrations/mqtt.md %}
