---
layout: docwithnav-pe
assignees:
- ashvayka
title: ThingsBoard 专业版快速入门
description: ThingsBoard 开源IoT平台快速入门及模拟 IoT 设备使用
redirect_from: "/docs/pe/getting-started-guides/helloworld/"

step1:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-1-pe.png
        title: '登录您的 ThingsBoard 实例，进入 <b>实体</b> 部分的 <b>设备</b> 页面。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-2-pe.png
        title: '默认情况下，您会进入设备组 <b>全部</b>。点击表格右上角的 "<b>+</b>" 图标，然后从下拉菜单中选择 <b>添加新设备</b>。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-3-pe.png
        title: '输入设备名称（例如 <b>我的新设备</b>），此时无需进行其他更改。点击 <b>添加</b>。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-4-pe.png
        title: '将打开用于检查设备连接的窗口——我们暂时跳过此步骤，下一步再返回进行连接检查。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-5-pe.png
        title: '恭喜，您已添加了第一个设备！当您添加更多设备时，它们将显示在表格顶部，因为表格会自动按创建时间对设备进行排序，最新创建的排在最前面。'

step11:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-6-pe.png
        title: '添加设备时您也会收到通知。点击 <b>铃铛图标</b>（右上角）以查看通知。'

step2:
    0:
        image: /images/helloworld/getting-started-pe/check-connectivity-device-1-pe.png
        title: '点击您的设备，然后在 <b>设备详情</b> 窗口中点击 <b>检查连接</b> 按钮。'
    1:
        image: /images/helloworld/getting-started-pe/check-connectivity-device-2-pe.png
        title: '在打开的窗口中，选择消息协议和操作系统，安装所需的客户端工具并复制提供的命令。'
    2:
        image: /images/helloworld/getting-started-pe/check-connectivity-device-3-pe.png
        title: '在终端中执行复制的命令。遥测数据（例如温度读数）成功发布后，设备状态将从 "<b>未激活</b>" 变为 "<b>激活</b>"，您将看到数据显示。此时可以关闭连接检查窗口。'

step31:
    0:
        image: /images/helloworld/getting-started-pe/create-dashboard-1-pe.png
        title: '通过屏幕左侧的主菜单进入 <b>仪表板</b> 页面。默认情况下，您会进入仪表板组 <b>全部</b>。'
    1:
        image: /images/helloworld/getting-started-pe/create-dashboard-2-pe.png
        title: '点击屏幕右上角的 "<b>+</b>" 符号，然后从下拉菜单中选择 <b>创建新仪表板</b>。'
    2:
        image: /images/helloworld/getting-started-pe/create-dashboard-3-pe.png
        title: '在打开的对话框中输入仪表板标题，描述为可选项。点击 <b>添加</b>。'
    3:
        image: /images/helloworld/getting-started-pe/create-dashboard-4-pe.png
        title: '创建仪表板后，它将自动打开，您可以立即开始添加部件。要保存仪表板，点击右上角的 <b>保存</b> 按钮。'
    4:
        image: /images/helloworld/getting-started-pe/create-dashboard-5-pe.png
        title: '您的第一个仪表板已成功创建。继续添加新仪表板时，它们将显示在列表顶部。此默认排序基于创建时间戳。'

step32:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-0-pe.png
        title: '进入仪表板编辑模式。打开仪表板并点击屏幕右上角的 <b>编辑模式</b> 按钮。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-1-pe.png
        title: '点击屏幕顶部的 <b>+ 添加部件</b> 按钮，或点击屏幕中央的大 <b>+ 添加新部件</b> 图标（如果这是此仪表板上的第一个部件）。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-2-pe.png
        title: '找到 <b>表格</b> 部件包并点击。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-3-pe.png
        title: '选择 <b>实体表格</b> 部件。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-4-pe.png
        title: '将显示添加部件窗口。在 <b>设备</b> 字段中，指定之前创建的设备 <b>我的新设备</b> 作为数据源。<b>name</b> 键已添加到 <b>列</b> 部分，负责设备名称列。您需要添加另一列以显示 <b>temperature</b> 键的值。为此，点击 <b>添加列</b> 以添加新字段来输入数据键。'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-5-pe.png
        title: '点击新出现的数据键输入字段。将打开可用数据键列表。选择 <b>temperature</b> 数据键。'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-6-pe.png
        title: '点击部件右下角的 <b>添加</b> 按钮以完成部件添加。'
    7:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-7-pe.png
        title: '要使部件稍大一些，只需拖动右下角。确认新大小后，别忘了点击 <b>保存</b> 以保存对仪表板的更改。'

step33:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-1-pe.png
        title: '进入编辑模式并点击屏幕顶部的 <b>添加新部件</b> 按钮。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-2-pe.png
        title: '找到 <b>图表</b> 部件包并点击。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-3-pe.png
        title: '选择 <b>时间序列图表</b> 部件。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-4-pe.png
        title: '在 <b>设备</b> 字段中，指定之前创建的设备 <b>我的新设备</b> 作为数据源。在 <b>系列</b> 部分，指定数据键 <b>temperature</b> 以开始监控设备的温度值。然后点击 <b>添加</b>。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-5-pe.png
        title: '调整部件大小并应用更改。如同步骤 2 一样，多次发布不同的遥测值。注意：默认情况下部件仅显示一分钟的数据。点击 <b>保存</b> 以应用更改。'

step33_2:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-6-pe.png
        title: '您还可以调整部件中数据的显示时间间隔、更改聚合函数并指定分组间隔。为此，打开时间窗口并进行必要调整。点击 <b>更新</b> 按钮以更新时间窗口设置。'

step34:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-1-pe.png
        title: '进入编辑模式并点击屏幕顶部的 <b>添加新部件</b> 按钮。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-2-pe.png
        title: '找到 <b>告警部件</b> 包并点击。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-3-pe.png
        title: '选择 <b>告警表格</b> 部件。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-4-pe.png
        title: '在 <b>设备</b> 字段中指定之前创建的设备 <b>我的新设备</b> 作为数据源。接下来配置过滤器。所有告警都有特定的严重程度和状态，勾选您希望在部件中看到的选项。如未勾选任何项，将显示所有告警，无论其状态或严重程度。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-5-pe.png
        title: '恭喜！您已添加告警部件。默认情况下，新部件会自上而下堆叠添加。让我们整理一下部件布局。将 <b>时间序列图表</b> 部件拖到仪表板右上角，为 <b>告警表格</b> 部件腾出空间。'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-6-pe.png
        title: '向下滚动，找到 <b>告警表格</b> 部件并将其拖到空白位置。根据需要调整其大小。完成后点击 <b>保存</b> 以保存仪表板。'

step4:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-1-pe.png
        title: '进入 <b>实体</b> 部分的 <b>设备</b> 页面。<br>点击 <b>我的新设备</b> 打开其详情，并进入 <b>告警规则</b> 标签页。<br>点击 "<b>+</b>" 按钮，选择 <b>创建新告警规则</b>。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-2-pe.png
        title: '在 <b>常规</b> 部分，指定 <b>告警类型</b>——<i>高温</i>（或您喜欢的其他名称）——它同时作为告警的名称和唯一标识符。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-3-pe.png
        title: '添加参数——规则在评估条件时将使用的数据源。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-4-pe.png
        title: '点击 <b>添加触发条件</b>。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-5-pe.png
        title: '保持 <b>严重</b> 严重级别，点击 <b>添加条件</b>。'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-6-pe.png
        title: '点击 <b>添加参数过滤器</b>。'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-7-pe.png
        title: '<b>常规：</b> <b>参数：</b> temperature（之前添加的参数）；<b>值类型：</b> 数字<br><b>过滤器：</b> 点击 <b>添加</b>；<b>操作：</b> 大于；<b>值来源：</b> 静态；<b>值：</b> 25。<br>点击 <b>添加</b>。'
    7:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-8-pe.png
        title: '<b>类型：</b> 简单。<br><b>保存</b> 条件。'
    8:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-9-pe.png
        title: '最后，点击 <b>添加</b>。'
    9:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-10-pe.png
        title: '新告警规则将被创建并激活。'        

step5:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-5-create-alarm-1-pe.png
        title: '一旦新的 <b>temperature</b> 值超过阈值，仪表板上将出现新的活动告警。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-5-create-alarm-2-pe.png
        title: '您可以使用 <b>告警表格</b> 部件对告警进行 <b>确认</b> 和 <b>清除</b>。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-5-create-alarm-3-pe.png
        title: '告警创建后，您还会在 <b>通知中心</b> 收到通知。点击右上角的铃铛图标以查看最新通知。'

notification-center:
    0:
        image: /images/helloworld/getting-started-pe/notification-center-getting-started-1-pe.png
        title: 'ThingsBoard 通知中心允许向最终用户发送个性化通知，可包括设备活动、环境温度变化或 IoT 生态中检测到的其他事件等通知。'

step71:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-1-pe.png
        title: '进入 <b>客户</b> 页面。默认情况下，您会进入客户组 <b>全部</b>。点击 "<b>+</b>" 符号以添加新客户。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-2-pe.png
        title: '输入客户名称。此外，您可以输入客户的个人详情并分配主仪表板。要完成客户创建，可点击「添加」按钮。此时，新客户将创建并位于「全部」客户文件夹中。让我们为客户创建单独的组。为此，点击 <b>下一步：所有者和分组</b> 按钮。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-3-pe.png
        title: '如需，您可为此客户指定不同的所有者。我们将保持此选项不变。输入新组的名称并点击 <b>创建新分组！</b>。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-4-pe.png
        title: '点击 <b>添加</b> 以创建新客户组。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-5-pe.png
        title: '现在，点击 <b>添加</b> 以创建新客户。'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-6-pe.png
        title: '客户已创建，位于 <b>我的客户</b> 组中。'

step72:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-1-pe.png
        title: '打开 <b>设备</b> 页面。点击您的设备以打开其详情。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-2-pe.png
        title: '点击 <b>管理所有者和分组</b> 按钮。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-3-pe.png
        title: '在 <b>所有者</b> 行中，开始输入客户名称然后选择该客户。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-4-pe.png
        title: '现在创建设备组。在 <b>分组</b> 行中输入所需的设备组名称。然后点击 <b>创建新分组！</b>。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-5-pe.png
        title: '在下一窗口中，点击 <b>添加</b> 按钮以创建设备组。'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-6-pe.png
        title: '点击 <b>更新</b> 以添加到分组并更改设备的所有者。您随时可以将所有者改回租户。'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-7-pe.png
        title: '默认情况下，设备列表会同时显示租户设备和客户的设备。禁用 <b>包含客户实体</b> 后，设备列表中仅显示租户设备。'
    7:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-8-pe.png
        title: '您的设备列表现在应为空。'

step72_1:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-9-pe.png
        title: '进入 <b>客户</b> 页面。在客户列表中找到您的客户，然后点击 <b>管理客户设备</b> 图标。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-10-pe.png
        title: '您的设备归客户所有，位于客户的设备组 <b>我的设备</b> 中。'

step72_2:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-11-pe.png
        title: '打开 <b>设备</b> 页面。点击表格右上角的 "<b>+</b>" 图标，然后从下拉菜单中选择 <b>添加新设备</b>。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-12-pe.png
        title: '输入设备名称（例如 <b>温控器</b>），并在 <b>所有者</b> 字段中选择新所有者。然后点击 <b>添加</b>。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-13-pe.png
        title: '关闭连接检查窗口。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-14-pe.png
        title: '设备已创建，并立即属于您的客户。'

step73:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-3-pe.png
        title: '打开 <b>仪表板</b> 页面并进入 <b>分组</b> 标签页。点击 <b>全部</b> 仪表板组旁的 <b>共享</b> 图标。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-4-pe.png
        title: '选择要共享仪表板的客户并设置权限级别。本例中选择「只读」，然后点击 <b>共享</b>。'

step73_1:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-5-pe.png
        title: '在 <b>仪表板</b> 页面的 <b>全部</b> 标签页上，点击表格右上角的 "<b>+</b>" 图标，从下拉菜单中选择 <b>创建新仪表板</b>。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-6-pe.png
        title: '输入仪表板名称（例如 <b>温控器</b>）。在 <b>所有者和分组</b> 部分的 <b>分组</b> 字段中，选择现有组或输入新仪表板组的名称（例如 <b>温控器组</b>），然后点击 <b>创建新分组！</b>。'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-7-pe.png
        title: '在打开的 <b>添加实体组</b> 窗口中，点击 <b>下一步：共享实体组</b>。'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-8-pe.png
        title: '勾选 <b>共享实体组</b> 框，选择要共享仪表板的客户并设置其权限。然后点击 <b>添加</b>。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-9-pe.png
        title: '再次点击 <b>添加</b> 以确认仪表板创建。'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-10-pe.png
        title: '新仪表板将自动打开——点击右上角的 <b>保存</b>。'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-11-pe.png
        title: '您的仪表板已创建并放置在 <b>温控器组</b> 中。您可以通过点击分组名称快速访问。'

step74:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-1-pe.png 
        title: '进入 <b>客户</b> 页面。在客户列表中找到您的客户，然后点击 <b>管理客户用户</b> 图标；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-2-pe.png
        title: '进入 <b>分组</b> 标签页并选择 <b>客户用户</b> 组；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-3-pe.png
        title: '点击右上角的 "<b>加号</b>" 图标；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-4-pe.png
        title: '输入用户邮箱。此外，指定名字和姓氏。点击 <b>添加</b>。'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-5-pe.png
        title: '复制激活链接并保存到安全位置。然后点击 "<b>确定</b>"。'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-6-pe.png
        title: '点击已创建的用户以打开详情。点击 "<b>铅笔</b>" 图标进入编辑模式。'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-7-pe.png
        title: '选择「我的新仪表板」作为默认仪表板并勾选 <b>始终全屏</b>。<b>应用更改</b>。'

step75:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-7-5-activate-customer-user-1-pe.png
        title: '<b>将之前复制的链接粘贴</b> 到新浏览器标签页并按 <b>Enter</b> 键。现在通过输入两次密码并点击 <b>创建密码</b> 来 <b>创建密码</b>。'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-7-5-activate-customer-user-2-pe.png
        title: '您现在已以客户用户身份登录。由于该用户具有只读权限，您可以查看设备数据及其告警，但无法确认或清除它们。'
        
mqttWindows:
    0:
        image: /images/helloworld/hello-world-pe-step-3-item-1.png
        title: '使用下方截图所列属性创建新的 MQTT 客户端。'
    1:
        image: /images/helloworld/hello-world-pe-step-3-item-2.png
        title: '填写主题名称和有效负载。确保有效负载是有效的 JSON 文档。点击 <b>发布</b> 按钮。'

mosquitto-windows:
    0:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-1.png
        title: '按 Win + X，然后选择「系统」。然后点击「系统」页面；'
    1:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-2.png
        title: '进入「关于」部分，然后点击「高级系统设置」；'
    2:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-3.png
        title: '在「系统属性」弹出窗口中，点击「高级」标签页上的「环境变量」按钮；'
    3:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-4.png
        title: '在「环境变量」弹出窗口中，选择「Path」，然后点击「编辑」按钮；'
    4:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-5.png
        title: '在「编辑环境变量」弹出窗口中点击「新建」按钮，添加包含 &#39;mosquitto_pub.exe&#39; 和 &#39;mosquitto_sub.exe&#39; 的目录路径（默认为 &#39;C:\Program Files\mosquitto&#39;）。点击「确定」；'
    5:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-6.png
        title: '点击「确定」按钮保存环境变量中的更改；'
    6:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-7.png
        title: '最后，点击「确定」按钮以应用系统属性中的所有更改。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/getting-started-guides/helloworld-pe.md %}
