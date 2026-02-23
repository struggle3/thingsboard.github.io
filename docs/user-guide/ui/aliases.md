---
layout: docwithnav
assignees:
- stitenko
title: 实体别名
description: ThingsBoard 实体别名

create-alias:
    0:
        image: /images/user-guide/widgets/overview/add-new-dashboard-1-ce.png
        title: '打开仪表板并切换到编辑模式；'
    1:
        image: /images/user-guide/ui/alias/create-alias-2-ce.png
        title: '点击窗口右上角的“实体别名”图标；'
    2:
        image: /images/user-guide/ui/alias/create-alias-3-ce.png
        title: '在打开的"实体别名"窗口中，点击对话框左侧的"添加别名"按钮；'
    3:
        image: /images/user-guide/ui/alias/create-alias-4-ce.png
        title: '在打开的“添加别名”对话框中输入别名名称并选择过滤类型。然后填写所有必填项并点击右下角的“添加”按钮；'
    4:
        image: /images/user-guide/ui/alias/create-alias-5-ce.png
        title: '此时可以看到已添加新别名。在此窗口中可查看、编辑和删除别名。点击对话框右下角的“保存”。'

use-alias-in-widget:
    0:
        image: /images/user-guide/ui/alias/create-alias-6-ce.png
        title: '点击屏幕上方的“添加部件”按钮，或点击屏幕中央的“添加新部件”大图标（若为仪表板上的第一个部件）；'
    1:
        image: /images/user-guide/ui/alias/create-alias-7-ce.png
        title: '选择部件包，例如选择“室内环境”部件包；'
    2:
        image: /images/user-guide/ui/alias/create-alias-8-ce.png
        title: '选择“带背景的室内温度卡片”部件；'
    3:
        image: /images/user-guide/ui/alias/create-alias-9-ce.png
        title: '将显示“添加部件”窗口。切换到“实体别名”选项卡，在“实体别名”字段中指定先前创建的别名。'
    4:
        image: /images/user-guide/ui/alias/create-alias-10-ce.png
        title: '在“Data key”字段中指定数据键，本例为“temperature”。然后点击“添加”；'
    5:
        image: /images/user-guide/ui/alias/create-alias-11-ce.png
        title: '已添加使用先前配置的别名作为数据源的部件。'

single-alias-1:
    0:
        image: /images/user-guide/ui/alias/single-entity-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“单个实体”过滤类型，然后选择实体类型并指定目标实体。'
    
single-alias-2:
    0:
        image: /images/user-guide/ui/alias/single-entity-2-ce.png
        title: '在“Tables”部件包中选择“Entities table”部件。切换到“实体别名”选项卡，在“实体别名”字段指定“单个实体”别名，在“列”区域指定“temperature”数据键。点击“添加”；'
    1:
        image: /images/user-guide/ui/alias/single-entity-3-ce.png
        title: '已添加使用该别名过滤单个设备 Thermometer A1 的 Entities table 部件。'


entity-list-1:
    0:
        image: /images/user-guide/ui/alias/entity-list-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“实体列表”过滤类型，然后选择实体类型并选择实体组。'

entity-list-2:
    0:
        image: /images/user-guide/ui/alias/entity-list-2-ce.png
        title: '在“Tables”部件包中选择“Entities table”部件。切换到“实体别名”选项卡，在“实体别名”字段指定“实体列表”别名，在“列”区域指定“temperature”数据键。点击“添加”；'
    1:
        image: /images/user-guide/ui/alias/entity-list-3-ce.png
        title: '已添加使用该别名显示多个设备（本例为 Thermometer A1、A2、A3）的 Entities table 部件。'


entity-name-1:
    0:
        image: /images/user-guide/ui/alias/entity-name-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“实体名称”过滤类型，然后选择实体类型并输入用于过滤显示实体名称的表达式。'

entity-name-2:
    0:
        image: /images/user-guide/ui/alias/entity-name-2-ce.png
        title: '在“Tables”部件包中选择“Entities table”部件。切换到“实体别名”选项卡，在“实体别名”字段指定“实体名称”别名，在“列”区域指定“temperature”数据键。点击“添加”；'
    1:
        image: /images/user-guide/ui/alias/entity-name-3-ce.png
        title: '已添加使用该别名过滤名称以 Compressor 开头的设备的 Entities table 部件。'


entity-type-1:
    0:
        image: /images/user-guide/ui/alias/entity-type-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“实体类型”过滤类型，并选择实体类型“Device”。然后点击“添加”；'

entity-type-2:
    1:
        image: /images/user-guide/ui/alias/entity-type-2-ce.png
        title: '添加将显示实体列表的 Entity table 部件，使用“实体类型”别名作为数据源；'
    2:
        image: /images/user-guide/ui/alias/entity-type-3-ce.png
        title: '已添加显示设备列表的 Entity table 部件。'


entity-from-dashboard-state-1:
    0:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-2-ce.png
        title: '要添加此别名，请输入别名名称，并在“添加别名”对话框中选择过滤类型“仪表板状态中的实体”。然后点击“添加”。'

entity-from-dashboard-state-2:
    0:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-3-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“实体类型”过滤类型并选择实体类型；'
    1:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-4-ce.png
        title: '添加将显示实体列表的 Entity table 部件，使用“实体类型”别名作为数据源；'
    2:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-5-ce.png
        title: '已添加将显示设备列表的 Entity table 部件。'

entity-from-dashboard-state-3:
    0:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-6-ce.png
        title: '点击仪表板左上角的层图标以创建新状态。在打开的对话框窗口中，点击“+”图标添加新状态；'
    1:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-7-ce.png
        title: '输入状态名称。若要使状态以实体名称命名，请使用 <b>${entityName}</b> 作为状态名称。这样，在执行操作时，您将跳转到以参与操作的实体命名的状态。点击“添加”；'
    2:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-8-ce.png
        title: '此时可以看到包含两个状态的列表：根状态和刚刚创建的状态。点击对话框右下角的“保存”。'

entity-from-dashboard-state-4:
    0:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-9-ce.png
        title: '在根仪表板状态中，点击右上角的"铅笔"图标进入部件编辑模式；'
    1:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-10-ce.png
        title: '向下滚动找到“操作”区域。点击“添加操作”按钮；'
    2:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-11-ce.png
        title: '将打开“Entities table：操作”窗口。点击右上角的“添加操作”按钮；'
    3:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-12-ce.png
        title: '在“添加操作”对话框中输入操作名称，并选择分别负责每个实体的操作来源（操作单元格按钮、行点击等）。然后选择操作类型“导航到新仪表板状态”并指定要跳转的新仪表板状态。完成后点击“添加”；'
    4:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-13-ce.png
        title: '成功添加操作后，点击“保存”按钮。然后点击“应用”按钮；'
    5:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-14-ce.png
        title: '现在，通过左上角层图标打开的下拉菜单选择创建的状态进入该状态；'
    6:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-15-ce.png
        title: '点击屏幕中央的"添加新部件"图标；'
    7:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-16-ce.png
        title: '在打开的部件包选择中，选择“室内环境”；'
    8:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-17-ce.png
        title: '选择“带背景的室内温度卡片”部件；'
    9:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-18-ce.png
        title: '在添加部件窗口中切换到"实体别名"选项卡。在"实体别名"字段中指定"仪表板状态中的实体"别名，在"列"区域指定"temperature"数据键。点击右下角的"添加"按钮；'
    10:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-19-ce.png
        title: '添加部件后保存所有已应用的更改；'

entity-from-dashboard-state-5:
    0:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-20-ce.png
        title: '现在，点击任意实体对面的操作按钮；'
    1:
        image: /images/user-guide/ui/alias/entity-from-dashboard-state-21-ce.png
        title: '您将跳转到内部状态，其中包含显示所选实体详情的部件。'


asset-type-1:
    0:
        image: /images/user-guide/ui/alias/asset-type-1-ce.png
        title: 'In the "Add alias" dialog, enter the alias name, and select the “Asset type” filter type. 接着指定资产配置集并可选择输入用于过滤显示资产名称的表达式；'
    
asset-type-2:
    0:
        image: /images/user-guide/ui/alias/asset-type-2-ce.png
        title: '在“Tables”部件包中选择“Entities table”部件。切换到“实体别名”选项卡。在“实体别名”字段中指定“资产类型”别名。点击“添加”；'
    1:
        image: /images/user-guide/ui/alias/asset-type-3-ce.png
        title: '已添加显示资产配置集为“buildings”且名称以“Build”开头的资产的 Entities table 部件'


device-type-1:
    0:
        image: /images/user-guide/ui/alias/device-type-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“设备类型”过滤类型。然后指定设备配置集并可选择输入用于过滤显示设备名称的表达式；'
    
device-type-2:
    0:
        image: /images/user-guide/ui/alias/device-type-2-ce.png
        title: '在“Tables”部件包中选择“Entities table”部件。切换到“实体别名”选项卡。在“实体别名”字段中指定“设备类型”别名。点击“添加”；'
    1:
        image: /images/user-guide/ui/alias/device-type-3-ce.png
        title: '已添加显示设备配置集为“thermometers”且名称以“Therm”开头的设备的 Entities table 部件'


entity-view-type-1:
    0:
        image: /images/user-guide/ui/alias/entity-view-type-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“实体视图类型”过滤类型。然后指定实体视图类型并可选择输入用于过滤显示实体视图名称的表达式；'
    
entity-view-type-2:
    0:
        image: /images/user-guide/ui/alias/entity-view-type-2-ce.png
        title: '在“Tables”部件包中选择“Entities table”部件。切换到“实体别名”选项卡。在“实体别名”字段中指定“实体视图类型”别名。点击“添加”；'
    1:
        image: /images/user-guide/ui/alias/entity-view-type-3-ce.png
        title: '已添加显示实体视图类型为“Entity view type”且名称以“Compressor”开头的实体视图的 Entities table 部件'


edge-type-1:
    0:
        image: /images/user-guide/ui/alias/edge-type-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“Edge 类型”过滤类型。然后指定 Edge 类型并输入用于过滤显示 Edge 名称的表达式；'

edge-type-2:
    0:
        image: /images/user-guide/ui/alias/edge-type-2-ce.png
        title: '在“Tables”部件包中选择“Entities table”部件。切换到“实体别名”选项卡。在“实体别名”字段中指定“Edge 类型”别名。点击“添加”；'
    1:
        image: /images/user-guide/ui/alias/edge-type-3-ce.png
        title: '已添加显示 Edge 类型为“edge instance”且名称以“Edge”开头的 Edge 的 Entities table 部件'


api-usage-state-1:
    0:
        image: /images/user-guide/ui/alias/api-usage-state-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“Api Usage State”过滤类型。'

api-usage-state-2:
    0:
        image: /images/user-guide/ui/alias/api-usage-state-2-ce.png
        title: '在“Tables”部件包中选择“Entities table”部件。切换到“实体别名”选项卡，在“实体别名”字段指定“Api Usage State”别名，在“列”区域添加用于获取 API 使用统计的数据键。点击“添加”；'
    1:
        image: /images/user-guide/ui/alias/api-usage-state-3-ce.png
        title: '已添加显示 API 使用统计的 Entities table 部件。'


relations-query-1:
    0:
        image: /images/user-guide/ui/alias/relations-query-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，指定“Relations query”过滤类型。然后选择实体类型和实体本身，设置要显示的关系。将方向设为“From”或“To”并设置最大关系层级。'
    
relations-query-2:
    0:
        image: /images/user-guide/ui/alias/relations-query-2-ce.png
        title: '在添加部件窗口中切换到"实体别名"选项卡。在"实体别名"字段中指定"仪表板状态中的实体"别名，在"列"区域指定"temperature"数据键。点击右下角的"添加"按钮；'
    1:
        image: /images/user-guide/ui/alias/relations-query-3-ce.png
        title: '已添加显示与资产 District A 存在关系（最多 3 级）的实体及其类型的 Entities table 部件。'


asset-search-query-1:
    0:
        image: /images/user-guide/ui/alias/asset-search-query-1-ce.png
        title: '在“添加别名”对话框中输入别名名称，选择“Asset search query”过滤类型，选择实体类型和实体本身。设置方向为“From”或“To”及最大关系层级，并指定用于过滤资产的资产配置集。'

asset-search-query-2:
    0:
        image: /images/user-guide/ui/alias/asset-search-query-2-ce.png
        title: '在添加部件窗口中切换到"实体别名"选项卡。在"实体别名"字段中指定"仪表板状态中的实体"别名，在"列"区域指定"temperature"数据键。点击右下角的"添加"按钮；'
    1:
        image: /images/user-guide/ui/alias/asset-search-query-3-ce.png
        title: '已添加显示与设备 Compressor QA-32 存在关系（关系层级 2）的资产的 Entities table 部件。'


device-search-query-1:
    0:
        image: /images/user-guide/ui/alias/device-search-query-1-ce.png
        title: 'In the "Add alias" dialog, enter the alias name, select the "Device search query" filter type, and select the entity type and choose an entity itself, the relationship with which you want to display. Set direction to "From" or "To" and max relation level and specify the device profile(s) by which the devices will be filtered.'

device-search-query-2:
    0:
        image: /images/user-guide/ui/alias/device-search-query-2-ce.png
        title: '在添加部件窗口中切换到"实体别名"选项卡。在"实体别名"字段中指定"仪表板状态中的实体"别名，在"列"区域指定"temperature"数据键。点击右下角的"添加"按钮；'
    1:
        image: /images/user-guide/ui/alias/device-search-query-3-ce.png
        title: 'The Entities table widget that displays devices that have any relation to the asset “Building A” up to relation level 1 has been added.'


entity-view-search-query-1:
    0:
        image: /images/user-guide/ui/alias/entity-view-search-query-1-ce.png
        title: 'In the “Add alias” dialog, enter the alias name, select the "Entity view search query" filter type, and select the entity type and choose an entity itself, the relationship with which you want to display. Set direction to "From" or "To" and max relation level and specify the entity view type(s) by which entity views will be filtered'
    
entity-view-search-query-2:
    0:
        image: /images/user-guide/ui/alias/entity-view-search-query-2-ce.png
        title: '在添加部件窗口中切换到"实体别名"选项卡。在"实体别名"字段中指定"仪表板状态中的实体"别名，在"列"区域指定"temperature"数据键。点击右下角的"添加"按钮；'
    1:
        image: /images/user-guide/ui/alias/entity-view-search-query-3-ce.png
        title: 'The Entities table widget that displays entity views that have any relation to the asset "Building A" up to relation level 1 has been added.'


edge-search-query-1:
    0:
        image: /images/user-guide/ui/alias/edge-search-query-1-ce.png
        title: 'In the "Add alias" dialog, enter the alias name, select the "Edge search query" filter type, and select the entity type and an entity itself, the relationship with which you want to display. Set the direction to "From" or "To", max relation level and specify the edge type(s) by which the edges will be filtered.'

edge-search-query-2:
    0:
        image: /images/user-guide/ui/alias/edge-search-query-2-ce.png
        title: '在添加部件窗口中切换到"实体别名"选项卡。在"实体别名"字段中指定"仪表板状态中的实体"别名，在"列"区域指定"temperature"数据键。点击右下角的"添加"按钮；'
    1:
        image: /images/user-guide/ui/alias/edge-search-query-3-ce.png
        title: 'The Entities table widget that displays edges that have any relation to the asset "Building A" up to relation level 1 has been added.'

---

{% include get-hosts-name.html %}
{% include docs/user-guide/ui/aliases.md %}
