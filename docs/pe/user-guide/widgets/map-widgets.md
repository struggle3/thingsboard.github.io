---
layout: docwithnav-pe
assignees:
- stitenko
title: 地图部件
description: 地图部件

adding-map-widget:
    0:
        image: /images/user-guide/widgets/maps/adding-map-widget-1-pe.png
        title: 'In dashboard edit mode, click the "Add 部件" button at the top of the screen, or click the large "Add new 部件" icon in the center of the screen (if this is your first 部件 on the dashboard).'
    1:
        image: /images/user-guide/widgets/maps/adding-map-widget-2-pe.png
        title: '找到"Maps"部件包并点击。此类别包含所有可用的地图部件类型。'
    2:
        image: /images/user-guide/widgets/maps/adding-map-widget-3-pe.png
        title: '选择最适合您使用场景的地图部件。'
    3:
        image: /images/user-guide/widgets/maps/adding-map-widget-4-pe.png
        title: '配置部件以匹配您的数据和可视化需求。可调整数据源、外观、地图提供商设置等。点击部件配置窗口右下角的"Add"将其添加到仪表板。'

map-type:
    0:
        image: /images/user-guide/widgets/maps/map-type-1-pe.png
        title: '配置地图部件的第一步是选择地图类型。ThingsBoard提供多种地图部件，包括Image Map（允许使用自定义背景图像作为地图）。也可配置地图图层，在部件内通过几次点击灵活切换不同地图样式——如卫星、混合或自定义图层。'

map-type-adding-layer-1:
    0:
        image: /images/user-guide/widgets/maps/map-type-adding-layer-1-pe.png
        title: '点击"Add layer"。'
    1:
        image: /images/user-guide/widgets/maps/map-type-adding-layer-2-pe.png
        title: '输入图层标签。从可用选项中选择提供商，或添加自定义提供商并指定其图层。'

changing-map-type:
    0:
        image: /images/user-guide/widgets/maps/changing-map-type-1-pe.png
        title: '点击部件上的"Layer"图标按钮。'
    1:
        image: /images/user-guide/widgets/maps/changing-map-type-2-pe.png
        title: '将显示可用的地图图层。可在之间切换。'
    2:
        image: /images/user-guide/widgets/maps/changing-map-type-3-pe.png
        title: '输入图层标签——该名称将显示在部件的图层切换器中。从可用选项（OpenStreetMap、Google、HERE、Tencent）选择地图提供商或指定自定义瓦片服务器。应用更改。'

map-type-reference-layer-1:
    0:
        image: /images/user-guide/widgets/maps/map-type-reference-layer-1-pe.png
        title: '点击"gear"图标进入"Layer settings"。'
    1:
        image: /images/user-guide/widgets/maps/map-type-reference-layer-2-pe.png
        title: '从下拉菜单中选择图层类型，若不需要使用图层则保留"No layer"。应用更改。'
    2:
        image: /images/user-guide/widgets/maps/map-type-reference-layer-3-pe.png
        title: ''

add-marker:
    0:
        image: /images/user-guide/widgets/maps/add-marker-1-pe.png
        title: '进入部件编辑模式并前往"Overlays"部分。确保在"Marker"标签下并点击"Add marker"。'
    1:
        image: /images/user-guide/widgets/maps/add-marker-2-pe.png
        title: '选择数据源——可以是设备、实体别名或函数。定义坐标键。默认ThingsBoard使用*latitude*和*longitude*属性作为标记的坐标键。若实体使用不同键名，请在此更新。应用更改。'
    2:
        image: /images/user-guide/widgets/maps/add-marker-3-pe.png
        title: '标记将根据指定坐标显示在地图上。'

marker-configuration:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-1-pe.png
        title: '要配置特定标记，切换到地图部件编辑模式，在Overlays部分点击所需标记旁的齿轮图标打开其配置面板。'

marker-configuration-datasource:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-datasource-1-pe.png
        title: '指定标记数据源——可以是设备、实体别名或函数。如需要可使用筛选器。'

marker-configuration-keys:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-keys-1-pe.png
        title: '定义坐标键。ThingsBoard自动将坐标键设置为latitude和longitude。若实体使用自定义坐标键名，请在此更新。附加数据键可用于标签、工具提示以及在地图上直接显示额外信息。'

marker-icon-color-1:
    0:
        image: /images/user-guide/widgets/maps/marker-icon-color-1-pe.png
        title: '从多种标准形状和图标中选择不同的标记并调整其大小来自定义标记。'
    1:
        image: /images/user-guide/widgets/maps/marker-icon-color-2-pe.png
        title: '使用根据"state"键值动态改变标记颜色的函数。'
    2:
        image: /images/user-guide/widgets/maps/marker-icon-color-3-pe.png
        title: '应用所有更改。'

marker-icon-color-2:
    0:
        image: /images/user-guide/widgets/maps/marker-icon-color-4-pe.png
        title: '当前"state"键的值为"opened"，因此标记显示为绿色。'

marker-icon-color-3:
    0:
        image: /images/user-guide/widgets/maps/marker-icon-color-5-pe.png
        title: '一旦"state"键的值变为其他任何值，标记将变为红色。'

marker-label:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-label-1-pe.png
        title: '在此可自定义标记上方显示的标签。默认显示实体名称。可编辑标签文本或使用标签函数显示更动态的信息；'
    1:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-label-2-pe.png
        title: '自定义的标记标签。'

marker-tooltip:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-1-pe.png
        title: '使用工具提示模式或工具提示函数；'
    1:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-2-pe.png
        title: '点击标记显示工具提示。'

marker-tooltip-action-1:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-action-1-pe.png
        title: '点击"Add tag action"图标按钮。'
    1:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-action-2-pe.png
        title: '配置操作并点击"Add"。'
    2:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-action-3-pe.png
        title: '现在需将标签操作链接添加到工具提示函数中。将工具提示函数窗口展开为全屏以便编辑。'
    3:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-action-4-pe.png
        title: '通过添加标签操作链接编辑函数。确保正确指定标签操作名称。'
    4:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-action-5-pe.png
        title: '应用所有更改。'

marker-tooltip-action-2:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-action-6-pe.png
        title: '点击标记。在出现的工具提示中可看到标签，点击它。'
    1:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-tooltip-action-7-pe.png
        title: '标签设置中定义的操作将被执行。'

marker-behavior:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-behavior-1-pe.png
        title: '前往"Behavior"部分，点击"On click"操作字段定义操作以替代默认的"Do nothing"。'
    1:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-behavior-2-pe.png
        title: '设置所需操作并应用更改。'
    2:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-behavior-3-pe.png
        title: '点击标记。'
    3:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-behavior-4-pe.png
        title: '操作设置中指定的操作将被触发。'
      
marker-groups:
    0:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-groups-1-pe.png
        title: '在"Groups"部分输入要添加此标记的组名称。'
    1:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-groups-2-pe.png
        title: '部件上会出现"Groups"图标按钮。点击它。'
    2:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-groups-3-pe.png
        title: '要隐藏组，取消勾选其名称旁的复选框。'
    3:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-groups-4-pe.png
        title: '属于该组的标记已被隐藏。'
    4:
        image: /images/user-guide/widgets/maps/marker-configuration-appearance-groups-5-pe.png
        title: ''

marker-editing-tools:
    0:
        image: /images/user-guide/widgets/maps/marker-editing-tools-1-pe.png
        title: '可使用内置工具对标记执行添加/移动/删除等操作。默认这些工具为禁用。勾选要启用的工具旁的复选框。'

manually-add-marker:
    0:
        image: /images/user-guide/widgets/maps/manually-add-marker-1-pe.png
        title: '在"Edit marker"部分勾选"Add"工具。接着选择存储坐标的属性范围："Server"或"Shared"。可选启用贴靠其他顶点以实现精确绘制。然后保存更改。'

place-marker:
    0:
        image: /images/user-guide/widgets/maps/place-marker-1-pe.png
        title: '在地图部件上找到并点击"Place marker"图标按钮。若使用多实体的别名作为数据源，需从下拉菜单中选择相应实体。'
    1:
        image: /images/user-guide/widgets/maps/place-marker-2-pe.png
        title: '在地图上找到要放置标记的位置并点击。'
    2:
        image: /images/user-guide/widgets/maps/place-marker-3-pe.png
        title: '标记将被添加，其坐标将自动作为属性保存到实体。'

move-marker:
    0:
        image: /images/user-guide/widgets/maps/move-marker-1-pe.png
        title: '要移动标记，用鼠标点击并按住标记，拖到新位置后释放鼠标按钮。'

remove-marker:
    0:
        image: /images/user-guide/widgets/maps/remove-marker-1-pe.png
        title: '要删除标记，点击标记，然后点击部件底部菜单中的垃圾桶图标。'

use-map-markers-clustering:
    0:
        image: /images/user-guide/widgets/maps/use-map-markers-clustering-1-pe.png
        title: '要启用地图标记聚类，勾选相应选项并配置必要设置。'
    1:
        image: /images/user-guide/widgets/maps/use-map-markers-clustering-2-pe.png
        title: '更改缩放级别。'
    2:
        image: /images/user-guide/widgets/maps/use-map-markers-clustering-3-pe.png
        title: '启用聚类的标记将分组为圆形图标，显示簇内项目数量。'

add-polygon:
    0:
        image: /images/user-guide/widgets/maps/add-polygon-1-pe.png
        title: '进入部件编辑模式并前往"Overlays"部分。切换到"Polygons"标签并点击"Add polygon"。'
    1:
        image: /images/user-guide/widgets/maps/add-polygon-2-pe.png
        title: '选择要表示为多边形的实体。可以是设备、实体别名或函数。定义包含多边形坐标的键。默认ThingsBoard使用"perimeter"键从实体属性读取多边形坐标。若使用不同键，请相应更新。点击"Apply"。'
    2:
        image: /images/user-guide/widgets/maps/add-polygon-3-pe.png
        title: '多边形将根据实体数据显示在地图上。'

polygon-configuration:
    0:
        image: /images/user-guide/widgets/maps/polygon-configuration-1-pe.png
        title: '要配置特定多边形，切换到地图部件编辑模式。然后在"Overlays"部分的"Polygon"标签下，点击所需多边形旁的"gear"图标按钮打开其配置面板。'

polygon-configuration-datasource:
    0:
        image: /images/user-guide/widgets/maps/polygon-configuration-datasource-1-pe.png
        title: '指定多边形数据源——可以是设备、实体别名或函数。如需要可使用筛选器。'

polygon-configuration-keys:
    0:
        image: /images/user-guide/widgets/maps/polygon-configuration-keys-1-pe.png
        title: '定义包含多边形坐标的键。默认ThingsBoard使用"perimeter"作为多边形键。若实体使用不同键名，请在此更新。附加数据键可用于标签、工具提示或在地图上直接显示额外信息。'

polygon-color:
    0:
        image: /images/user-guide/widgets/maps/polygon-color-1-pe.png
        title: '更改多边形的填充色和描边色。填充也可使用条纹或图像作为背景。'
    1:
        image: /images/user-guide/widgets/maps/polygon-color-2-pe.png
        title: ''

polygon-label:
    0:
        image: /images/user-guide/widgets/maps/polygon-label-1-pe.png
        title: '配置多边形上方显示的标签。默认显示关联该多边形的实体名称。可手动编辑标签文本或使用标签函数显示动态信息。'
    1:
        image: /images/user-guide/widgets/maps/polygon-label-2-pe.png
        title: '自定义多边形标签。'

polygon-tooltip:
    0:
        image: /images/user-guide/widgets/maps/polygon-tooltip-1-pe.png
        title: '在此可配置点击或悬停多边形时显示的工具提示。使用工具提示模式或工具提示函数定义更动态的内容。也可完全隐藏工具提示。'
    1:
        image: /images/user-guide/widgets/maps/polygon-tooltip-2-pe.png
        title: '点击多边形显示工具提示。'

polygon-behavior:
  0:
      image: /images/user-guide/widgets/maps/polygon-behavior-1-pe.png
      title: '前往"Behavior"部分，点击"On click"操作字段定义操作以替代默认的"Do nothing"。'
  1:
      image: /images/user-guide/widgets/maps/polygon-behavior-2-pe.png
      title: '设置所需操作并应用更改。'
  2:
      image: /images/user-guide/widgets/maps/polygon-behavior-3-pe.png
      title: '点击多边形。'
  3:
      image: /images/user-guide/widgets/maps/polygon-behavior-4-pe.png
      title: '操作设置中指定的操作将被触发。'

polygon-groups:
    0:
        image: /images/user-guide/widgets/maps/polygon-groups-1-pe.png
        title: '在"Groups"部分输入要添加此多边形的组名称；'
    1:
        image: /images/user-guide/widgets/maps/polygon-groups-2-pe.png
        title: '部件上会出现"Groups"图标按钮。点击它；'
    2:
        image: /images/user-guide/widgets/maps/polygon-groups-3-pe.png
        title: '要隐藏组，取消勾选其名称旁的复选框。'
    3:
        image: /images/user-guide/widgets/maps/polygon-groups-4-pe.png
        title: '属于该组的多边形已被隐藏。'

polygon-editing-tools:
    0:
        image: /images/user-guide/widgets/maps/polygon-editing-tools-1-pe.png
        title: '可使用内置工具对多边形执行添加/移动/删除等操作。默认这些工具为禁用。勾选要启用的工具旁的复选框。'

manually-add-polygon:
    0:
        image: /images/user-guide/widgets/maps/manually-add-polygon-1-pe.png
        title: '在"Edit polygon"部分勾选"Add"工具。接着选择存储坐标的属性范围："Server"或"Shared"。可选启用贴靠其他顶点以实现精确绘制。然后保存更改。'

place-polygon:
    0:
        image: /images/user-guide/widgets/maps/place-polygon-1-pe.png
        title: '地图部件现提供两种添加多边形的工具："Drew rectangle"和"Drew polygon"。选择适合您需求的选项。'
    1:
        image: /images/user-guide/widgets/maps/place-polygon-2-pe.png
        title: '若使用多实体的别名作为数据源，请从下拉列表中选择所需实体。'
    2:
        image: /images/user-guide/widgets/maps/place-polygon-3-pe.png
        title: '在地图上找到所需位置并点击放置第一个点；'
    3:
        image: /images/user-guide/widgets/maps/place-polygon-4-pe.png
        title: '将多边形调整到所需大小，然后再次点击完成。若使用"Drew polygon"，确保放置所有其他点后点击第一个点闭合形状。'
    4:
        image: /images/user-guide/widgets/maps/place-polygon-5-pe.png
        title: '多边形将被添加，其坐标将自动作为属性保存到实体。'

edit-polygon:
    0:
        image: /images/user-guide/widgets/maps/edit-polygon-1-pe.png
        title: '要调整多边形大小，点击它——顶点将出现。拖动任意点以调整多边形大小。'
    2:
        image: /images/user-guide/widgets/maps/edit-polygon-2-pe.png
        title: '对新大小满意后，点击多边形外的任意位置应用当前尺寸。'
    3:
        image: /images/user-guide/widgets/maps/edit-polygon-3-pe.png
        title: ''

move-polygon:
    0:
        image: /images/user-guide/widgets/maps/move-polygon-1-pe.png
        title: '要启用在地图上移动多边形，在"Edit polygon"部分的多边形设置中激活"Move"工具。'
    1:
        image: /images/user-guide/widgets/maps/move-polygon-2-pe.png
        title: '点击多边形，按住鼠标按钮并将其拖到新位置。'

rotate-polygon:
    0:
        image: /images/user-guide/widgets/maps/rotate-polygon-1-pe.png
        title: '点击多边形选中它，然后点击底部工具中的"Rotate polygon"图标按钮。'
    1:
        image: /images/user-guide/widgets/maps/rotate-polygon-2-pe.png
        title: '抓住多边形的任意点并向所需方向拖动以旋转。'
    2:
        image: /images/user-guide/widgets/maps/rotate-polygon-3-pe.png
        title: '对旋转角度满意后，再次点击"Rotate polygon"图标按钮完成。'

cut-polygon-area:
    0:
        image: /images/user-guide/widgets/maps/cut-polygon-area-1-pe.png
        title: '点击多边形选中它，然后从底部工具中选择"Cut polygon area"。'
    1:
        image: /images/user-guide/widgets/maps/cut-polygon-area-2-pe.png
        title: '在多边形上勾勒要移除的区域。'
    2:
        image: /images/user-guide/widgets/maps/cut-polygon-area-3-pe.png
        title: '连接第一个和最后一个点以闭合形状。'
    3:
        image: /images/user-guide/widgets/maps/cut-polygon-area-4-pe.png
        title: '点击多边形外的任意位置保存更改。'

remove-polygon:
    0:
        image: /images/user-guide/widgets/maps/remove-polygon-1-pe.png
        title: '要删除多边形，点击它，然后点击部件底部菜单中的"trash bin"图标。'


add-circle:
    0:
        image: /images/user-guide/widgets/maps/add-circle-1-pe.png
        title: '进入部件编辑模式并前往"Overlays"部分。切换到"Circles"标签并点击"Add circle"。'
    1:
        image: /images/user-guide/widgets/maps/add-circle-2-pe.png
        title: '选择要表示为圆形的实体。可以是设备、实体别名或函数。定义包含圆形坐标的键。默认ThingsBoard使用"perimeter"键从实体属性读取圆形坐标。若实体使用不同键名，请在此更新。点击"Apply"——圆形将根据实体数据显示在地图上。'
    2:
        image: /images/user-guide/widgets/maps/add-circle-3-pe.png
        title: '圆形已成功添加到地图。'

circle-configuration:
    0:
        image: /images/user-guide/widgets/maps/circle-configuration-1-pe.png
        title: '要配置特定圆形，切换到地图部件编辑模式。然后在"Overlays"部分的"Circle"标签下，点击所需圆形旁的"gear"图标按钮打开其配置面板。'
    
circle-configuration-datasource:
    0:
        image: /images/user-guide/widgets/maps/circle-configuration-datasource-1-pe.png
        title: '指定圆形数据源——可以是设备、实体别名或函数。如需要可应用筛选器缩小选择范围。'
    
circle-configuration-keys:
    0:
        image: /images/user-guide/widgets/maps/circle-configuration-keys-1-pe.png
        title: '定义包含圆形坐标的键。默认ThingsBoard使用"perimeter"作为圆形键。若实体使用不同键名，请在此更新。附加数据键可用于标签、工具提示或在地图上直接显示额外信息。'
    
circle-color:
    0:
        image: /images/user-guide/widgets/maps/circle-color-1-pe.png
        title: '更改圆形的填充色和描边色。填充也可使用条纹或图像作为背景。'
    1:
        image: /images/user-guide/widgets/maps/circle-color-2-pe.png
        title: ''

circle-label:
    0:
        image: /images/user-guide/widgets/maps/circle-label-1-pe.png
        title: '配置圆形上方显示的标签。默认显示关联该圆形的实体名称。可手动编辑标签文本或使用标签函数显示动态信息。'
    1:
        image: /images/user-guide/widgets/maps/circle-label-2-pe.png
        title: '自定义圆形标签。'

circle-tooltip:
    0:
        image: /images/user-guide/widgets/maps/circle-tooltip-1-pe.png
        title: '使用工具提示模式或工具提示函数。'
    1:
        image: /images/user-guide/widgets/maps/circle-tooltip-2-pe.png
        title: '点击圆形显示工具提示。'

circle-behavior:
    0:
        image: /images/user-guide/widgets/maps/circle-behavior-1-pe.png
        title: '前往"Behavior"部分，点击"On click"操作字段定义操作以替代默认的"Do nothing"。'
    1:
        image: /images/user-guide/widgets/maps/circle-behavior-2-pe.png
        title: '设置所需操作并应用更改。'
    2:
        image: /images/user-guide/widgets/maps/circle-behavior-3-pe.png
        title: '点击圆形。'
    3:
        image: /images/user-guide/widgets/maps/circle-behavior-4-pe.png
        title: '操作设置中指定的操作将被触发。'  

circle-groups:
    0:
        image: /images/user-guide/widgets/maps/circle-groups-1-pe.png
        title: '在"Groups"部分输入要添加此圆形的组名称。'
    1:
        image: /images/user-guide/widgets/maps/circle-groups-2-pe.png
        title: '点击"Groups"图标按钮。'
    2:
        image: /images/user-guide/widgets/maps/circle-groups-3-pe.png
        title: '要隐藏组，取消勾选其名称旁的复选框。'
    3:
        image: /images/user-guide/widgets/maps/circle-groups-4-pe.png
        title: '属于该组的圆形已被隐藏。'

circle-editing-tools:
    0:
        image: /images/user-guide/widgets/maps/circle-editing-tools-1-pe.png
        title: '可使用内置工具对圆形执行添加/移动/删除等操作。默认这些工具为禁用。勾选要激活的工具旁的复选框。'

manually-add-circle:
    0:
        image: /images/user-guide/widgets/maps/manually-add-circle-1-pe.png
        title: '在"Edit marker"部分勾选"Add"工具。接着选择存储坐标的属性范围："Server"或"Shared"。可选启用贴靠其他顶点以实现精确绘制。然后保存更改。'

place-circle:
    0:
        image: /images/user-guide/widgets/maps/place-circle-1-pe.png
        title: '地图部件现提供添加圆形的工具："Draw circle"。点击此图标按钮开始。'
    1:
        image: /images/user-guide/widgets/maps/place-circle-2-pe.png
        title: '在地图上找到所需位置并点击放置第一个点；'
    2:
        image: /images/user-guide/widgets/maps/place-circle-3-pe.png
        title: '将圆形调整到所需大小，然后再次点击完成。'
    3:
        image: /images/user-guide/widgets/maps/place-circle-4-pe.png
        title: '圆形已添加到地图。'

edit-circle:
    0:
        image: /images/user-guide/widgets/maps/edit-circle-1-pe.png
        title: '要调整圆形大小，点击它，半径编辑点将出现。拖动它调整圆形大小。'
    1:
        image: /images/user-guide/widgets/maps/edit-circle-2-pe.png
        title: '对新大小满意后，点击圆形外的任意位置应用当前尺寸。'

move-circle:
    0:
        image: /images/user-guide/widgets/maps/move-circle-1-pe.png
        title: '要移动圆形，点击它，按住鼠标按钮并将圆形拖到新位置。'
    1:
        image: /images/user-guide/widgets/maps/move-circle-2-pe.png
        title: '要移动圆形，点击它，按住鼠标按钮并将圆形拖到新位置。'

remove-circle:
    0:
        image: /images/user-guide/widgets/maps/remove-circle-1-pe.png
        title: '要删除圆形，点击它，然后点击部件底部菜单中的"trash bin"图标。'


additional-datasources:
    0:
        image: /images/user-guide/widgets/maps/additional-datasources-1-pe.png
        title: '附加数据源是可用于处理、筛选或在主实体上叠加数据的辅助数据源。常用于在地图叠加功能或工具提示中提供额外上下文或信息。'

map-controls:
    0:
        image: /images/user-guide/widgets/maps/map-controls-1-pe.png
        title: '在"Edit circle"部分的圆形设置中启用"Remove"工具。'
    1:
        image: /images/user-guide/widgets/maps/map-controls-2-pe.png
        title: '要删除圆形，点击它，然后点击部件底部菜单中的"trash bin"图标。'

map-action-buttons-1:
    0:
        image: /images/user-guide/widgets/maps/map-action-buttons-1-pe.png
        title: '在"Map action buttons"部分点击"Add button"。'
    1:
        image: /images/user-guide/widgets/maps/map-action-buttons-2-pe.png
        title: '指定新按钮名称——本例中为"Add building"——并设置图标和颜色。点击"Action"字段定义操作，替代默认的"Do nothing"'
    2:
        image: /images/user-guide/widgets/maps/map-action-buttons-3-pe.png
        title: '选择"Place map item"操作。'
    3:
        image: /images/user-guide/widgets/maps/map-action-buttons-4-pe.png
        title: '选择要放置的地图项类型——本例中为"Marker"。自定义操作函数字段包含创建设备或资产对话框的默认函数，正是所需。然后点击"Add"。'
    4:
        image: /images/user-guide/widgets/maps/map-action-buttons-5-pe.png
        title: '保存更改。'

map-action-buttons-2:
    0:
        image: /images/user-guide/widgets/maps/map-action-buttons-6-pe.png
        title: '在"Overlays"部分的"Marker"标签下，创建新的实体别名作为数据源。命名为"buildings"。'
    1:
        image: /images/user-guide/widgets/maps/map-action-buttons-7-pe.png
        title: '由于将创建资产类型为"buildings"的资产，将筛选类型设置为"Asset type"并指定类型为"buildings"。应用所有更改。'

map-action-buttons-3:
    0:
        image: /images/user-guide/widgets/maps/map-action-buttons-8-pe.png
        title: '地图顶部现已出现标有"Add building"的操作按钮。在地图上找到要放置实体的位置并点击。'
    1:
        image: /images/user-guide/widgets/maps/map-action-buttons-9-pe.png
        title: '在出现的"Add entity"对话框中，确保输入新实体名称并选择其类型——Asset。其他字段为可选。然后点击"Create"。'
    2:
        image: /images/user-guide/widgets/maps/map-action-buttons-10-pe.png
        title: '新标记已添加到地图。'

map-action-buttons-4:
    0:
        image: /images/user-guide/widgets/maps/map-action-buttons-11-pe.png
        title: '前往"Assets"页面——您将在那里找到新创建的资产"Building A"。'

common-map-settings:
    0:
        image: /images/user-guide/widgets/maps/common-map-settings-1-pe.png
        title: '通用地图设置是ThingsBoard中Map部件的基本全局设置。定义地图加载时的行为及初始显示内容。'

appearance:
    0:
        image: /images/user-guide/widgets/maps/appearance-1-pe.png

card-appearance:
  0:
    image: /images/user-guide/widgets/maps/card-appearance-1-pe.png

data-source-for-action:
    0:
        image: /images/user-guide/widgets/maps/data-source-for-action-1-pe.png
        title: '在"Overlays"部分的"Marker"标签下，创建新的实体别名作为数据源。命名为"EV stations"。'
    1:
        image: /images/user-guide/widgets/maps/data-source-for-action-2-pe.png
        title: '由于将创建类型为"EV station"的实体，将筛选类型设置为"Asset type"并指定类型为"EV station"。应用更改。'

action:
    0:
        image: /images/user-guide/widgets/maps/action-1-pe.png
        title: '向下滚动到"Actions"部分并点击"Add action"按钮。'
    1:
        image: /images/user-guide/widgets/maps/action-2-pe.png
        title: '将打开新窗口显示所有已创建的操作。点击右上角的"plus"图标按钮添加一个。'
    2:
        image: /images/user-guide/widgets/maps/action-3-pe.png
        title: '选择操作来源为"Widget header button"，输入按钮名称并选择其类型。'
    3:
        image: /images/user-guide/widgets/maps/action-4-pe.png
        title: '可选更改按钮旁显示的图标或完全隐藏。也可为按钮设置自定义颜色。'
    4:
        image: /images/user-guide/widgets/maps/action-5-pe.png
        title: '从下拉菜单中选择要执行的操作类型。本例中为"Place map item"。接着选择要放置的地图项类型，我们将放置"Marker"。自定义操作函数字段已包含打开创建设备或资产对话框的默认函数，正是所需。然后点击"Add"。'
    5:
        image: /images/user-guide/widgets/maps/action-6-pe.png
        title: '应用所有更改并保存仪表板。'
    6:
        image: /images/user-guide/widgets/maps/action-7-pe.png
        title: '地图顶部现已出现标有"Add EV station"的新操作按钮。'

action-place-marker:
    0:
        image: /images/user-guide/widgets/maps/action-place-marker-1-pe.png
        title: '点击新创建的"Add EV station"按钮。然后在地图上找到要放置电动汽车充电站的位置并点击。'
    1:
        image: /images/user-guide/widgets/maps/action-place-marker-2-pe.png
        title: '在出现的"Add entity"对话框中，确保输入新实体名称并选择其类型——Asset。其他字段为可选。然后点击"Create"。'
    2:
        image: /images/user-guide/widgets/maps/action-place-marker-3-pe.png
        title: '新的"EV station"标记已添加到地图上。'

action-created-asset:
    0:
        image: /images/user-guide/widgets/maps/action-created-asset-1-pe.png
        title: '前往"Assets"页面——您将在那里找到新创建的资产"EV station 1"。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/widgets/map-widgets.md %}