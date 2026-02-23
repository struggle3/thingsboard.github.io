---
layout: docwithnav-paas-eu
assignees:
- ashvayka
title: HTTP 设备 API 参考
description: IoT 设备支持的 HTTP API 参考
redirect_from: "/docs/paas/eu/reference/http-api"

server-side-rpc:
    0:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-1-paas.png
        title: '在 ThingsBoard 实例中使用 RPC 调试终端部件'
    1:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-2-paas.png
        title: '订阅服务端 RPC 命令。在第一个终端窗口发送带 observe 标志的 GET 请求'
    2:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-3-paas.png
        title: 'Send an RPC request "connect" to the device using RPC debug terminal widget'
    3:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-4-paas.png
        title: 'In the second terminal window simulate send a response from the device to the server'
    4:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-5-paas.png
        title: 'You should receive a response from the device: {"result":"ok"}'

client-side-rpc:
    0:
        image: /images/reference/device-connectivity-apis/client-side-rpc-1-paas.png
        title: 'Add two nodes to the Rule Chain: "script" and "rpc call reply"'
    1:
        image: /images/reference/device-connectivity-apis/client-side-rpc-2-paas.png
        title: 'In the script node enter the function: return {msg: {time:String(new Date())}, metadata: metadata, msgType: msgType};'
    2:
        image: /images/reference/device-connectivity-apis/client-side-rpc-3-paas.png
    3:
        image: /images/reference/device-connectivity-apis/client-side-rpc-http-4-paas.png
        title: 'Send request to the server'
    4:
        image: /images/reference/device-connectivity-apis/client-side-rpc-http-5-paas.png
        title: 'You should receive a response from the server'

---

{% assign docsPrefix = "paas/eu/" %}
{% include get-hosts-name.html docsTag="paas-eu" %}
{% include docs/reference/http-api.md %}
