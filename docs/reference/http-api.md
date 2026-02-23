---
layout: docwithnav
assignees:
- ashvayka
title: HTTP 设备 API 参考
description: 支持的 IoT 设备 HTTP API 参考
redirect_from: "/docs/reference/http-api"

server-side-rpc:
    0:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-1-ce.png
        title: '在 ThingsBoard 实例中使用 RPC 调试终端部件'
    1:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-2-ce.png
        title: '订阅来自服务器的 RPC 命令。在第一个终端窗口发送带 observe 标志的 GET 请求'
    2:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-3-ce.png
        title: '使用 RPC 调试终端部件向设备发送 RPC 请求 "connect"'
    3:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-4-ce.png
        title: '在第二个终端窗口模拟设备向服务器发送响应'
    4:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-5-ce.png
        title: '应收到设备响应：{"result":"ok"}'

client-side-rpc:
    0:
        image: /images/reference/device-connectivity-apis/client-side-rpc-1-ce.png
        title: '在 Rule Chain 中添加两个节点："script" 和 "rpc call reply"'
    1:
        image: /images/reference/device-connectivity-apis/client-side-rpc-2-ce.png
        title: '在 script 节点中输入函数：return {msg: {time:String(new Date())}, metadata: metadata, msgType: msgType};'
    2:
        image: /images/reference/device-connectivity-apis/client-side-rpc-3-ce.png
    3:
        image: /images/reference/device-connectivity-apis/client-side-rpc-http-4-ce.png
        title: '向服务器发送请求'
    4:
        image: /images/reference/device-connectivity-apis/client-side-rpc-http-5-ce.png
        title: '应收到来自服务器的响应'

---

{% include get-hosts-name.html %}
{% include docs/reference/http-api.md %}
