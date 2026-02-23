动作节点是 ThingsBoard 规则引擎的执行组件，根据流经规则链的消息执行具体操作和副作用。

这些节点可自动执行各类系统操作，如将时序和属性持久化到数据库、管理告警、控制设备指令和修改系统状态。

动作节点使您能够根据数据自动执行操作，无需人工干预，从而实现工作流自动化。

- <span class="item-ce product-label-padding">[分配给客户](/docs/user-guide/rule-engine-2-0/nodes/action/assign-to-customer)</span> — 将消息来源分配给指定客户。
- <span class="item-pe product-label-padding">[加入组](/docs/user-guide/rule-engine-2-0/nodes/action/add-to-group)</span> — 按组名称模式将消息来源加入找到的实体组。
- [计算字段](/docs/user-guide/rule-engine-2-0/nodes/action/calculated-fields) — 触发时序或属性数据的计算字段处理，而无需将原始数据持久化到数据库。
- <span class="item-pe product-label-padding">[更换所有者](/docs/user-guide/rule-engine-2-0/nodes/action/change-owner)</span> — 将消息来源的所有权更改为指定租户或客户。
- [清除告警](/docs/user-guide/rule-engine-2-0/nodes/action/clear-alarm) — 清除消息来源的现有活跃告警。
- [复制到视图](/docs/user-guide/rule-engine-2-0/nodes/action/copy-to-view) — 将资产/设备的属性变更复制到其关联的实体视图。
- [创建告警](/docs/user-guide/rule-engine-2-0/nodes/action/create-alarm) — 为消息来源创建新告警或更新现有活跃告警。
- [创建关系](/docs/user-guide/rule-engine-2-0/nodes/action/create-relation) — 在消息来源与指定目标实体之间创建关系，支持可配置的方向和类型。
- [延迟（已废弃）](/docs/user-guide/rule-engine-2-0/nodes/action/delay) — 在将入站消息转发到下一规则节点前延迟可配置时长。
- [删除属性](/docs/user-guide/rule-engine-2-0/nodes/action/delete-attributes) — 从消息来源删除指定属性。
- [删除关系](/docs/user-guide/rule-engine-2-0/nodes/action/delete-relation) — 按类型和方向删除所选实体到消息来源的关系。
- [设备配置](/docs/user-guide/rule-engine-2-0/nodes/action/device-profile) — 根据消息来源设备配置中定义的[告警规则](/docs/{{docsPrefix}}/user-guide/device-profiles/#alarm-rules){:target="_blank"}评估入站消息，并根据评估结果创建、更新或清除告警。
- [设备状态](/docs/user-guide/rule-engine-2-0/nodes/action/device-state) — 发送消息来源的设备连接事件。
- <span class="item-pe product-label-padding">[生成仪表盘报表](/docs/user-guide/rule-engine-2-0/nodes/action/generate-dashboard-report)</span> — 生成应用了特定配置的仪表盘截图。
- <span class="item-pe product-label-padding">[生成报表](/docs/user-guide/rule-engine-2-0/nodes/action/generate-report)</span> — 根据报表模板生成报表并向配置的目标发送通知。
- [生成器](/docs/user-guide/rule-engine-2-0/nodes/action/generator) — 使用自定义脚本函数在可配置时间间隔生成消息。
- [GPS 地理围栏事件](/docs/user-guide/rule-engine-2-0/nodes/action/gps-geofencing-events) — 根据多边形或圆形地理围栏监控 GPS 坐标，并根据进入、离开和停留时长事件路由消息。
- <span class="item-pe product-label-padding">[集成下行](/docs/user-guide/rule-engine-2-0/nodes/action/integration-downlink)</span> — 将入站消息作为下行消息推送到选定的集成。
- [日志](/docs/user-guide/rule-engine-2-0/nodes/action/log) — 执行用户定义的脚本，将消息数据、元数据和类型转换为自定义格式字符串，并记录到 ThingsBoard 日志文件。
- [数学函数](/docs/user-guide/rule-engine-2-0/nodes/action/math-function) — 对从多个来源（常量、消息、元数据、属性或时序）获取的数值执行数学运算，并将结果保存到消息或数据库。
- [消息计数](/docs/user-guide/rule-engine-2-0/nodes/action/message-count) — 在指定时间间隔内统计入站消息，并输出包含每个间隔计数的消息。
- <span class="item-edge product-label-padding">[推送到云端](/docs/user-guide/rule-engine-2-0/nodes/action/push-to-cloud)</span> — 将入站消息从 ThingsBoard Edge 实例发送到云端 ThingsBoard 实例进行后续处理。
- [推送到边缘](/docs/user-guide/rule-engine-2-0/nodes/action/push-to-edge) — 将入站消息从云端 ThingsBoard 实例发送到 ThingsBoard Edge 实例以在边缘进行后续处理。
- <span class="item-pe product-label-padding">[从组中移除](/docs/user-guide/rule-engine-2-0/nodes/action/remove-from-group)</span> — 按组名称模式从找到的实体组中移除消息来源实体。
- [REST 调用回复](/docs/user-guide/rule-engine-2-0/nodes/action/rest-call-reply) — 将入站消息数据作为 HTTP 响应发送给对规则引擎发出的 REST API 调用。
- [RPC 调用回复](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-reply) — 将入站消息数据作为[回复](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/tutorials/rpc-reply-tutorial)发送给设备发起的[远程过程调用 (RPC)](/docs/{{docsPrefix}}user-guide/rpc){:target="_blank"}。
- [RPC 调用请求](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-request) — 向设备发送 RPC，将设备响应作为出站消息数据返回。
- [保存属性](/docs/user-guide/rule-engine-2-0/nodes/action/save-attributes) — 将入站消息数据存储为消息来源的属性数据。
- [保存时序](/docs/user-guide/rule-engine-2-0/nodes/action/save-timeseries) — 将入站消息数据存储为消息来源的时序数据。
- [保存到自定义表](/docs/user-guide/rule-engine-2-0/nodes/action/save-to-custom-table) — 将入站消息数据存储到自定义 Cassandra 表。
- <span class="item-ce product-label-padding">[取消分配客户](/docs/user-guide/rule-engine-2-0/nodes/action/unassign-from-customer)</span> — 从客户处取消分配消息来源。
