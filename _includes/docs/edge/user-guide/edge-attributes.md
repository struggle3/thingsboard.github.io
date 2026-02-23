* TOC 
{:toc}

## 概述

**Custom attributes（自定义属性）**是可分配给实体的结构化数据。其存储在数据库中，可用于可视化、分析、逻辑配置及与其他服务集成。

在 **ThingsBoard Edge** 中，属性的工作方式与 **ThingsBoard** 平台相同。若要全面了解 **ThingsBoard 属性**，请参阅 [Working with IoT Attributes](/docs/{{peDocsPrefix}}user-guide/attributes/){: target="_blank"} 文档。

## 为 Edge 实体分配属性

**自定义属性**可在 **Edge** 实例上管理。其本地存储和处理以供即时使用。

要为任意 Edge [实体](/docs/{{peDocsPrefix}}user-guide/entities-and-relations/){: target="_blank"} 添加属性：
* 进入 **Entity section**（如 **Entities > Devices** 区域）并点击实体。在 **Entity details** 页面选择 **"Attributes"** 选项卡，在 **"Entity attributes scope"** 下拉菜单中选择 **"Server attributes"** 选项。
* 点击 **"Add"** 按钮。在 **"Add attribute"** 窗口中，在 **"Key"** 字段输入属性名称。然后选择 **attribute value**（_String、Integer、Double、Boolean、JSON_）类型，并在相应字段输入 **attribute value**。点击 **"Add"** 按钮。
* 添加属性后，您可在列表中看到它

{% include images-gallery.html imageCollection="addAttributeOnEdge" %}

若在 **ThingsBoard Server** 上为实体分配了属性，且该实体随后被分配给 **Edge** 实例，**attribute** 也会自动分配。
请[在此](/docs/{{docsPrefix}}config/management/#entities-management){: target="_blank"}了解如何将实体分配到 Edge 实例。

## 使用属性在仪表板上可视化数据

在数据可视化过程中，**实体属性**可用于提供遥测数据的上下文、显示设备静态或动态元数据，并作为配置参数来筛选或标注仪表板。

要在 Dashboard 上显示 **attributes**，请创建 [Entity alias](/docs/{{peDocsPrefix}}user-guide/ui/aliases/){: target="_blank"} 并将其绑定到部件。诸如 [Cards](/docs/{{peDocsPrefix}}user-guide/ui/widget-library/#cards){: target="_blank"}、[Input widgets](/docs/{{peDocsPrefix}}user-guide/ui/widget-library/#input-widgets){: target="_blank"} 或 [Entity Tables](/docs/{{peDocsPrefix}}user-guide/ui/entity-table-widget/){: target="_blank"} 等部件非常适合显示属性。

{% include images-gallery.html imageCollection="dashboard" %}

请[在此](/docs/{{docsPrefix}}user-guide/db-overview/){: target="_blank"}了解更多关于 **Edge Dashboards 配置**。

## 同步属性更新

为确保 **属性** 的变更在 **Server** 与 **Edge** 实例之间同步，需调整 **Rule Chains**。

若变更发生在 **ThingsBoard Server** 且需传播到 **Edge** 实例：
* 登录 **ThingsBoard Server**，进入 **Rule chains** 区域并点击 **Rule Chain**。
* 在 **Rule Chain** 编辑页面，使用 **Node search** 栏找到 **"push to edge"** 节点。将节点拖放到 **Rule Chain** 画布上。然后在 **"Add rule node"** 弹出窗口中输入节点标题，在 **"Entity attributes scope"** 字段中选择 **"Server attributes"** 选项。点击 **"Add"** 按钮继续。
* 使用 **"Attributes Deleted"** 和 **"Attributes Updated"** 链接标签连接 **"message type switch"** 节点与 **"push to edge"** 节点。点击 **Rule Chain** 画布上的 **"Apply changes"** 按钮。

{% include images-gallery.html imageCollection="pushToEdge" %}

若要保持 **ThingsBoard Server** 与 **Edge** 上发生的属性变更同步：
* 登录 **ThingsBoard Server**，进入 **Edge management > Rule chains templates** 区域并点击 **Rule Chain**。
* 在 **Rule Chain** 编辑页面，使用 **Node search** 栏找到 **"push to cloud"** 节点。将节点拖放到 **Rule Chain** 画布上。然后在 **"Add rule node"** 弹出窗口中输入节点标题，在 **"Entity attributes scope"** 字段中选择 **"Server attributes"** 选项。点击 **"Add"** 按钮继续。
* 使用 **"Attributes Deleted"** 和 **"Attributes Updated"** 链接标签连接 **"message type switch"** 节点与 **"push to cloud"** 节点。点击 **Rule Chain** 画布上的 **"Apply changes"** 按钮。

{% include images-gallery.html imageCollection="pushToCloud" %}

{% capture edge-rule-chain %}
从 **Edge 4.0** 起，您可以在 **Edge** 上创建和编辑 **Rule Chain**。
{% endcapture %}
{% include templates/info-banner.md content=edge-rule-chain %}

请[在此](/docs/{{docsPrefix}}config/subscribe-to-attribute/#step-3-subscribe-to-device-attributes-change-and-publish-device-attributes-message){: target="_blank"}了解如何 **订阅设备属性变更**。

## Edge 实例的自定义属性

从 3.9.0 版本起，可将 **自定义属性** 分配给 **Edge** 实例，并在 **Rule Chains** 中用作占位符。这样每个 **Edge** 实例可实时动态将其特定属性替换占位符。如此一来，一个 **Edge Rule Chain** 模板可用于多个实例，无需为每个 **Edge** 实例单独创建 **Rule Chain template**。
所获取的 **Edge 属性**可用于元数据丰富、认证与标记、分析以及传输数据的语境化。此方法简化了多个 **Edge** 实例的管理，支持高效扩展，同时最大限度地减少错误并简化维护。

要为 **Edge** 实例分配自定义属性，请按以下步骤操作：

* 登录 **ThingsBoard Server**，进入 **Edge management > Instances** 区域并点击 **Edge** 实例。在 **"Edge details"** 页面选择 **"Attributes"** 选项卡。
* 点击 **"Add"** 按钮并添加新的自定义属性（_如 edgeAccessToken_）。
* 确认已分配的属性。
* 选择 **"Relations"** 选项卡并点击 **"Add"** 按钮添加新关系（_如 Edge 与 Device(s) 之间的关系_）。点击 **"Add"** 按钮。
* 新创建的关系将出现在 **"Relations"** 选项卡中。

{% include images-gallery.html imageCollection="addEdgeAttributes" %}

要在 **Rule Chain template** 中将 **Edge** 属性用作占位符：
* 进入 **ThingsBoard Server** 的 **Edge management > Rule chains templates** 区域并点击相应的 **Rule Chain**。
  * 若使用 **Edge 4.0** 或更高版本，请留在 **Edge** 实例并进入 **Rule chains** 区域。要编辑规则链，请点击相应的 **Rule Chain**。
* 在 **Rule Chain** 编辑页面，使用 **Node search** 栏找到 **"related entity data"** 节点。将节点拖放到 **Rule Chain sheet** 上。在弹出窗口的以下字段中填写：
  * **Name：** 输入节点名称。
  * **Direction：** 选择关系方向（_From originator/To originator_）。
  * **Relation type：** 选择关系类型（_Contains/Manages_）。
  * **Entity types：** 添加实体类型。
* 向下滚动并继续配置。在 **"Data to fetch"** 配置块中，选择 **"Attributes"** 选项卡并输入 **"Attributes mapping"** 参数：
  * **Source attribute key：** 输入要追踪的实体属性键。
  * **Target key：** 输入目标键名称。点击 **"Add"** 按钮。
* 然后使用 **Node search** 栏找到 **"rest api call"** 节点。将节点拖放到 **Rule Chain sheet** 上。在弹出窗口中输入 **node name** 并点击 **"Add"** 按钮。
  * **Name：** 输入节点名称。
  * **Headers：** 输入请求头和值。头或值可为静态字符串，或使用 Message Metadata 属性解析的模式。
  * 点击 **"Add"** 按钮。请[在此](/docs/user-guide/rule-engine-2-0/nodes/external/rest-api-call/){:target="_blank"}了解更多关于 **REST API Call 节点配置**。
* 使用 **"Post telemetry"** 链接标签连接 **"message type switch"** 与 **"related entity data"** 节点。然后使用 **"Success"** 链接标签连接 **"related entity data"** 与 **"rest api call"** 节点。点击 **Rule Chain sheet** 上的 **"Apply changes"** 按钮。

{% include images-gallery.html imageCollection="edgeAttributesAsPlaceholders" %}

## 在 Edge 规则链中使用属性

在 **ThingsBoard Edge** 中，**Rule Chains** 可利用 **edge attributes** 创建动态、实时的数据处理逻辑。

考虑以下场景：需要在任何设备属性发生变更时收到通知。

在配置告警通知前，请完成以下步骤：
* [添加 Device](/docs/{{docsPrefix}}config/create-device/#creating-device-on-edge-instance){: target="_blank"}。
* 添加新的自定义设备属性。
* [创建 Asset](/docs/{{docsPrefix}}config/provision-asset/#creating-relations){: target="_blank"}。
* 在 **Asset** 与 **Device** 之间[设置关系](/docs/{{docsPrefix}}config/provision-asset/#creating-relations){: target="_blank"}。

按以下步骤配置告警通知：
* 登录 **ThingsBoard Server**，进入 **Edge management > Rule chains templates** 区域并点击相应的 **Rule Chain**。
  * 若使用 **Edge 4.0** 或更高版本，请留在 **Edge** 实例并进入 **Rule chains** 区域。要编辑规则链，请点击相应的 **Rule Chain**。
* 在 **Rule Chain** 编辑页面，使用 **Node search** 栏找到 **"related entity data"** 节点。将节点拖放到 **Rule Chain sheet** 上。在弹出窗口的以下字段中填写：
  * **Name：** 输入节点名称。
  * **Direction：** 选择关系方向（_From originator/To originator_）。
  * **Relation type：** 选择关系类型（_Contains/Manages_）。
  * **Entity types：** 添加实体类型。
* 向下滚动并继续配置。在 **"Data to fetch"** 配置块中，选择 **"Attributes"** 选项卡并输入 **"Attributes mapping"** 参数：
  * **Source attribute key：** 输入要追踪的实体属性键。
  * **Target key：** 输入目标键名称。点击 **"Add"** 按钮。
* 然后使用 **Node search** 栏找到 **"create alarm"** 节点。将节点拖放到 **Rule Chain sheet** 上。在弹出窗口中输入 **node name** 并点击 **"Add"** 按钮。
* 使用 **"Attributes Updated"** 和 **"Attributes Deleted"** 链接标签连接 **"message type switch"** 与 **"related entity data"** 节点。然后使用 **"Success"** 链接标签连接 **"related entity data"** 与 **"create alarm"** 节点。点击 **Rule Chain sheet** 上的 **"Apply changes"** 按钮。
* 要验证 **Alarm** 通知是否将发送，请进入 **Entities > Devices** 区域，打开 **"Device details"** 页面的 **"Attributes"** 选项卡。更改已添加到 **"related entity data"** 节点的属性。
* 确认收到的 **Alarm** 通知。

{% include images-gallery.html imageCollection="attributesInRuleChain" %}
{% capture local-deployment %}
收到通知时请务必 **Acknowledge** 并 **Clear**。您可在 Cloud 或 Edge 上执行此操作。若存在未确认的告警，将更新而非创建。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

## 下一步

{% include templates/edge/guides-banner-edge.md %}
