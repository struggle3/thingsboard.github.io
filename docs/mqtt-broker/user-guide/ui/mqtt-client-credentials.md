---
layout: docwithnav-mqtt-broker
title: MQTT 客户端凭证
description: MQTT 客户端凭证界面

add-client-credentials:
  0:
    image: /images/mqtt-broker/user-guide/ui/add-client-credentials-1.png
    title: '进入凭证页面，点击「+」图标添加客户端凭证。'
  1:
    image: /images/mqtt-broker/user-guide/ui/add-client-credentials-2.png
    title: '填写名称、凭证类型。'
  2:
    image: /images/mqtt-broker/user-guide/ui/add-client-credentials-3.png
    title: 'Fill in the Authentication settings.'
  3:
    image: /images/mqtt-broker/user-guide/ui/add-client-credentials-4.png
    title: 'Set Authorization rules.'

change-password-basic-credentials:
  0:
    image: /images/mqtt-broker/user-guide/ui/change-password-1.png
    title: 'Go to the Credentials page, click on the corresponding row and click the Edit button.'
  1:
    image: /images/mqtt-broker/user-guide/ui/change-password-2.png
    title: 'Click the Change password button.'
  2:
    image: /images/mqtt-broker/user-guide/ui/change-password-3.png
    title: 'Input your current password and set a new one. Click the Change password button'

delete-client-credentials:
  0:
    image: /images/mqtt-broker/user-guide/ui/delete-credentials-1.png
    title: 'Delete single. Click on the icon "Delete".'
  1:
    image: /images/mqtt-broker/user-guide/ui/delete-credentials-2.png
    title: 'Delete mulptiple. Click on the checkboxes and confirm action by clicking on the button "Delete" in the top right corner.'

check-connectivity:
  0:
    image: /images/mqtt-broker/user-guide/ui/check-connectivity-1.png
    title: 'Click on the button "Check connectivity" of the Basic client credentials.'
  1:
    image: /images/mqtt-broker/user-guide/ui/check-connectivity-2.png
    title: 'Select your operating system, install required tools, and copy commands.'
    
security-authentication-tls:
  1:
    image: /images/mqtt-broker/features/security-authentication-tls-2.png
    title: 'TLS authentication with "Use certificate CN regex" disabled to match certificate common name by exact match.'
  2:
    image: /images/mqtt-broker/features/security-authentication-tls-3.png
    title: 'TLS authentication with "Use certificate CN regex" enabled to match certificate common name using a regex pattern.'

---

{% include docs/mqtt-broker/user-guide/ui/mqtt-client-credentials.md %}
