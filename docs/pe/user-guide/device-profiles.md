---
layout: docwithnav-pe
assignees:
- ashvayka
title: 设备档案
description: IoT 设备档案
redirect_from: "/docs/pe/user-guide/ui/device-profiles"

create-device-profile:
    0:
        image: /images/user-guide/device-profile/create-device-profile-1-pe.png
        title: '进入「<b>档案</b>」部分的「<b>设备档案</b>」页面。点击右上角「<b>+</b>」图标，在下拉菜单中选择「<b>创建新设备档案</b>」。'
    1:
        image: /images/user-guide/device-profile/create-device-profile-2-pe.png
        title: '仅 <b>名称</b> 字段为必填；其他设置均为可选。点击「<b>添加</b>」创建设备档案。'

device-profile-rule-chain:
    0:
        image: /images/user-guide/device-profile/device-profile-rule-chain-1-pe.png
        title: '可为设备档案按设备类型分配独立的规则链，替代默认规则链，从而简化任意设备的消息和事件处理。'

device-profile-queue:
    0:
        image: /images/user-guide/device-profile/device-profile-queue-1-pe.png
        title: '对不同设备类型使用独立队列可实现隔离和优先处理，确保火警等关键事件在系统高负载时也能及时处理。'

device-profile-transport:
    0:
        image: /images/user-guide/device-profile/device-profile-transport-1-pe.png
        title: 'ThingsBoard 平台当前版本支持以下传输类型：<b>Default、MQTT、CoAP、LWM2M、SNMP</b>。'

default-transport-type:
    0:
        image: /images/user-guide/device-profile/default-transport-type-1-pe.png
        title: '<b>Default</b> 传输类型用于兼容平台早期版本。使用该类型的设备可通过 ThingsBoard 标准 API（<b>MQTT</b>、<b>HTTP</b>、<b>CoAP</b>）连接，无需额外配置。'

mqtt-device-topic-filters:
    0:
        image: /images/user-guide/device-profile/mqtt-device-topic-filters-1-pe.png
        title: '自定义 MQTT 主题筛选器支持 <b>单级 (+)</b> 和 <b>多级 (#) 通配符</b>，可连接几乎所有以 <b>JSON</b> 或 <b>Protobuf</b> 格式发送数据的 <b>MQTT 设备</b>。'

mqtt-transport-setting-example:
    0:
        image: /images/user-guide/device-profile/mqtt-transport-example-1-pe.png
        title: '在设备档案中指定自定义 <b>MQTT 设备主题筛选器</b>。'
    1:
        image: /images/user-guide/device-profile/mqtt-transport-example-2-pe.png
        title: '在设备详情中点击「<b>管理凭据</b>」按钮。'
    2:
        image: /images/user-guide/device-profile/mqtt-transport-example-3-pe.png
        title: '为设备 <b>提供基本 MQTT 凭据</b>：client id「c1」、用户名「t1」、密码「secret」。'
    3:
        image: /images/user-guide/device-profile/mqtt-transport-example-4-pe.png
        title: '使用 <b>Terminal</b> 发布时间序列数据。传输的数据将显示在设备的 <b>「最新遥测」选项卡</b> 中。'

mqtt-device-payload:
    0:
        image: /images/user-guide/device-profile/mqtt-device-payload-1-pe.png
        title: '进入「档案」部分的「设备档案」页面。点击右上角「+」图标，在下拉菜单中选择「创建新设备档案」。'
    1:
        image: /images/user-guide/device-profile/mqtt-device-payload-2-pe.png
        title: '进入「档案」部分的「设备档案」页面。点击右上角「+」图标，在下拉菜单中选择「创建新设备档案」。'

compatibility-with-other-payload-formats:
    0:
        image: /images/user-guide/device-profile/mqtt-device-payload-3-pe.png
        title: '进入「档案」部分的「设备档案」页面。点击右上角「+」图标，在下拉菜单中选择「创建新设备档案」。'

coap-default:
    0:
        image: /images/user-guide/device-profile/coap-default-1-pe.png
        title: '默认 CoAP 设备类型使用 JSON 载荷，支持与默认传输类型类似的基本 CoAP API。也可将 CoAP 设备载荷设置改为 Protobuf，以使用 Protocol Buffers（Protobuf）传输数据。'
    1:
        image: /images/user-guide/device-profile/coap-default-2-pe.png
        title: 'Protocol Buffers（Protobuf）是一种与语言和平台无关的结构化数据序列化方法，主要用于减小传输数据体积。'

coap-efento-nb-iot:
    0:
        image: /images/user-guide/device-profile/coap-efento-nb-iot1-pe.png
        title: 'Efento NB-IoT 设备是采用 NB-IoT 技术的无线传感器，用于遥测数据（如温度、湿度、压力、开/关、泄漏等）的节能传输。可通过内置 CoAP 传输将其与 ThingsBoard 集成，接收设备消息、使用 Protobuf 解码并将遥测数据存储到平台，供查看、图表、仪表板、告警配置和自动化使用。'

power-saving-mode:
    0:
        image: /images/user-guide/device-profile/power-saving-mode-1-pe.png
        title: '平台支持以下节能机制以优化设备运行：Power Saving Mode（PSM）、Discontinuous Reception（DRX）、Extended Discontinuous Reception（eDRX）。'

lwm2m-transport-type:
    0:
      image: /images/user-guide/device-profile/lwm2m-transport-type-1-pe.png
      title: 'LwM2M 是面向资源受限设备管理的标准化 IoT 协议，支持集中配置、远程固件更新和实时设备监控。'

snmp-transport-type:
    0:
        image: /images/user-guide/device-profile/snmp-transport-type-1-pe.png
        title: 'SNMP 是广泛用于管理路由器、交换机和服务器等网络设备的协议，支持收集和分析设备状态及性能数据。'

device-profile-details-page:
    0:
        image: /images/user-guide/device-profile/device-profile-details-page-1-pe.png
        title: '点击设备档案将打开 <b>详情窗口</b>，在此可访问和管理该档案的各个方面。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/device-profiles.md %}
