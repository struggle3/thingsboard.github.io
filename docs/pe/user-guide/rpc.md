---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用 RPC 功能
description: 使用 RPC 功能从 ThingsBoard IoT 云远程控制 IoT 设备

tenant-profile-rpc:
    0:
        image: /images/user-guide/persistent-rpc/tenant-rpc-pe.png
        title: '点击屏幕右上角的橙色铅笔图标进入仪表板编辑模式。'
    1:
        image: /images/user-guide/persistent-rpc/tenant-rpc-1-pe.png
        title: '在 RPC TTL 天数行中设置天数。点击页面右上角的橙色对勾图标应用更改。'

rule-chain:
    0:
        image: /images/user-guide/persistent-rpc/rule-chain-pe.png

rpc-test:
    0:
        image: /images/user-guide/persistent-rpc/rpc-test-pe.png
        title: '点击屏幕右下角的橙色铅笔图标进入仪表板编辑模式。'
    1:
        image: /images/user-guide/persistent-rpc/rpc-test-1-pe.png
        title: '点击 RPC 调试终端右上角的铅笔图标进入部件编辑模式。'
    3:
        image: /images/user-guide/persistent-rpc/rpc-test-2-pe.png
        title: '切换到「高级」选项卡，增加 RPC 请求超时并勾选「RPC request persistent」以启用。点击窗口右上角的橙色对勾图标应用更改。'
    4:
        image: /images/user-guide/persistent-rpc/rpc-test-3-pe.png
        title: '点击屏幕右下角的橙色对勾图标保存所有已应用的更改。'
    5:
        image: /images/user-guide/persistent-rpc/rpc-test-4-pe.png
        title: '本教程将使用命令「test」。如您所见，响应中包含 RPC ID。'

client-side-rpc-rule-chain:
    0:
        image: /images/user-guide/rpc/client-side-rpc-rule-chain-pe-1.png
        title: '编辑根规则链。将「log」动作节点替换为「script」转换节点。添加默认配置的「rpc call reply」动作节点。'
    1:
        image: /images/user-guide/rpc/client-side-rpc-rule-chain-pe-2.png
        title: '从文档中复制粘贴 JS 代码。'

server-side-rpc-rule-chain:
    0:
        image: /images/user-guide/rpc/server-side-rpc-rule-chain-pe-1.png
        title: '编辑根规则链。添加 generator 节点并将其连接到「rpc call request」规则节点。'
    1:
        image: /images/user-guide/rpc/server-side-rpc-rule-chain-pe-2.png
        title: '从文档中复制粘贴 JS 代码。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/rpc.md %}