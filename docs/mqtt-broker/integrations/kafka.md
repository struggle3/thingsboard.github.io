---
layout: docwithnav-mqtt-broker
title: Kafka 集成
description: TBMQ Kafka 集成指南

add-kafka-integration:
  0:
    image: /images/mqtt-broker/user-guide/ui/add-http-integration-1.png
    title: '进入「集成」页面，点击「+」图标添加新集成。'
  1:
    image: /images/mqtt-broker/user-guide/ui/add-kafka-integration-2.png
    title: '选择「HTTP」作为集成类型并点击「Next」。'
  2:
    image: /images/mqtt-broker/user-guide/ui/add-http-integration-3.png
    title: '点击「Next」订阅默认主题「tbmq/#」。'

kafka-integration-docker:
  0:
    image: /images/mqtt-broker/user-guide/ui/add-kafka-integration-4.png
    title: '指定要连接的 bootstrap 服务器，如需要可添加其他属性键值对。'

kafka-integration-cloud-server:
  0:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-server-1.png
  1:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-server-2.png

kafka-integration-cloud-properties:
  0:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-properties-1.png
  1:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-properties-2.png
  2:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-properties-3.png
  3:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-properties-4.png

kafka-integration-cloud-topic:
  0:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-topic-1.png
  1:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-topic-2.png
  2:
    image: /images/mqtt-broker/user-guide/ui/kafka-integration-cloud-topic-3.png

send-uplink-message-kafka:
  0:
    image: /images/mqtt-broker/user-guide/ui/send-uplink-message-1.png
    title: '进入「WebSocket 客户端」页面，选择可用连接后点击「Connect」。'
  1:
    image: /images/mqtt-broker/user-guide/ui/send-uplink-message-kafka-1.png
    title: '将主题名设为「tbmq/kafka-integration」，点击「Send」发布消息。'
  2:
    image: /images/mqtt-broker/user-guide/ui/send-uplink-message-kafka-2.png
    title: '在 Confluent Cloud 中打开 Topics 并点击主题「tbmq.messages」。'
  3:
    image: /images/mqtt-broker/user-guide/ui/send-uplink-message-kafka-3.png
    title: 'The message from the TBMQ Kafka integration should be available in the messages table.'

---

{% include docs/mqtt-broker/integrations/kafka.md %}
