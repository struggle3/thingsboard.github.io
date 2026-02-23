---
layout: docwithnav-pe
assignees:
- ashvayka
title: 基础 MQTT 认证
description: ThingsBoard 基于 MQTT 的认证。

client-id-only-1:
    0:
        image: /images/user-guide/basic-mqtt/authentication-manage-credentials-1-pe.png
        title: '进入「设备」页面，点击设备打开详情窗口，再点击「管理凭据」按钮；'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-only-1-pe.png
        title: '在「设备凭据」窗口中，选择「MQTT Basic」凭据类型并填写 Client ID。点击「保存」。'

client-id-only-2:
    0:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-only-2-pe.png
        title: '点击「检查连接」按钮打开相应窗口；'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-only-3-pe.png
        title: '在打开的窗口中选择操作系统，并根据指南中的命令安装所需客户端工具。复制并运行命令以发布遥测数据；'
    2:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-only-4-pe.png
        title: '命令成功执行后，应能看到已发布的「temperature」读数。'

username-and-password-1:
    0:
        image: /images/user-guide/basic-mqtt/authentication-manage-credentials-1-pe.png
        title: '进入「设备」页面，点击设备打开详情窗口，再点击「管理凭据」按钮；'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-username-and-password-1-pe.png
        title: '在「设备凭据」窗口中，选择「MQTT Basic」凭据类型并填写用户名和密码。点击「保存」。'

username-and-password-2:
    0:
        image: /images/user-guide/basic-mqtt/authentication-based-on-username-and-password-2-pe.png
        title: '点击「检查连接」按钮打开相应窗口；'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-username-and-password-3-pe.png
        title: '在打开的窗口中选择操作系统，并根据指南中的命令安装所需客户端工具。复制并运行命令以发布遥测数据；'
    2:
        image: /images/user-guide/basic-mqtt/authentication-based-on-username-and-password-4-pe.png
        title: '命令成功执行后，应能看到已发布的「temperature」读数。'

client-id-username-and-password-1:
    0:
        image: /images/user-guide/basic-mqtt/authentication-manage-credentials-1-pe.png
        title: '进入「设备」页面，点击设备打开详情窗口，再点击「管理凭据」按钮；'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-1-pe.png
        title: '在「设备凭据」窗口中，选择「MQTT Basic」凭据类型并填写 Client ID、用户名和密码。点击「保存」。'

client-id-username-and-password-2:
    0:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-2-pe.png
        title: '点击「检查连接」按钮打开相应窗口；'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-3-pe.png
        title: '在打开的窗口中选择操作系统，并根据指南中的命令安装所需客户端工具。复制并运行命令以发布遥测数据；'
    2:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-4-pe.png
        title: '命令成功执行后，应能看到已发布的「temperature」读数。'

mqtts-options-1:
    0:
        image: /images/user-guide/basic-mqtt/authentication-manage-credentials-1-pe.png
        title: '进入「设备」页面，点击设备打开详情窗口，再点击「管理凭据」按钮；'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-1-pe.png
        title: '在「设备凭据」窗口中，选择「MQTT Basic」凭据类型并填写设备凭据。点击「保存」。'

mqtts-options-2:
    0:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-2-pe.png
        title: '点击「检查连接」按钮打开相应窗口；'
    1:
        image: /images/user-guide/basic-mqtt/mqtt-over-tls-2-pe.png
        title: '在打开的窗口中选择操作系统，并根据指南中的命令安装所需客户端工具。切换到「MQTTs」协议。复制并运行第一条命令以下载有效的 CA 证书；'
    2:
        image: /images/user-guide/basic-mqtt/mqtt-over-tls-3-pe.png
        title: '复制并运行第二条命令，使用 tb-cloud-root-ca.pem 证书和您为设备指定的凭据发布遥测数据；'
    3:
        image: /images/user-guide/basic-mqtt/mqtt-over-tls-4-pe.png
        title: '命令成功执行后，应能看到已发布的「temperature」读数。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/basic-mqtt.md %}