根据消息发起者设备 Profile 中定义的 [告警规则](/docs/{{docsPrefix}}/user-guide/device-profiles/#alarm-rules) 创建、更新和清除告警。

## 配置

- **Persist state of alarm rules（持久化告警规则状态）**：启用时，将告警规则状态存储到数据库。
- **Fetch state of alarm rules（获取告警规则状态）**：控制何时从数据库加载告警规则状态。
    - **Enabled（启用）**：节点启动时预加载告警规则状态。
    - **Disabled（禁用）**：收到设备首条消息时按需加载告警规则状态。

{% capture alarm_rules_both_options_note %}
**注意**：若使用这些选项，建议同时启用两者，但在设备数量较多时，禁用获取选项可缩短启动时间。
{% endcapture %}
{% include templates/info-banner.md content=alarm_rules_both_options_note %}

### Persist state of alarm rules 配置说明

此选项解决服务器重启后告警规则评估的连续性。默认情况下，节点在内存中跟踪告警规则状态，重启时丢失。

告警规则需要随时间进行有状态评估：

- **Duration conditions（持续时间条件）**：「温度超过 100°C 持续 10 分钟」— 需跟踪条件为真的持续时间
- **Repeating conditions（重复条件）**：「温度连续五次超过 100°C」— 需计数连续发生次数

若服务器在评估过程中重启（例如 10 分钟持续的第 7 分钟，或 5 次重复中的第 3 次），跟踪状态会丢失，告警评估从零重新开始。

为解决此问题，**Persist state of alarm rules** 配置选项允许将告警规则状态持久化到数据库，而非仅在内存中保存，确保重启后评估的连续性。

{% capture alarm_rules_persistence_cost_note %}
**注意**：这会为每条符合告警条件的消息增加额外的数据库写入，在高消息量下可能明显。
{% endcapture %}
{% include templates/info-banner.md content=alarm_rules_persistence_cost_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbDeviceProfileNodeConfiguration",
  "type": "object",
  "properties": {
    "persistAlarmRulesState": {
      "type": "boolean",
      "description": "Whether to store the processing state of alarm rules in the database",
      "default": false
    },
    "fetchAlarmRulesStateOnStart": {
      "type": "boolean",
      "description": "Whether to restore alarm rule processing state when the rule node initializes",
      "default": false
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. **加载设备 Profile**：获取与消息发起者关联的设备 Profile。
2. **提取告警规则**：获取设备 Profile 中配置的所有告警规则。
3. **规则评估**：针对传入消息评估发起者设备配置的告警规则。
4. **告警处理**：根据评估结果创建、更新或清除告警。
5. **生成告警消息**：根据评估结果生成新告警消息。生成消息的数据表示告警更改（创建、更新或清除）应用后的告警。
6. **状态持久化**：若 **Persist state of alarm rules** 已启用且消息至少匹配一条告警条件，将当前处理状态持久化到数据库。
7. **路由消息**：将原始消息无修改地路由至 `Success`。

## 输出连接

- `Success`
    - 消息已成功处理且告警规则已评估
    - 原始消息无修改地路由至此
- `Alarm Created`
    - 告警创建相关的生成消息路由至此
- `Alarm Updated`
    - 告警更新相关的生成消息路由至此
- `Alarm Severity Updated`
    - 告警严重性更新相关的生成消息路由至此
- `Alarm Cleared`
    - 告警清除相关的生成消息路由至此
- `Failure`
    - 告警规则评估或处理过程中发生意外错误
