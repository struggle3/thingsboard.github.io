将入站负载解析为 ThingsBoard 告警，按 ID 获取最新告警，并将其当前状态与配置的状态集合比对。
若获取的状态匹配，消息经 `True` 路由；否则经 `False` 路由。解析错误、缺少告警 ID 或不存在的告警会导致 `Failure`。

## 前置条件

通常，入站消息 data 应为 JSON 告警对象：

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "bfb13620-7737-400b-9c89-d569a0835de6"
  },
  "createdTime": 1755173119647,
  "tenantId": {
    "entityType": "TENANT",
    "id": "888e6780-78f5-11f0-8e01-57f51829cedc"
  },
  "customerId": null,
  "type": "Overheating",
  "originator": {
    "entityType": "DEVICE",
    "id": "b3e86d40-78f5-11f0-8e01-57f51829cedc"
  },
  "severity": "CRITICAL",
  "acknowledged": false,
  "cleared": false,
  "assigneeId": null,
  "startTs": 1755173119647,
  "endTs": 1755173119647,
  "ackTs": 0,
  "clearTs": 0,
  "assignTs": 0,
  "propagate": false,
  "propagateToOwner": false,
  "propagateToOwnerHierarchy": false,
  "propagateToTenant": false,
  "propagateRelationTypes": [],
  "originatorName": "device",
  "originatorLabel": "device",
  "assignee": null,
  "name": "Overheating",
  "status": "ACTIVE_UNACK",
  "details": {
    "summary": "The temperature has persistently exceeded 85 °C for at least 10 minutes, while vibration (3.8–4.1 mm/s) and acoustic deviation (9–10.5%) remain normal. Immediate attention is required to prevent possible thermal damage."
  }
}
```

但由于仅使用 `id` 字段，以下对象即可满足要求：

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "bfb13620-7737-400b-9c89-d569a0835de6"
  }
}
```

## 配置

### 字段说明

* **告警状态** — 必填。状态集合：若获取的告警状态匹配其中任一，节点经 `True` 连接路由消息；否则经 `False` 连接路由。

可用状态：

- *Active Acknowledged*（`ACTIVE_ACK`）- 已确认活动中
- *Active Unacknowledged*（`ACTIVE_UNACK`）- 未确认活动中
- *Cleared Acknowledged*（`CLEARED_ACK`）- 已确认已清除
- *Cleared Unacknowledged*（`CLEARED_UNACK`）- 未确认已清除

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/2020-12/schema",
  "title": "TbCheckAlarmStatusNodeConfig",
  "type": "object",
  "required": [
    "alarmStatusList"
  ],
  "additionalProperties": false,
  "properties": {
    "alarmStatusList": {
      "type": "array",
      "description": "Non-empty set of unique alarm statuses to check against.",
      "minItems": 1,
      "uniqueItems": true,
      "items": {
        "type": "string",
        "enum": [
          "ACTIVE_UNACK",
          "ACTIVE_ACK",
          "CLEARED_UNACK",
          "CLEARED_ACK"
        ]
      },
      "default": [
        "ACTIVE_ACK",
        "ACTIVE_UNACK"
      ]
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 将入站消息 data 解析为 ThingsBoard 告警对象（告警必须包含 ID，即必须为已存在告警）。
2. 从数据库获取告警以获取最新信息。
    1. 若未找到该告警，处理以 `Failure` 结束。适用常规失败连接机制。
3. 检查获取的告警状态是否匹配配置的告警状态。
    1. 若匹配，使用 `True` 连接将入站消息路由至下游节点。
    2. 若不匹配，使用 `False` 连接将入站消息路由至下游节点。

{% capture status_property_note %}
**注意：** 路由时不考虑 `status` 属性。
{% endcapture %}
{% include templates/info-banner.md content=status_property_note %}

## 输出连接

* `True`：
    * 当入站消息 data 成功解析为告警、找到告警，且其获取的状态匹配节点配置中的状态集合之一时。
* `False`：
    * 当入站消息 data 成功解析为告警且找到告警，但其获取的状态不匹配节点配置中任一状态时。
* `Failure`：
    * 当入站消息 data 无法解析为告警时。
    * 当解析的告警无 ID 时。
    * 当未找到具有该 ID 的告警时。
    * 消息处理过程中发生其他意外错误时。

## 示例

以下示例仅展示入站消息的**相关**字段。除非另有说明，其他消息字段可为任意值。

---

### 示例 1 — 状态匹配 → `True`

**入站消息 data**

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "c0d5c904-792b-11f0-8de9-0242ac120002"
  }
}
```

**节点配置**

```json
{
  "alarmStatusList": [
    "ACTIVE_UNACK"
  ]
}
```

**系统状态**

告警存在且状态为 `ACTIVE_UNACK`。

**结果**

经 **`True`** 路由。

**说明**

节点按 ID 获取告警，将其**获取的**状态与配置的集合比对；状态匹配，故消息经 `True` 路由。

### 示例 2 — 状态不匹配 → `False`

**入站消息 data**

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "c0d5c904-792b-11f0-8de9-0242ac120002"
  }
}
```

**节点配置**

```json
{
  "alarmStatusList": [
    "ACTIVE_ACK"
  ]
}
```

**系统状态**

告警存在且状态为 `ACTIVE_UNACK`。

**结果**

经 **`False`** 路由。

**说明**

获取的状态（`ACTIVE_UNACK`）不在配置的集合中。

---

### 示例 3 — 允许已确认已清除 → `True`

**入站消息 data**

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "c0d5c904-792b-11f0-8de9-0242ac120002"
  }
}
```

**节点配置**

```json
{
  "alarmStatusList": [
    "CLEARED_ACK"
  ]
}
```

**系统状态**

告警存在且状态为 `CLEARED_ACK`。

**结果**

经 **`True`** 路由。

**说明**

获取的状态与配置匹配。

---

### 示例 4 — 未找到告警 → `Failure`

**入站消息 data**

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "c0d5c904-792b-11f0-8de9-0242ac120002"
  }
}
```

**节点配置**

```json
{
  "alarmStatusList": [
    "ACTIVE_ACK",
    "ACTIVE_UNACK"
  ]
}
```

**系统状态**

不存在具有该 ID 的告警。

**结果**

**`Failure`**。

**说明**

按 ID 查询未返回告警，节点失败。

---

### 示例 5 — 入站消息 data 中缺少 ID → `Failure`

**入站消息 data**

```json
{
  "type": "Overheating"
}
```

**节点配置**

```json
{
  "alarmStatusList": [
    "ACTIVE_ACK",
    "ACTIVE_UNACK"
  ]
}
```

**系统状态**

不相关。

**结果**

**`Failure`**。

**说明**

无 ID 无法获取告警；解析/验证错误导致失败。

---

### 示例 6 — 格式错误/非告警 JSON → `Failure`

**入站消息 data**

```json
{
  "notAnAlarm": true
}
```

**节点配置**

```json
{
  "alarmStatusList": [
    "ACTIVE_ACK"
  ]
}
```

**系统状态**

不相关。

**结果**

**`Failure`**。

**说明**

入站消息 data 无法解析为告警对象。

---

### 示例 7 — 入站状态与数据库不同（以数据库为准）→ `False`

**入站消息 data**（包含 status，但路由时忽略）

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "c0d5c904-792b-11f0-8de9-0242ac120002"
  },
  "status": "ACTIVE_ACK"
}
```

**节点配置**

```json
{
  "alarmStatusList": [
    "ACTIVE_ACK"
  ]
}
```

**系统状态**

告警存在且状态为 `CLEARED_UNACK`。

**结果**

经 **`False`** 路由。

**说明**

路由使用**获取的**状态（`CLEARED_UNACK`），而非入站字段。
