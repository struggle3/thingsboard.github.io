---
layout: docwithnav-mqtt-broker
title: Basic 认证
description: Basic 认证

security-authentication-basic:
  0:
    image: /images/mqtt-broker/features/security-authentication-basic-1.png
    title: '复制 Basic 凭据 ID。'
  1:
    image: /images/mqtt-broker/features/security-authentication-basic-2.png
    title: 'Basic 认证凭据参数：Client ID、Username 和 Password。'

security-authorization-basic:
  0:
    image: /images/mqtt-broker/features/security-authorization-basic-1.png
    title: '允许向以 "country/" 开头的主题发布并订阅以 "city/" 开头的主题的规则示例。'

authentication-provider-control:
  0:
    image: /images/mqtt-broker/security/auth-providers/provider-home-switch.png
    title: '在首页的 Broker 设置卡片中切换认证提供者。'
  1:
    image: /images/mqtt-broker/security/auth-providers/provider-table-switch.png
    title: 'On the Authentication > Providers page, use the switch button in the table’s right column to enable or disable providers.'
  2:
    image: /images/mqtt-broker/security/auth-providers/basic-overview.png
    title: '打开认证 > 提供者页面，选择 Basic 行，点击「编辑」按钮配置提供者。'

tbmq-client-id-username-and-password:
  0:
    image: /images/mqtt-broker/security/auth-providers/basic/auth-client-id-username-and-password.png
    title: ''
    
tbmq-tls-client-id-username-and-password:
  0:
    image: /images/mqtt-broker/security/auth-providers/basic/tls-auth-client-id-username-and-password.png
    title: ''

---

{% include docs/mqtt-broker/security/authentication/basic.md %}
