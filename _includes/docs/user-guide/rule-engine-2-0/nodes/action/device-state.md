为消息发起者发送设备连接性事件。

## 配置

- **Device connectivity event（设备连接性事件）**：指定要发送的连接性事件类型。
    - *Connect Event*：发送设备连接事件
    - *Activity Event*：发送设备活动事件
    - *Disconnect Event*：发送设备断开连接事件
    - *Inactivity Event*：发送设备非活动事件

### 设备连接性事件类型

每种连接性事件类型在触发时执行特定操作。以下提到的键可根据系统配置存储为属性或时序数据。

#### Connect Event

- **更新**：`lastConnectTime` 键为事件时间戳
- **发送**：向设备默认 Rule Chain 发送 `CONNECT_EVENT` 消息
- **活动状态**：不影响设备活动状态

**`CONNECT_EVENT` 消息示例：**

数据：

```json
{
  "lastConnectTime": 1758038320471,
  "lastActivityTime": 1758035087437,
  "lastDisconnectTime": 1757953973722,
  "lastInactivityAlarmTime": 1758035693342,
  "inactivityTimeout": 600000
}
```

元数据：

```json
{
  "deviceLabel": "MyDeviceLabel",
  "deviceName": "MyDeviceName",
  "deviceType": "default",
  "scope": "SERVER_SCOPE"
}
```

#### Activity Event

- **更新**：`lastActivityTime` 键为事件时间戳
- **发送**：向设备默认 Rule Chain 发送 `ACTIVITY_EVENT` 消息（仅当设备活动状态从 `false` 变为 `true` 时）
- **活动状态**：将设备活动状态设为 `true`

**`ACTIVITY_EVENT` 消息示例：**

数据：

```json
{
  "active": true,
  "lastConnectTime": 0,
  "lastActivityTime": 1758103455789,
  "lastDisconnectTime": 0,
  "lastInactivityAlarmTime": 0,
  "inactivityTimeout": 600000
}
```

元数据：同上

#### Disconnect Event

- **更新**：`lastDisconnectTime` 键为事件时间戳
- **发送**：向设备默认 Rule Chain 发送 `DISCONNECT_EVENT` 消息
- **活动状态**：不影响设备活动状态

**`DISCONNECT_EVENT` 消息示例：**

数据：

```json
{
  "active": true,
  "lastConnectTime": 1758103455789,
  "lastActivityTime": 1758103455789,
  "lastDisconnectTime": 1758103866706,
  "lastInactivityAlarmTime": 0,
  "inactivityTimeout": 600000
}
```

元数据：同上

#### Inactivity Event

- **更新**：`lastInactivityAlarmTime` 键为事件时间戳
- **发送**：向设备默认 Rule Chain 发送 `INACTIVITY_EVENT` 消息
- **活动状态**：将设备活动状态从 `true` 变为 `false`

**`INACTIVITY_EVENT` 消息示例：**

数据：

```json
{
  "active": false,
  "lastConnectTime": 0,
  "lastActivityTime": 1758103455789,
  "lastDisconnectTime": 1758103866706,
  "lastInactivityAlarmTime": 1758103974516,
  "inactivityTimeout": 600000
}
```

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbDeviceStateNodeConfiguration",
  "type": "object",
  "properties": {
    "event": {
      "type": "string",
      "enum": [
        "CONNECT_EVENT",
        "ACTIVITY_EVENT",
        "DISCONNECT_EVENT",
        "INACTIVITY_EVENT"
      ],
      "description": "Type of device connectivity event to trigger"
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. **验证发起者**：检查消息发起者是否为设备实体。若不是，处理失败，消息路由至 `Failure`。
2. **限流检查**：对每台设备应用限流以防连接性事件过多。使用可配置的（通过 `DEVICE_STATE_NODE_RATE_LIMIT_CONFIGURATION` 环境变量）限流（默认：`1:1,30:60,60:3600` — 每秒 1 次、每分钟 30 次、每小时 60 次）。
3. **提取时间戳**：若存在 `ts` 元数据属性则使用，否则使用消息时间戳作为事件时间戳。
4. **触发事件**：根据配置的类型触发连接性事件。
5. **路由消息**：根据结果路由原始消息：
    - 若事件成功触发则 `Success`
    - 若处理期间发生错误则 `Failure`
    - 若超出限流则 `Rate limited`

## 输出连接

- `Success`
    - 设备连接性事件已成功触发
- `Failure`
    - 消息发起者不是 `DEVICE`
    - 处理过程中发生意外错误
- `Rate limited`
    - 该设备的连接性事件超出限流

## 示例

### 示例 1 — 活动事件

**传入消息**

发起者：`DEVICE`

元数据：

```json
{
  "ts": "1694887200000"
}
```

**节点配置**

```json
{
  "event": "ACTIVITY_EVENT"
}
```

**系统状态**

- 发起者设备为非活动（`active` 设为 `false`）
- `lastActivityTime` 设为 `1694887100000`

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

发生以下操作：

- `lastActivityTime` 更新为 `1694887200000`
- 活动状态从 `false` 变为 `true`
- 向设备默认 Rule Chain 发送 `ACTIVITY_EVENT` 消息。
