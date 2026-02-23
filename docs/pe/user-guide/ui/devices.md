---
layout: docwithnav-pe
assignees:
- ashvayka
title: 设备
description: ThingsBoard IoT 设备管理

add-device:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-1-pe.png
        title: '登录到您的 ThingsBoard 实例。导航至 "<b>实体</b>" &#8702; "<b>设备</b>"。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-2-pe.png
        title: '默认将显示 "<b>全部</b>" 设备组。点击右上角的 "<b>+</b>" 图标，从下拉菜单选择 "<b>添加新设备</b>"。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-3-pe.png
        title: '在设备创建表单中填写必填项：<b>名称</b> - 设备唯一名称；<b>设备配置</b> - 默认配置为 "<b>default</b>"，也可按需选择其他配置。点击 "<b>添加</b>"。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-4-pe.png
        title: '将立即打开一个窗口，用于检查设备与 ThingsBoard 平台的连接。此步骤可选。现在先关闭该窗口，稍后再详细了解连接检查。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-5-pe.png
        title: '设备已成功创建，现已在列表中显示。'

add-device-notification:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-6-pe.png
        title: '您还将收到（铃铛图标）通知，表示设备已添加。'

add-device-group-pe:
    0:
        image: /images/user-guide/entity-groups/create-entity-group-1-pe.png
        title: '前往 "实体" 部分 - "设备" 页面。默认进入设备组 "全部"。切换到 "组" 选项卡，点击右上角的 "加号" 图标；'
    1:
        image: /images/user-guide/entity-groups/create-entity-group-2-pe.png
        title: '输入设备组名称并点击 "添加"；'
    2:
        image: /images/user-guide/entity-groups/create-entity-group-3-pe.png
        title: '设备组已添加完成。'

editing-device:
    0:
        image: /images/user-guide/ui/devices/pe/device-details-1-pe.png
        title: '在设备列表中，找到并点击目标资产，然后点击右侧的 "<b>铅笔</b>"（✏️ <b>编辑</b>）图标打开编辑表单。'
    1:
        image: /images/user-guide/ui/devices/pe/device-details-2-pe.png
        title: '进行必要修改，然后点击 "<b>应用更改</b>" 按钮保存。'

device-delete-1:
    0:
        image: /images/user-guide/ui/devices/pe/device-delete-1-pe.png
        title: '点击要删除设备名称旁的 "<b>垃圾桶</b>" 图标。'
    1:
        image: /images/user-guide/ui/devices/pe/device-delete-2-pe.png
        title: '在对话框中确认删除设备。'

device-delete-2:
    0:
        image: /images/user-guide/ui/devices/pe/device-delete-3-pe.png
        title: '点击要删除的设备。在设备详情窗口中，点击 "<b>删除设备</b>" 按钮；'
    1:
        image: /images/user-guide/ui/devices/pe/device-delete-4-pe.png
        title: '在对话框中确认删除设备。'
    
manage-device-credentials:
    0:
        image: /images/user-guide/ui/devices/pe/manage-device-credentials-1-pe.png
        title: '打开 "<b>设备详情</b>" 窗口，点击 "<b>管理凭据</b>" 按钮；'
    1:
        image: /images/user-guide/ui/devices/pe/manage-device-credentials-2-pe.png
        title: '选择所需凭据类型并生成或输入必填项。点击 "<b>保存</b>"。'

manage-owner-and-groups-pe:
    0:
        image: /images/user-guide/ui/devices/pe/manage-owner-and-groups-1-pe.png
        title: '点击设备打开其 <b>详情</b> 视图，然后点击 "<b>管理所有者和组</b>" 按钮。'
    1:
        image: /images/user-guide/ui/devices/pe/manage-owner-and-groups-2-pe.png
        title: '从列表中选择设备新所有者。如需要，可将设备加入现有组或新建组。确认更改以更新设备所有权。'
    2:
        image: /images/user-guide/ui/devices/pe/manage-owner-and-groups-3-pe.png
        title: '在 <b>"客户名称" 列</b> 中可查看设备当前所有者。'

check-connectivity:
    0:
        image: /images/user-guide/ui/devices/pe/check-connectivity-1-pe.png
        title: '打开 "<b>设备详情</b>" 窗口，点击 "<b>检查连接</b>"'
    1:
        image: /images/user-guide/ui/devices/pe/check-connectivity-2-pe.png
        title: '选择通信协议（MQTT、HTTP 等）和操作系统，然后复制命令。'
    2:
        image: /images/user-guide/ui/devices/pe/check-connectivity-3-pe.png
        title: '在 <b>终端</b> 中运行复制的命令。设备状态应从 "未激活" 变为 "活跃"，并显示发布的 "temperature" 遥测数据。'

include-customer-entities:
    0:
        image: /images/user-guide/ui/devices/pe/include-customer-entities-1-pe.png
        title: '当开关 <b>启用</b>（默认状态）时 — 表格显示 <b>所有可用设备</b>，包括客户拥有的设备。'
    1:
        image: /images/user-guide/ui/devices/pe/include-customer-entities-2-pe.png
        title: '当开关 <b>禁用</b> 时 — 表格仅显示 <b>您自己的设备</b>。'

make-device-group-public:
    0:
        image: /images/user-guide/ui/devices/pe/make-device-group-public-1-pe.png
        title: '在列表中找到目标设备组，点击其旁的 "<b>设为公开</b>" 图标。'
    1:
        image: /images/user-guide/ui/devices/pe/make-device-group-public-2-pe.png
        title: '在弹出对话框中确认操作。'

make-device-group-private:
    0:
        image: /images/user-guide/ui/devices/pe/make-device-group-private-1-pe.png
        title: '要重新设为私有，请使用 "<b>设为私有</b>" 图标按相同步骤操作。'
    1:
        image: /images/user-guide/ui/devices/pe/make-device-group-private-2-pe.png
        title: '在弹出对话框中确认操作。'

share-device-group:
    0:
        image: /images/user-guide/ui/devices/pe/share-device-group-1-pe.png
        title: '在列表中找到目标设备组，点击其旁的 "<b>共享</b>" 图标。'
    1:
        image: /images/user-guide/ui/devices/pe/share-device-group-2-pe.png
        title: '从下拉列表选择 <b>目标客户</b>。（可选）指定该客户下的 <b>用户组</b> 以共享设备组。点击 "<b>共享</b>" 确认操作。'

copy-device-id:
    0:
        image: /images/user-guide/ui/devices/pe/copy-device-id-1-pe.png
        title: '点击列表中设备名称打开设备详情页。点击 "<b>复制设备 Id</b>" 按钮。'

copy-access-token:
    0:
        image: /images/user-guide/ui/devices/pe/copy-access-token-1-pe.png
        title: '要复制设备凭据，请点击 “Copy Access Token” or “Copy MQTT Credentials” button （取决于所选的设备凭据类型）。'

attributes:
    0:
        image: /images/user-guide/ui/devices/pe/device-attributes-1-pe.png
        title: '此选项卡显示设备的客户端、服务器和共享属性。例如序列号、型号和固件版本。'

telemetry:
    0:
        image: /images/user-guide/ui/devices/pe/device-telemetry-1-pe.png
        title: '此选项卡显示设备实时发送的遥测数据，如传感器读数、状态及其他可测量变量。'

telemetry-add-manually:
    0:
        image: /images/user-guide/ui/devices/pe/device-telemetry-add-manually-1-pe.png
        title: '点击窗口右上角的 "加号" 图标。在新窗口中输入键名、选择值类型并输入值。点击 "添加" 按钮。'
    1:
        image: /images/user-guide/ui/devices/pe/device-telemetry-add-manually-2-pe.png
        title: '遥测数据已添加。'

telemetry-delete:
    0:
        image: /images/user-guide/ui/devices/pe/device-telemetry-delete-1-pe.png
        title: '要删除遥测，点击要删除的遥测键名称旁的 "垃圾桶" 图标；'
    1:
        image: /images/user-guide/ui/devices/pe/device-telemetry-delete-2-pe.png
        title: '选择具体删除方式：删除全部数据、删除除最新值外的全部数据、删除最新值、删除某时间段内的全部数据。点击 "应用" 按钮确认删除。'

alarms:
    0:
        image: /images/user-guide/ui/devices/pe/device-details-page-1-pe.png
        title: '点击目标设备打开其 <b>详情窗口</b>。'

device-details-page:
  0:
    image: /images/user-guide/ui/devices/pe/device-details-page-1-pe.png
    title: 'Click on the target device to open its <b>details window</b>.'


---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ui/devices.md %}