---
layout: docwithnav-mqtt-broker
title: MQTT 集成
description: TBMQ MQTT 集成指南

add-mqtt-integration:
  0:
    image: /images/mqtt-broker/user-guide/ui/add-http-integration-1.png
    title: '进入「集成」页面，点击「+」图标添加新集成。'
  1:
    image: /images/mqtt-broker/user-guide/ui/add-mqtt-integration-2.png
    title: '选择「MQTT」作为集成类型并点击「Next」。'
  2:
    image: /images/mqtt-broker/user-guide/ui/add-mqtt-integration-3.png
    title: '将默认主题过滤器改为「tbmq/mqtt-integration」并点击「Next」。'
  3:
    image: /images/mqtt-broker/user-guide/ui/add-mqtt-integration-4.png
    title: '填写外部 broker 的「Host」「Port」「Credentials」和「Topic name」，然后点击「Add」。'

send-uplink-message:
  0:
    image: /images/mqtt-broker/user-guide/ui/send-uplink-message-1.png
    title: '进入「WebSocket 客户端」页面，选择可用连接后点击「Connect」。'
  1:
    image: /images/mqtt-broker/user-guide/ui/send-mqtt-message-2.png
    title: '将主题名设为「tbmq/mqtt-integration」，点击「Send」发布消息。'

---

{% include docs/mqtt-broker/integrations/mqtt.md %}
