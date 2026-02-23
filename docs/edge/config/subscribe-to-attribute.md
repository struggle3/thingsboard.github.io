---
layout: docwithnav-edge
title: 具有后处理的双向属性订阅与更新
description: 具有后处理的双向属性订阅与更新

routeMessagesToCloud:
    0:
        image: /images/edge/config/subscribe-to-attribute/1-rule-chain-templates.webp
        title: '登录<b>ThingsBoard Cloud</b>，进入<b>Edge管理 > 规则链模板</b>区域，点击分配给<b>Edge实例</b>的<b>规则链</b>。<ul><li>若使用<b>Edge 4.0</b>或更高版本，请在<b>Edge</b>实例中进入<b>规则链</b>区域。要编辑规则链，点击相应的<b>规则链</b>。</li></ul>'
    1:
        image: /images/edge/config/subscribe-to-attribute/2-add-push-to-cloud.webp
        title: '在<b>规则链</b>编辑页面的节点搜索栏中找到<b>"push to cloud"</b>节点。该节点将消息从Edge推送到云端。将节点拖放到<b>规则链</b>画布上。然后在<b>"添加规则节点"</b>弹出窗口中输入节点标题，在<b>"实体属性范围"</b>框中选择<b>"Client attributes"</b>选项。点击<b>"添加"</b>按钮继续。'
    2:
        image: /images/edge/config/subscribe-to-attribute/3-save.webp
        title: '将<b>"save attributes"</b>和<b>"save time series"</b>节点连接到<b>"push to cloud"</b>节点，并设置<b>"Success"</b>链接标签。点击<b>规则链</b>画布上的<b>"Apply changes"</b>按钮。'

backToEdge:
    0:
        image: /images/edge/config/subscribe-to-attribute/4-rule-chain.webp
        title: '进入<b>规则链</b>区域以修改<b>规则链</b>。'
    1:
        image: /images/edge/config/subscribe-to-attribute/5-add-script.webp
        title: '在<b>规则链</b>编辑页面的节点搜索栏中找到<b>"script"</b>节点。该节点允许使用JavaScript修改消息载荷、元数据或消息类型。将节点拖放到<b>规则链</b>画布上。然后在<b>"添加规则节点：script"</b>弹出窗口中输入节点标题及下方脚本。点击<b>"添加"</b>按钮继续。'
    2:
        image: /images/edge/config/subscribe-to-attribute/5-add-push-to-edge.webp
        title: '在<b>规则链</b>编辑页面的节点搜索栏中找到<b>"push to edge"</b>节点。该节点将消息从云端推送到Edge。将节点拖放到<b>规则链</b>画布上。然后在<b>"添加规则节点"</b>弹出窗口中输入节点标题，在<b>"实体属性范围"</b>框中选择<b>"Shared attributes"</b>选项。点击<b>"添加"</b>按钮继续。'
    3:
        image: /images/edge/config/subscribe-to-attribute/6-save.webp
        title: '将<b>"save attributes"</b>和<b>"save time series"</b>节点连接到<b>"push to edge"</b>节点，并设置<b>"Success"</b>链接标签。点击<b>规则链</b>画布上的<b>"Apply changes"</b>按钮。'

terminal:
    0:
        image: /images/edge/config/subscribe-to-attribute/10-subscribe-post-update-attributes-mqtt.webp
        title: '订阅属性更新后，属性变化时您将收到更新。我们以<b>MQTT</b>协议为例，新属性发布后收到了更新。'

checkResultOnDevice:
    0:
        image: /images/edge/config/subscribe-to-attribute/7-confirm-on-device-1.webp
        title: '要确认<b>客户端属性</b>是否已接收，请进入<b>Edge</b>的<b>实体 > 设备</b>区域并点击<b>设备</b>。在<b>"设备详情"</b>页面，选择<b>"Attributes"</b>选项卡，在<b>"实体属性范围"</b>下拉菜单中选择<b>"Client attributes"</b>选项。'

checkResultOnEdge:
    0:
        image: /images/edge/config/subscribe-to-attribute/8-confirm-on-edge-node-1.webp
        title: '要确认属性消息是否已接收并推送到云端，请进入Edge实例的<b>规则链</b>区域，点击<b>规则链</b>。点击<b>"push to cloud"</b>节点。'
    1:
        image: /images/edge/config/subscribe-to-attribute/8-confirm-on-edge-node-2.webp
        title: '在<b>"Push to cloud"</b>页面，选择<b>"Events"</b>选项卡。若已启用调试模式，在<b>"Event type"</b>下拉菜单中选择<b>"Debug"</b>选项。您应能看到新记录 - <b>"IN"</b>和<b>"OUT"</b>，其中<b>"IN"</b>记录表示从设备接收的属性，<b>"OUT"</b>记录表示推送到<b>云端</b>的属性消息。'

checkResultOnCloud:
    0:
        image: /images/edge/config/subscribe-to-attribute/9-confirm-on-cloud-node-1.webp
        title: '要确认云端的属性消息是否已接收并推送回Edge，请进入云端的<b>规则链</b>区域，点击<b>规则链</b>。双击<b>"push to edge"</b>节点。'
    1:
        image: /images/edge/config/subscribe-to-attribute/9-confirm-on-cloud-node-2.webp
        title: '在<b>"Push to edge"</b>页面，选择<b>"Events"</b>选项卡。若已启用调试模式，在<b>"Event type"</b>下拉菜单中选择<b>"Debug"</b>选项。您应能看到两条新记录 - <b>"IN"</b>和<b>"OUT"</b>，其中<b>"IN"</b>记录表示从Edge接收的属性，<b>"OUT"</b>记录表示推送回<b>Edge</b>的属性消息。'

---
{% assign docsPrefix = "edge/" %}
{% include docs/edge/user-guide/config/subscribe-to-attribute.md %}