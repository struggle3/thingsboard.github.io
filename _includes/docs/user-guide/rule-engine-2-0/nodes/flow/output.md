将消息转发回调用规则链。「output」节点产生规则链处理结果，并将其返回至通过[「rule chain」输入节点](/docs/user-guide/rule-engine-2-0/nodes/flow/rule-chain/){:target="_blank"}调用当前规则链的规则链。

## 配置

该节点无需配置。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "EmptyNodeConfiguration",
  "type": "object",
  "properties": {},
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点在当前规则链内接收入站消息。
2. 消息转发回调用规则链。
3. 「output」节点的**名称**决定调用规则链中使用的连接标签。
4. 在调用规则链中，消息经与「output」节点名称匹配的连接从「rule chain」输入节点输出。

「output」节点的名称充当调用规则链中的连接标签。例如：

- 名为 **Success** 的「output」节点经调用规则链中的 **Success** 连接路由消息。
- 名为 **Failure** 的「output」节点经调用规则链中的 **Failure** 连接路由消息。
- 名为 **Valid** 的「output」节点经调用规则链中的 **Valid** 连接路由消息。

## 输出连接

该节点在其自身规则链内没有「output」连接。相反，它将消息返回至调用规则链，在调用规则链中基于「output」节点名称作为连接标签继续路由。
