在将传入消息转发到下一 Rule 节点之前，延迟可配置的一段时间。

{% capture deprecation_note %}
**此节点已弃用**，可能导致数据丢失。它确认传入消息（从持久队列中移除）但仅将其存储在内存中，若服务器重启或崩溃则会丢失。
{% endcapture %}
{% include templates/warn-banner.md content=deprecation_note %}

## 配置

- **Use period in seconds pattern（使用以秒为单位的延迟模式）** - 启用时，使用 **Period in seconds pattern** 从消息元数据或数据中提取延迟时长。禁用时，使用固定的 **Period in seconds** 字段
    - **Period in seconds（延迟秒数）** - 固定延迟时长（秒）
    - **Period in seconds pattern（延迟秒数模式）** - 从消息元数据或数据中提取延迟时长的模式（如 `${metadataKey}` 或 `$[dataKey]`）
- **Maximum pending messages（最大待处理消息数）** - 可保留在内存中等待延迟超时的最大消息数

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgDelayNodeConfiguration",
  "type": "object",
  "properties": {
    "periodInSeconds": {
      "type": "integer",
      "description": "Fixed delay period in seconds"
    },
    "useMetadataPeriodInSecondsPatterns": {
      "type": "boolean",
      "description": "Whether to use pattern to extract delay from message metadata/data"
    },
    "periodInSecondsPattern": {
      "type": "string",
      "description": "Pattern to extract delay period from message metadata or data"
    },
    "maxPendingMsgs": {
      "type": "integer",
      "description": "Maximum number of messages that can be pending delay"
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点检查待处理消息数是否低于配置的最大限制
    - 若超出限制，处理失败，消息路由至 `Failure` 连接
2. **延迟时长确定**：
    - 若 **Use period in seconds pattern** 已启用：使用配置的模式从消息元数据或数据中提取延迟时长
    - 若模式提取失败或值无法解析为整数：处理失败，消息路由至 `Failure` 连接
    - 若禁用模式：使用固定的 **Period in seconds** 配置值
3. **消息延迟处理**：
    - 将消息在内存中存储计算出的延迟时长
    - 延迟时长到期后，将原始消息转发至 `Success` 连接
    - 原始消息立即被确认

## 输出连接

- `Success`
    - 消息延迟超时已到期，消息正在被转发
- `Failure`
    - 超出最大待处理消息数限制
    - 无法从元数据/数据模式解析延迟时长
    - 发生其他意外错误

## 示例

### 示例 1 — 固定延迟时长

**传入消息**

任意消息。

**节点配置**

```json
{
  "periodInSeconds": 5,
  "useMetadataPeriodInSecondsPatterns": false,
  "maxPendingMsgs": 1000
}
```

**结果**

消息将延迟 5 秒，然后转发至 `Success`。

### 示例 2 — 从元数据动态延迟

**传入消息**

元数据：

```json
{
  "delaySeconds": "10"
}
```

**节点配置**

```json
{
  "useMetadataPeriodInSecondsPatterns": true,
  "periodInSecondsPattern": "${delaySeconds}",
  "maxPendingMsgs": 1000
}
```

**结果**

消息将延迟 10 秒（从元数据提取），然后转发至 `Success` 连接。

### 示例 3 — 从消息数据动态延迟

**传入消息**

数据：

```json
{
  "waitTime": "3"
}
```

**节点配置**

```json
{
  "useMetadataPeriodInSecondsPatterns": true,
  "periodInSecondsPattern": "$[waitTime]",
  "maxPendingMsgs": 1000
}
```

**结果**

消息将延迟 3 秒（从消息数据提取），然后转发至 `Success` 连接。

### 示例 4 — 超出最大待处理消息数

**传入消息**

任意消息。

**节点配置**

```json
{
  "periodInSeconds": 60,
  "useMetadataPeriodInSecondsPatterns": false,
  "maxPendingMsgs": 5
}
```

**系统状态**

- 已有 5 条消息处于延迟中

**传出消息**

消息路由至 `Failure` 连接。

**结果**

由于超出待处理消息限制，处理失败并返回错误。

### 示例 5 — 无效延迟模式

**传入消息**

元数据：

```json
{
  "someOtherKey": "value"
}
```

**节点配置**

```json
{
  "useMetadataPeriodInSecondsPatterns": true,
  "periodInSecondsPattern": "${invalidKey}",
  "maxPendingMsgs": 1000
}
```

**结果**

由于指定模式解析为 `${invalidKey}` 且无法解析为整数，处理失败并抛出运行时异常。
