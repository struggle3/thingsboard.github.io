根据消息类型路由入站消息。消息经其标签与消息类型**规则节点连接标签**完全匹配的输出连接转发。

## 配置

### 字段说明

无可配置字段。

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

1. 确定入站消息的类型并查找其规则节点连接标签。
2. 使用标签与规则节点连接标签**完全匹配**的连接将消息路由至下游节点。

## 输出连接

* 消息类型连接标签
    * 适用于所有标准消息类型；消息经与具体消息类型对应的连接路由（如 `Post telemetry`、`Post attributes`、`RPC Request from Device`）。
* `Other`：
    * 当消息类型为自定义或没有特定连接定义时。
* `Failure`：
    * 消息处理过程中发生意外错误时。

### 预定义连接标签

| Message type                     | Connection label            |
|----------------------------------|-----------------------------|
| `POST_ATTRIBUTES_REQUEST`        | Post attributes             |
| `POST_TELEMETRY_REQUEST`         | Post telemetry              |
| `TO_SERVER_RPC_REQUEST`          | RPC Request from Device     |
| `ACTIVITY_EVENT`                 | Activity Event              |
| `INACTIVITY_EVENT`               | Inactivity Event            |
| `CONNECT_EVENT`                  | Connect Event               |
| `DISCONNECT_EVENT`               | Disconnect Event            |
| `ENTITY_CREATED`                 | Entity Created              |
| `ENTITY_UPDATED`                 | Entity Updated              |
| `ENTITY_DELETED`                 | Entity Deleted              |
| `ENTITY_ASSIGNED`                | Entity Assigned             |
| `ENTITY_UNASSIGNED`              | Entity Unassigned           |
| `ATTRIBUTES_UPDATED`             | Attributes Updated          |
| `ATTRIBUTES_DELETED`             | Attributes Deleted          |
| `ALARM_ACK`                      | Alarm Acknowledged          |
| `ALARM_CLEAR`                    | Alarm Cleared               |
| `ALARM_ASSIGNED`                 | Alarm Assigned              |
| `ALARM_UNASSIGNED`               | Alarm Unassigned            |
| `COMMENT_CREATED`                | Comment Created             |
| `COMMENT_UPDATED`                | Comment Updated             |
| `RPC_CALL_FROM_SERVER_TO_DEVICE` | RPC Request to Device       |
| `ENTITY_ASSIGNED_FROM_TENANT`    | Entity Assigned From Tenant |
| `ENTITY_ASSIGNED_TO_TENANT`      | Entity Assigned To Tenant   |
| `TIMESERIES_UPDATED`             | Timeseries Updated          |
| `TIMESERIES_DELETED`             | Timeseries Deleted          |
| `RPC_QUEUED`                     | RPC Queued                  |
| `RPC_SENT`                       | RPC Sent                    |
| `RPC_DELIVERED`                  | RPC Delivered               |
| `RPC_SUCCESSFUL`                 | RPC Successful              |
| `RPC_TIMEOUT`                    | RPC Timeout                 |
| `RPC_EXPIRED`                    | RPC Expired                 |
| `RPC_FAILED`                     | RPC Failed                  |
| `RPC_DELETED`                    | RPC Deleted                 |
| `RELATIONS_DELETED`              | All Relations Deleted       |
| `RELATION_ADD_OR_UPDATE`         | Relation Added or Updated   |
| `RELATION_DELETED`               | Relation Deleted            |
| `REST_API_REQUEST`               | REST API request            |
| `OWNER_CHANGED`                  | Owner changed               |
| `ADDED_TO_ENTITY_GROUP`          | Added to Group              |
| `REMOVED_FROM_ENTITY_GROUP`      | Removed from Group          |
| `generateReport`                 | Generate Report             |

## 示例

### 示例 1 — 消息类型为 `POST_TELEMETRY_REQUEST` → 经 `Post telemetry` 路由

**入站消息**

类型：`POST_TELEMETRY_REQUEST`。

**节点配置**

```json
{}
```

**结果**

经 `Post telemetry` 路由。

**说明**

`POST_TELEMETRY_REQUEST` 的规则节点连接标签为 `Post telemetry`。节点通过具有该标签的连接路由消息。

---

### 示例 2 — 自定义消息类型 → 经 `Other` 路由

**入站消息**

类型：`CUSTOM_MESSAGE_TYPE`。

**节点配置**

```json
{}
```

**结果**

经 `Other` 路由。

**说明**

没有预定义规则节点连接标签的自定义消息类型经 `Other` 连接路由。
