---
layout: docwithnav-mqtt-broker
title: TBMQ 入门
description: TBMQ - 面向真实使用场景的 broker

broker-sessions:
    0:
        image: /images/mqtt-broker/getting-started/broker-session.png
        title: '进入会话页面。查看所有客户端会话，点击行以打开会话详情'
    1:
        image: /images/mqtt-broker/getting-started/broker-session-details.png
        title: '查看客户端会话详情'

broker-mqtt-creds-creation:
    0:
        image: /images/mqtt-broker/getting-started/add-mqtt-creds-1.png
        title: '进入 Authentication > Credentials 页面，点击表格右上角的 "+"'
    1:
        image: /images/mqtt-broker/getting-started/add-mqtt-creds-2.png
        title: '输入凭据名称。例如 "Getting Started Credentials"'
    2:
        image: /images/mqtt-broker/getting-started/add-mqtt-creds-3.png
        title: '输入 "username" 和 "password" 的值，点击 "Add" 保存凭据'
    3:
        image: /images/mqtt-broker/getting-started/add-mqtt-creds-4.png
        title: '添加凭据后，将打开 "Check Connectivity" 窗口，其中包含用于订阅 topic 或发布消息的自动生成命令'
        
check-connectivity:
  0:
    image: /images/mqtt-broker/getting-started/gs-check-connectivity-1.png
    title: '进入 Authentication > Credentials 页面，找到 "Getting Started Credentials" 凭据并点击该行'
  1:
    image: /images/mqtt-broker/getting-started/gs-check-connectivity-2.png
    title: '点击 "Check connectivity" 按钮'
  2:
    image: /images/mqtt-broker/getting-started/gs-check-connectivity-3.png
    title: '选择您的操作系统，安装所需工具，并复制 MQTT 命令以供后续使用'

---

{% assign tbmqSuffix = "CE" %}
{% assign tbmqSuffixLc = "ce" %}
{% include docs/mqtt-broker/getting-started.md %}
