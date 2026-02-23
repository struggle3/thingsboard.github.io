---
layout: docwithnav-mqtt-broker
title: HTTP 集成
description: TBMQ HTTP 集成指南

tb-endpoint-url:
  0:
    image: /images/mqtt-broker/user-guide/ui/tb-endpoint-url-1.png
    title: '在 ThingsBoard Cloud 实例中进入「集成」页面并打开 HTTP 集成详情，启用调试模式并复制「HTTP endpoint URL」。'
    
add-http-integration:
  0:
    image: /images/mqtt-broker/user-guide/ui/add-http-integration-1.png
    title: '进入「集成」页面，点击「+」图标添加新集成。'
  1:
    image: /images/mqtt-broker/user-guide/ui/add-http-integration-2.png
    title: '选择「HTTP」作为集成类型并点击「Next」。'
  2:
    image: /images/mqtt-broker/user-guide/ui/add-http-integration-3.png
    title: '点击「Next」订阅默认主题「tbmq/#」。'
  3:
    image: /images/mqtt-broker/user-guide/ui/add-http-integration-4.png
    title: '在「Endpoint URL」字段中粘贴来自 ThingsBoard Cloud HTTP 集成的 URL。'
  4:
    image: /images/mqtt-broker/user-guide/ui/add-http-integration-5.png
    title: '打开「高级设置」，将「Payload content type」设为 JSON，点击「Add」。'

send-uplink-message:
  0:
    image: /images/mqtt-broker/user-guide/ui/send-uplink-message-1.png
    title: '进入「WebSocket 客户端」页面，选择可用连接后点击「Connect」。'
  1:
    image: /images/mqtt-broker/user-guide/ui/send-uplink-message-2.png
    title: '将主题名设为「tbmq/http-integration」，点击「Send」发布消息。'
    
http-integration-result:
  0:
    image: /images/mqtt-broker/user-guide/ui/http-integration-result-1.png
    title: '打开 ThingsBoard Cloud HTTP 集成详情页。'
  1:
    image: /images/mqtt-broker/user-guide/ui/http-integration-result-2.png
    title: '进入「Events」标签页，TBMQ HTTP 集成的消息应出现在表格中（若在发布消息时已开启调试模式）。'

---

{% include docs/mqtt-broker/integrations/http.md %}
