---
layout: docwithnav-paas-eu
title: 工业设备健康 — 基于 AI 的 ThingsBoard 异常检测
description: 使用 Calculated Fields 和 Rule Engine AI 节点在 ThingsBoard 中进行预测性维护

import-calculated-field-into-profile:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/import-calculated-field-into-profile-1-pe.png
        title: '进入目标实体或配置文件的「<b>Calculated fields</b>」选项卡，点击「<b>加号</b>」图标按钮，从下拉菜单中选择「<b>Import calculated field</b>」。'
    1:
        image: /images/samples/analytics/ai-predictive-maintenance/import-calculated-field-into-profile-2-pe.png
        title: '在打开的窗口中，<b>上传</b>包含计算字段配置的 <b>JSON 文件</b>，然后点击「<b>Import</b>」。'
    2:
        image: /images/samples/analytics/ai-predictive-maintenance/import-calculated-field-into-profile-3-pe.png
        title: '确认导入的配置：导入时会打开编辑窗口以便修改，点击「<b>Add</b>」完成导入。'
    3:
        image: /images/samples/analytics/ai-predictive-maintenance/import-calculated-field-into-profile-4-pe.png
        title: '已导入计算字段配置。'

import-equipment-sensor-device-profile:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-sensor-device-profile-1-pe.png
        title: '进入「<b>Device profiles</b>」页面，点击「<b>加号</b>」图标按钮，从下拉菜单中选择「<b>Import device profile</b>」。'
    1:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-sensor-device-profile-2-pe.png
        title: '在打开的窗口中上传包含设备配置文件配置的 JSON 文件，然后点击「<b>Import</b>」。'
    2:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-sensor-device-profile-3-pe.png
        title: '已导入设备配置文件配置。'

import-equipment-health-analysis-rule-chain:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-health-analysis-rule-chain-1-pe.png
        title: '进入「<b>Rule chains</b>」页面，点击「<b>加号</b>」图标按钮，从下拉菜单中选择「<b>Import rule chain</b>」。'
    1:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-health-analysis-rule-chain-2-pe.png
        title: '在打开的窗口中上传包含规则链配置的 JSON 文件，然后点击「<b>Import</b>」。'
    2:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-health-analysis-rule-chain-3-pe.png
        title: '找到「<b>AI request</b>」节点并进入其<b>编辑模式</b>。'
    3:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-health-analysis-rule-chain-4-pe.png
        title: '点击「<b>Create new</b>」创建新 AI 模型。'
    4:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-health-analysis-rule-chain-5-pe.png
        title: '输入<b>AI 模型名称</b>、选择<b>AI 提供商</b>并粘贴<b>API key</b>。本示例使用 OpenAI 的 <b>o4-mini</b>。保存前点击<b>Test connectivity</b>验证，然后点击「<b>Save</b>」。'
    5:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-health-analysis-rule-chain-6-pe.png
        title: '对「AI request」节点<b>Apply changes</b>。'
    6:
        image: /images/samples/analytics/ai-predictive-maintenance/import-equipment-health-analysis-rule-chain-7-pe.png
        title: '<b>Save rule chain</b> 保存规则链。'
  
update-equipment-sensor-profile:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/update-equipment-sensor-profile-1-pe.png
        title: '进入「<b>Device profiles</b>」页面，点击「<b>EquipmentSensor</b>」配置文件并进入编辑模式。'
    1:
        image: /images/samples/analytics/ai-predictive-maintenance/update-equipment-sensor-profile-2-pe.png
        title: '将「<b>Equipment Health Analysis</b>」指定为默认规则链。'
    2:
        image: /images/samples/analytics/ai-predictive-maintenance/update-equipment-sensor-profile-3-pe.png
        title: ''

create-test-device-1:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/create-test-device-1-pe.png
        title: '进入「<b>Devices</b>」页面，点击「<b>加号</b>」图标按钮，从下拉菜单中选择「<b>Add new device</b>」。'
    1:
        image: /images/samples/analytics/ai-predictive-maintenance/create-test-device-2-pe.png
        title: '将设备命名为「<b>Equipment Sensor 1</b>」，设备配置文件设为「<b>EquipmentSensor</b>」，点击「<b>Add</b>」。'

create-test-device-2:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/create-test-device-3-paas-eu.png
        title: '复制<b>check connection</b>命令。'

check-connectivity-command-from-device:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/check-connectivity-command-from-device-1-paas-eu.png
        title: ''

send-test-data-no-alarm-case:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/send-test-data-no-alarm-case-1-pe.png
        title: '将以下测试数据发送到 ThingsBoard。请将 $YOUR_DEVICE_ACCESS_TOKEN 替换为设备的 access token。'

send-test-data-bearing-wear-detection:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/alarm-created-1-pe.png
        title: '通过发送以下测试数据到 ThingsBoard 模拟轴承磨损事件。请将 $YOUR_DEVICE_ACCESS_TOKEN 替换为设备的 access token。'

send-test-data-misalignment-detection:
    0:
        image: /images/samples/analytics/ai-predictive-maintenance/alarm-created-2-pe.png
        title: '通过发送以下测试数据到 ThingsBoard 模拟不对中事件。请将 $YOUR_DEVICE_ACCESS_TOKEN 替换为设备的 access token。'

---

{% assign docsPrefix = "paas/eu/" %}
{% include get-hosts-name.html docsTag="paas-eu" %}
{% include /docs/samples/analytics/ai-predictive-maintenance.md %}
