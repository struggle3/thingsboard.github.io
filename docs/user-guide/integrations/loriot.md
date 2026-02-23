---
layout: docwithnav-pe 
title: Loriot 集成
description: Loriot 集成指南

create-loriot-account:
    0:
        image: /images/user-guide/integrations/loriot/create-loriot-account-1.png
        title: '访问 Loriot 网站。选择服务套餐，例如选择 <b>Community Public Network Server</b>。'
    1:
        image: /images/user-guide/integrations/loriot/create-loriot-account-2.png
        title: '选择您偏好的区域和国家。'
    2:
        image: /images/user-guide/integrations/loriot/create-loriot-account-3.png
        title: '完成注册流程。'
    3:
        image: /images/user-guide/integrations/loriot/create-loriot-account-4.png
        title: '登录 Loriot 账户。'

create-loriot-application-output-1:
    0:
        image: /images/user-guide/integrations/loriot/loriot-server.png
        title: '打开 Loriot UI。URL 中包含注册时选择的 server 名称。此 server 需在 integration 设置中指定。'

create-loriot-application-output-2:
    0:
        image: /images/user-guide/integrations/loriot/loriot-application-id.png
        title: '找到与项目关联的 <b>Application ID</b>。此值需在 integration 设置中指定。'

create-loriot-application-output-3:
    0:
        image: /images/user-guide/integrations/loriot/thingsboard_add_integration_output_basic.png
        title: '选择 "Basic" 凭证类型并输入 Loriot 账户凭证。点击 "Add" 确认创建 integration。'

endpoint-url:
    0:
        image: /images/user-guide/integrations/loriot/loriot-copy-http-endpoint-pe.png
        title: '在 ThingsBoard 进入 "Integrations" 页面。找到 Loriot integration 并点击。此处可找到 "HTTP endpoint URL"。'

downlink_server:
    0:
        image: /images/user-guide/integrations/loriot/loriot-server.png
        title: '打开 Loriot UI。URL 中包含注册时选择的 server 名称。此 server 需在 integration 设置中指定。'

downlink_applications:
    0:
        image: /images/user-guide/integrations/loriot/loriot-application-id.png
        title: '找到与项目关联的 <b>Application ID</b>。此值需在 integration 设置中指定。'

access_token:
    0:
        image: /images/user-guide/integrations/loriot/loriot_access_tokens.png
    1:
        image: /images/user-guide/integrations/loriot/loriot_authentication_tokens.png
    2:
        image: /images/user-guide/integrations/loriot/loriot_and_thingsboard_integration_application_access_token.png

uplink-tbel:
    0:
        image: /images/user-guide/integrations/loriot/loriot-uplink-converters-1-tbel-pe.png

uplink-java:
    0:
        image: /images/user-guide/integrations/loriot/loriot-uplink-converters-1-java-pe.png

uplink-edit-tbel:
    0:
        image: /images/user-guide/integrations/loriot/loriot-uplink-edit-mode-tbel-1-pe.png
    1:
        image: /images/user-guide/integrations/loriot/loriot-uplink-edit-mode-tbel-2-pe.png
    2:
        image: /images/user-guide/integrations/loriot/loriot-uplink-edit-mode-tbel-3-pe.png

uplink-edit-java:
    0:
        image: /images/user-guide/integrations/loriot/loriot-uplink-edit-mode-java-1-pe.png 
    1:
        image: /images/user-guide/integrations/loriot/loriot-uplink-edit-mode-java-2-pe.png
    2:
        image: /images/user-guide/integrations/loriot/loriot-uplink-edit-mode-java-3-pe.png

create_downlink-tbel:
    0:
        image: /images/user-guide/integrations/loriot/loriot-downlink-converters-1-tbel-pe.png

create_downlink-java:
    0:
        image: /images/user-guide/integrations/loriot/loriot-downlink-converters-1-java-pe.png

downlink-tbel:
    0:
        image: /images/user-guide/integrations/loriot/loriot-downlink-save-changes-tbel-1-pe.png

downlink-java:
    0:
        image: /images/user-guide/integrations/loriot/loriot-downlink-save-changes-java-1-pe.png

devices:
    0:
        image: /images/user-guide/integrations/loriot/loriot_devices.png
    1:
        image: /images/user-guide/integrations/loriot/loriot_device_eui.png

send_downlink:
    0:
        image: /images/user-guide/integrations/loriot/thingsboard_add_integration_send_downlink.png

loriot-output:
    0:
        image: /images/user-guide/integrations/loriot/loriot-http-push-1.png
        title: '进入 "<b>Applications</b>" 页面并点击 application。'
    1:
        image: /images/user-guide/integrations/loriot/loriot-http-push-2.png
        title: '进入 "<b>Output</b>" 页面。'
    2:
        image: /images/user-guide/integrations/loriot/loriot-http-push-3.png
        title: '点击 "<b>Add new output</b>" 按钮。'
    3:
        image: /images/user-guide/integrations/loriot/loriot-http-push-4.png
        title: '将 output 类型选为 "<b>HTTP Push</b>"，输入从 integration 获取的 "<b>HTTP endpoint URL</b>"。然后点击 "<b>Add output</b>" 按钮。'
    4:
        image: /images/user-guide/integrations/loriot/loriot-http-push-5.png
        title: 'Output 创建成功。'

enable-security:
    0:
        image: /images/user-guide/integrations/loriot/enable-security-1-pe.png
        title: '为此，启用 "<b>Enable security</b>" 选项。点击 "<b>Add</b>"，为 "<b>Header</b>" 和 "<b>Value</b>" 字段输入任意值。然后保存更改。'
    1:
        image: /images/user-guide/integrations/loriot/enable-security-2-pe.png
        title: '还需在 Loriot UI 中指定此凭证。'

security_token:
    0:
        image: /images/user-guide/integrations/loriot/thingsboard_add_integration_output_security_token.png
    1:
        image: /images/user-guide/integrations/loriot/loriot_and_thingsboard_output_security_token_session.png

rule_chain:
    0:
        image: /images/user-guide/integrations/loriot/thingsboard_rule_chain_integration_downlink.png

shared_attributes:
    0:
        image: /images/user-guide/integrations/loriot/thingsboard_devices_all_shared_attributes.png
    1:
        image: /images/user-guide/integrations/loriot/thingsboard_devices_all_shared_attributes_update.png

event_in:
    0:
        image: /images/user-guide/integrations/loriot/thingsboard_downlink_converter_events_in.png


terminal:
    0:
        image: /images/user-guide/integrations/loriot/terminal.png

terminal_1:
    0:
        image: /images/user-guide/integrations/loriot/terminal_1.png

device:
    0:
        image: /images/user-guide/integrations/loriot/loriot-device-attributes-1-pe.png
        title: '可在 "Entities" 部分的 "Devices" 页面找到创建的设备及其数据。在 "Attributes" 选项卡可见设备发送给 ThingsBoard 的属性。'
    1:
        image: /images/user-guide/integrations/loriot/loriot-device-attributes-2-pe.png
        title: '在 "Latest telemetry" 选项卡可见设备发送给 ThingsBoard 的 telemetry 数据。'

uplink_events:
    0:
        image: /images/user-guide/integrations/loriot/loriot-uplink-converter-events-1-pe.png
        title: '可在 Uplink converter 的 "<b>Events</b>" 选项卡下，于 "<b>In</b>"、"<b>Out</b>" 和 "<b>Metadata</b>" 块中查看数据。'
    1:
        image: /images/user-guide/integrations/loriot/loriot-uplink-converter-events-2-pe.png
        title: '"Input" 块。'
    2:
        image: /images/user-guide/integrations/loriot/loriot-uplink-converter-events-3-pe.png
        title: '"Output" 块。'
    3:
        image: /images/user-guide/integrations/loriot/loriot-uplink-converter-events-4-pe.png
        title: '"Metadata" 块。'

event_out:
    0:
        image: /images/user-guide/integrations/loriot/thingsboard_downlink_converter_events_out.png
    
parameters:
    0:
        image: /images/user-guide/integrations/loriot/loriot_devices_downlink_queue.png

---
{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsTag="pe" %}
{% include docs/pe/user-guide/integrations/loriot.md %}

