---
layout: docwithnav-mqtt-broker
title: 非持久化与持久化会话
description: MQTT 会话说明。

persistent-session-demo:
  0:
    image: /images/mqtt-broker/user-guide/ui/persistent-session-demo-1.png
    title: '在 WebSocket 客户端连接中：启用持久化会话（关闭 Clean Start），将 Session Expiry Interval 设为大于 0，点击「Connect」。'
  1:
    image: /images/mqtt-broker/user-guide/ui/persistent-session-demo-2.png
    title: '添加对主题「session/persistent」的订阅，QoS 1。'
  2:
    image: /images/mqtt-broker/user-guide/ui/persistent-session-demo-3.png
    title: 'Click the "Disconnect" button.'
  3:
    image: /images/mqtt-broker/user-guide/ui/persistent-session-demo-4.png
    title: 'Switch to another Client and publish several messages to the topic "session/persistent".'
  4:
    image: /images/mqtt-broker/user-guide/ui/persistent-session-demo-5.png
    title: 'Switch back to the "Persistent session demo" Client and click "Connect".'
  5:
    image: /images/mqtt-broker/user-guide/ui/persistent-session-demo-6.png
    title: 'After a successful connection, the Client receives the messages that were published while it was offline.'

---

{% include docs/mqtt-broker/user-guide/clean-persistent-sessions.md %}
