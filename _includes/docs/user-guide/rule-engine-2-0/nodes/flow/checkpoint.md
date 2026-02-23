将消息转移至指定队列。转移成功后，入站消息被确认。

## 配置

* Queue name — 指定消息应转移到的目标队列。

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
2. 创建入站消息的副本。该副本入队到配置的目标队列。
3. 副本成功入队到目标队列后，原始入站消息被确认。
4. 若入队失败，原始消息经 `Failure` 连接路由，且不被确认。

## 输出连接

- **Success**
    - 消息已成功转移至目标队列并被确认。
- **Failure**
    - 消息入队时发生错误。
    - 处理过程中发生意外错误。
