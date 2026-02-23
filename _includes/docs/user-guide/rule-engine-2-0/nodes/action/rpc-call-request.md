向设备发送 [Remote Procedure Call (RPC)](/docs/{{docsPrefix}}user-guide/rpc){:target="_blank"}。设备响应作为传出消息数据返回，并路由至 `Success` 连接（成功时）或 `Failure` 连接（错误时）。

## 配置

- **Timeout in seconds（超时秒数）** - 指定在 RPC 超时前等待设备响应的最大时间（秒）。默认值为 60 秒。当消息元数据中未提供显式过期时间时使用此超时。

### 来自消息的可选参数

节点还处理传入消息中的以下可选参数：

**来自消息元数据：**

- **oneway**（boolean）- 是否期望响应（默认：`false`）。
- **persistent**（boolean）- 请求是否应持久化（默认：`false`）。
- **requestUUID**（string）- 请求的唯一标识符，用于内部请求跟踪和数据库持久化。若不存在则生成基于时间的 UUID。
- **originServiceId**（string）- 标识发起服务，用于将响应路由到正确的服务。
- **expirationTime**（long）- 请求过期时间戳（毫秒），若不存在则根据配置的超时计算。
- **retries**（integer）- 重试次数。

**来自消息数据：**

- **requestId**（integer）- 请求标识符，若不存在则生成随机整数。用于将响应与原始请求匹配。
- **additionalInfo**（JSON）- 附加请求信息。

**消息类型处理：**

- 若消息类型为 `RPC_CALL_FROM_SERVER_TO_DEVICE`，请求视为 REST API 发起，响应应返回给该 REST API 调用。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSendRpcRequestNodeConfiguration",
  "type": "object",
  "properties": {
    "timeoutInSeconds": {
      "type": "integer",
      "description": "Maximum time to wait for device response in seconds."
    }
  },
  "required": [
    "timeoutInSeconds"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点验证消息 **发起者** 为 `DEVICE` 实体类型，且消息数据包含必需的 **method** 和 **params** 字段。若任一项验证失败，处理失败。
2. 节点从消息数据和元数据收集可选参数并构建 RPC。
3. 节点向发起者设备发送 RPC。
4. 收到响应时：
    - **成功时**：响应数据经 `Success` 连接转发
    - **失败时**：包含错误名称的错误消息经 `Failure` 连接转发
5. 无论响应如何，原始消息在发送 RPC 后立即被确认。

## 输出连接

- `Success`
    - 设备成功响应 RPC。传出消息数据包含设备响应。
- `Failure`
    - 处理过程中发生错误，例如：
        - 发起者不是 `DEVICE`
        - 消息数据中缺少必需的 `method` 字段
        - 消息数据中缺少必需的 `params` 字段
        - 设备未能响应或返回错误

## 示例

### 示例 1 — 带响应的简单 RPC

**传入消息**

发起者：`DEVICE`。

数据：

```json
{
  "method": "setGpio",
  "params": {
    "pin": 7,
    "value": 1
  }
}
```

**节点配置**

```json
{
  "timeoutInSeconds": 30
}
```

**传出消息**

数据：

```json
{
  "success": true
}
```

经 `Success` 连接路由。

**结果**

RPC 请求「setGpio」发送给设备，参数指定将 pin 7 设为 1。设备确认命令并以成功确认响应。

### 示例 2 — 单向 RPC 请求

**传入消息**

发起者：`DEVICE`。

数据：

```json
{
  "method": "reboot",
  "params": {}
}
```

元数据：

```json
{
  "oneway": "true"
}
```

**节点配置**

```json
{
  "timeoutInSeconds": 60
}
```

**传出消息**

传出消息元数据为空 JSON，其他消息字段相同。经 `Success` 连接路由。

数据：

```json
{}
```

**结果**

单向 RPC 请求「reboot」发送给设备。由于这是单向调用（由 `oneway` 元数据表示），节点不等待设备详细响应。
