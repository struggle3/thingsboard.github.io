确认入站消息并将其转发至规则链中的下一节点。该节点会显式[将消息标记为已成功处理](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#message-processing-result){:target="_blank"}。

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

1. 节点接收入站消息。
2. 消息立即被确认。
3. 消息经 `Success` 连接转发至下一节点。

## 输出连接

- **Success**
    - 消息已成功确认并转发。
