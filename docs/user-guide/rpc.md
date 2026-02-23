---
layout: docwithnav
assignees:
- ashvayka
title: RPC
description: 通过ThingsBoard IoT云端的RPC功能远程控制IoT设备

rule-chain:
    0:
        image: /images/user-guide/persistent-rpc/rule-chain-ce.png

rpc-test:
    0:
        image: /images/user-guide/persistent-rpc/rpc-test-ce.png
        title: '点击屏幕下方橙色铅笔图标进入 dashboard 编辑模式。'
    1:
        image: /images/user-guide/persistent-rpc/rpc-test-1-ce.png
        title: '点击 RPC debug terminal 右上角铅笔图标进入部件编辑模式。'
    3:
        image: /images/user-guide/persistent-rpc/rpc-test-2-ce.png
        title: '进入 Advanced 选项卡，增加 RPC 的 request timeout，勾选「RPC request persistent」启用。点击窗口右上角橙色对勾图标应用更改。'
    4:
        image: /images/user-guide/persistent-rpc/rpc-test-3-ce.png
        title: '点击屏幕下方橙色对勾图标保存所有已应用的更改。'
    5:
        image: /images/user-guide/persistent-rpc/rpc-test-4-ce.png
        title: '本教程将使用命令「test」。响应中包含 RPC ID。'

tenant-profile-rpc:
    0:
        image: /images/user-guide/persistent-rpc/tenant-rpc-ce.png
        title: '点击屏幕上方的橙色铅笔图标进入 dashboard 编辑模式。'
    1:
        image: /images/user-guide/persistent-rpc/tenant-rpc-1-ce.png
        title: '设置 RPC TTL days 行的天数。点击页面右上角橙色对勾图标应用更改。'

client-side-rpc-rule-chain:
    0:
        image: /images/user-guide/rpc/client-side-rpc-rule-chain-pe-1.png
        title: '编辑根 Rule Chain。用「script」 transformation 节点替换「log」 action 节点。添加带默认配置的「rpc call reply」 action 节点。'
    1:
        image: /images/user-guide/rpc/client-side-rpc-rule-chain-pe-2.png
        title: '从文档中复制粘贴 JS 代码。'

server-side-rpc-rule-chain:
    0:
        image: /images/user-guide/rpc/server-side-rpc-rule-chain-pe-1.png
        title: '编辑根 Rule Chain。添加 generator 节点并连接到「rpc call request」 rule 节点。'
    1:
        image: /images/user-guide/rpc/server-side-rpc-rule-chain-pe-2.png
        title: '从文档中复制粘贴 JS 代码。'

---

{% include get-hosts-name.html %}
{% include docs/user-guide/rpc.md %}