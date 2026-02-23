将 data 为 JSON 数组的消息拆分为多条独立消息，为数组中每个元素生成一条新消息。

## 配置

该节点无可配置选项。

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

1. 节点检查入站消息的 data，确认其为 JSON 数组。
2. 若 data 不是 JSON 数组，处理失败，原始消息经 `Failure` 链路由。
3. 若 data 为 JSON 数组，节点按以下方式处理：
    - 若数组**为空**，仅确认原始消息，不生成新消息。
    - 若数组包含**一个或多个元素**，为**每个元素**创建一条新消息。
4. 每条新消息以数组元素作为其 data。来源实体、消息类型和 metadata 均从原始入站消息复制。
5. 所有新消息经 `Success` 链发送。所有拆分消息成功入队后确认原始消息。

## 输出连接

- `Success`：
    - 新消息（源数组中每个元素一条）经此链发送。
- `Failure`：
    - 入站消息 data 不是 JSON 数组时。

## 示例

### 示例 1 — 拆分对象数组

**入站消息**

Data:

```json
[
  {"sensor": "A", "temperature": 22.5},
  {"sensor": "B", "temperature": 23.1}
]
```

**出站消息**

经 `Success` 链创建并发送两条新消息：

1. Message 1:
    - Data: `{"sensor": "A", "temperature": 22.5}`
2. Message 2:
    - Data: `{"sensor": "B", "temperature": 23.1}`

**说明**：包含两个对象的原始消息被拆分为两条独立消息。每条新消息的 data 为原始数组中的一个对象。

-----

### 示例 2 — 输入为空数组

**入站消息**

Data: `[]`

**出站消息**

不生成新消息。原始消息被确认。

**说明**：入站消息 data 为空数组。节点成功处理，仅确认不产生任何输出消息。

-----

### 示例 3 — 输入不是数组

**入站消息**

Data: `{"status": "error", "code": 500}`

**出站消息**

原始消息经 `Failure` 链路由。不生成新消息。

**说明**：入站消息 data 为 JSON 对象而非数组。节点无法处理，故失败。
