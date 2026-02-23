过滤节点是 ThingsBoard 规则引擎的路由与条件逻辑组件，用于检查消息并根据不同条件决定消息如何路由到下游节点。

这些节点不会修改消息或执行系统中的任何操作——它们仅用于确定消息应走哪条处理路径。
过滤节点通常具有多个输出关系，如布尔判断的「True/False」，或与过滤条件对应的命名连接，
使消息可根据评估结果流向不同处理路径。

- [告警状态过滤](/docs/user-guide/rule-engine-2-0/nodes/filter/alarm-status-filter) — 根据告警状态是否匹配配置的状态路由消息。
- [资产配置切换](/docs/user-guide/rule-engine-2-0/nodes/filter/asset-profile-switch) — 根据来源资产的配置名称路由消息。
- [检查字段存在](/docs/user-guide/rule-engine-2-0/nodes/filter/check-fields-presence) — 根据消息数据或元数据中是否存在指定字段路由消息。
- [检查关系存在](/docs/user-guide/rule-engine-2-0/nodes/filter/check-relation-presence) — 根据消息来源与目标实体间是否存在指定关系路由消息。
- [设备配置切换](/docs/user-guide/rule-engine-2-0/nodes/filter/device-profile-switch) — 根据来源设备的配置名称路由消息。
- [实体类型过滤](/docs/user-guide/rule-engine-2-0/nodes/filter/entity-type-filter) — 根据来源实体类型是否匹配配置类型路由消息。
- [实体类型切换](/docs/user-guide/rule-engine-2-0/nodes/filter/entity-type-switch) — 根据来源实体类型将消息路由到不同连接。
- [GPS 地理围栏过滤](/docs/user-guide/rule-engine-2-0/nodes/filter/gps-geofencing-filter) — 根据 GPS 坐标是否落在配置的地理围栏范围内路由消息。
- [消息类型过滤](/docs/user-guide/rule-engine-2-0/nodes/filter/message-type-filter) — 根据来源实体类型是否匹配配置类型路由消息。
- [消息类型切换](/docs/user-guide/rule-engine-2-0/nodes/filter/message-type-switch) — 根据消息类型将消息路由到不同连接。
- [脚本](/docs/user-guide/rule-engine-2-0/nodes/filter/script) — 根据布尔脚本的执行结果路由消息。
- [切换](/docs/user-guide/rule-engine-2-0/nodes/filter/switch) — 根据脚本返回值将消息路由到一个或多个连接。
