---
layout: docwithnav
assignees:
- ashvayka
title: Basic MQTT 认证
description: 基于 MQTT 的 ThingsBoard 认证

client-id-only-1:
    0:
        image: /images/user-guide/basic-mqtt/authentication-manage-credentials-1-ce.png
        title: '进入 <b>Devices</b> 页面，点击设备打开详情窗口，再点击「<b>Manage credentials</b>」按钮。'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-only-1-ce.png
        title: '在 <b>Device Credentials</b> 窗口中，选择 <b>MQTT Basic</b> 凭证类型，并指定 client ID。点击「<b>Save</b>」。'

client-id-only-2:
    0:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-only-2-ce.png
        title: '点击「<b>Check connectivity</b>」按钮打开对应窗口。'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-only-3-ce.png
        title: '在弹出窗口中选择操作系统，并按指南命令安装客户端工具。复制并执行命令以发布 telemetry。'
    2:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-only-4-ce.png
        title: '命令执行成功后，应能看到已发布的 temperature 读数。'

username-and-password-1:
    0:
        image: /images/user-guide/basic-mqtt/authentication-manage-credentials-1-ce.png
        title: '进入 <b>Devices</b> 页面，点击设备打开详情窗口，再点击「<b>Manage credentials</b>」按钮。'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-username-and-password-1-ce.png
        title: '在 <b>Device Credentials</b> 窗口中，选择 <b>MQTT Basic</b> 凭证类型，并指定 username 和 password。点击「<b>Save</b>」。'

username-and-password-2:
    0:
        image: /images/user-guide/basic-mqtt/authentication-based-on-username-and-password-2-ce.png
        title: '点击「<b>Check connectivity</b>」按钮打开对应窗口。'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-username-and-password-3-ce.png
        title: '在弹出窗口中选择操作系统，并按指南命令安装客户端工具。复制并执行命令以发布 telemetry。'
    2:
        image: /images/user-guide/basic-mqtt/authentication-based-on-username-and-password-4-ce.png
        title: '命令执行成功后，应能看到已发布的 temperature 读数。'

client-id-username-and-password-1:
    0:
        image: /images/user-guide/basic-mqtt/authentication-manage-credentials-1-ce.png
        title: '进入 <b>Devices</b> 页面，点击设备打开详情窗口，再点击「<b>Manage credentials</b>」按钮。'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-1-ce.png
        title: '在 <b>Device Credentials</b> 窗口中，选择 <b>MQTT Basic</b> 凭证类型，并指定 client ID、username 和 password。点击「<b>Save</b>」。'

client-id-username-and-password-2:
    0:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-2-ce.png
        title: '点击「<b>Check connectivity</b>」按钮打开对应窗口。'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-3-ce.png
        title: '在弹出窗口中选择操作系统，并按指南命令安装客户端工具。复制并执行命令以发布 telemetry。'
    2:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-4-ce.png
        title: '命令执行成功后，应能看到已发布的 temperature 读数。'

mqtts-options-1:
    0:
        image: /images/user-guide/basic-mqtt/authentication-manage-credentials-1-ce.png
        title: '进入 <b>Devices</b> 页面，点击设备打开详情窗口，再点击「<b>Manage credentials</b>」按钮。'
    1:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-1-ce.png
        title: '在 <b>Device Credentials</b> 窗口中，选择 <b>MQTT Basic</b> 凭证类型，并指定设备凭证。点击「<b>Save</b>」。'

mqtts-options-2:
    0:
        image: /images/user-guide/basic-mqtt/authentication-based-on-client-id-username-and-password-2-ce.png
        title: '点击「<b>Check connectivity</b>」按钮打开对应窗口。'
    1:
        image: /images/user-guide/basic-mqtt/mqtt-over-tls-2-ce.png
        title: '在弹出窗口中选择操作系统，并按指南命令安装客户端工具。切换到 <b>MQTTs</b> 协议。复制并执行第一条命令下载有效 CA 证书。'
    2:
        image: /images/user-guide/basic-mqtt/mqtt-over-tls-3-ce.png
        title: '复制并执行第二条命令，使用 tb-cloud-root-ca.pem 证书及所配置的设备凭证发布 telemetry。'
    3:
        image: /images/user-guide/basic-mqtt/mqtt-over-tls-4-ce.png
        title: '命令执行成功后，应能看到已发布的 temperature 读数。'

---

{% include get-hosts-name.html %}
{% include docs/user-guide/basic-mqtt.md %}