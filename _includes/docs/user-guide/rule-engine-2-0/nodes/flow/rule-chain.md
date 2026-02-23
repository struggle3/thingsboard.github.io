将入站消息转移至另一规则链进行处理。消息转发至目标规则链的输入节点。

## 配置

### Rule chain

入站消息将转发至的目标规则链。

从租户内可用规则链的下拉列表中选择规则链。消息将发送至所选规则链的输入节点。

启用**Forward message to the originator's default rule chain**时，若无法确定来源实体的默认规则链，该规则链将作为回退。

### Forward message to the originator's default rule chain

启用后，节点尝试根据消息来源实体的默认规则链配置动态确定目标规则链。

该功能适用于以下来源实体类型：

- **Device** — 使用设备配置中配置的默认规则链
- **Asset** — 使用资产配置中配置的默认规则链

若来源实体为其他类型或无法确定默认规则链，节点回退到**Rule chain**配置参数中指定的规则链。

禁用后，所有消息均转发至配置中指定的规则链，与来源实体类型无关。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbRuleChainInputNodeConfiguration",
  "type": "object",
  "properties": {
    "ruleChainId": {
      "type": "string",
      "minLength": 1,
      "description": "UUID of the target rule chain to forward messages to."
    },
    "forwardMsgToDefaultRuleChain": {
      "type": "boolean",
      "description": "Whether to dynamically resolve the target rule chain based on the originator's default rule chain."
    }
  },
  "required": [
    "ruleChainId"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点确定目标规则链：
    - 若**Forward message to the originator's default rule chain**为**禁用**，始终使用配置的规则链。
    - 若**Forward message to the originator's default rule chain**为**启用**：
        - 对于 **Device** 来源实体：获取设备配置中的默认规则链。
        - 对于 **Asset** 来源实体：获取资产配置中的默认规则链。
        - 对于其他来源实体类型或无法确定默认规则链时：使用配置的规则链作为回退。
2. 消息转发至目标规则链的输入节点。
3. 消息根据目标规则链的配置继续处理。
4. 目标规则链中输出节点的输出连接决定最终消息路由。

## 输出连接

输出连接由目标规则链中的输出节点决定，而非本节点。消息遵循目标规则链输出节点中配置的连接类型。
