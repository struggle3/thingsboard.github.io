将传入消息数据存储到自定义 Cassandra 表中。

## 配置

- **Custom table name** - 目标自定义表名，不含 `cs_tb_` 前缀。表中必须已存在于 Cassandra 集群中，完整名称为 `cs_tb_{tableName}`。前缀用于区分自定义表与 ThingsBoard 标准表。
- **Fields mapping** - 消息字段名（键）与表列名（值）的映射。每个条目定义消息数据中的字段如何存入对应表列。
- **Default TTL** - 插入记录的生存时间（秒）。设为 0 表示禁用 TTL。设为正值时，记录将在指定时长后自动过期。

{% capture entity_id_field_key_note %}
**注意**：当 **$entityId** 用作消息字段键时，节点会将消息发起者 ID 写入对应表列，而非在消息数据中查找该字段。
{% endcapture %}
{% include templates/info-banner.md content=entity_id_field_key_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSaveToCustomCassandraTableNodeConfiguration",
  "type": "object",
  "properties": {
    "tableName": {
      "type": "string",
      "description": "Custom table name without 'cs_tb_' prefix"
    },
    "fieldsMapping": {
      "type": "object",
      "additionalProperties": {
        "type": "string"
      },
      "description": "Mapping between message field names and table column names"
    },
    "defaultTtl": {
      "type": "integer",
      "minimum": 0,
      "description": "Default TTL in seconds, 0 means no TTL"
    }
  },
  "required": [
    "tableName",
    "fieldsMapping",
    "defaultTtl"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 将传入消息数据解析为 JSON 并验证为 JSON 对象。
2. 对每个字段映射条目：
    - 若消息字段键为 `$entityId`，使用消息发起者的 ID
    - 否则在消息数据中查找该字段
    - 将 JSON 基本类型映射到对应 Cassandra 数据类型：
        - 带小数点的数字 → Double
        - 不带小数点的数字 → Long
        - 布尔值 → Boolean
        - 字符串 → String
    - JSON 对象转为字符串表示
    - 缺少字段或非基本/非对象值将导致处理失败
3. 构造并执行带映射值的 `INSERT` 语句。
4. 若配置了 TTL（> 0），则对插入记录应用 TTL。
5. 插入成功后路由到 `Success`，发生任何错误时路由到 `Failure`。

## 输出连接

- `Success`
    - 数据已成功保存到自定义表
- `Failure`
    - 目标表不存在
    - 消息数据不是有效 JSON 对象
    - 必需的消息字段缺失
    - 消息字段值不是 JSON 基本类型或对象
    - 数据库连接或插入错误

## 示例

### 示例 1 — 基本数据插入

**传入消息**

Data:

```json
{
  "temperature": 23.5,
  "humidity": 60,
  "location": "Room A",
  "active": true
}
```

**节点配置**

```json
{
  "tableName": "sensor_data",
  "fieldsMapping": {
    "temperature": "temp_value",
    "humidity": "humidity_level",
    "location": "room_name",
    "active": "is_active"
  },
  "defaultTtl": 0
}
```

**系统状态**

- 表 `cs_tb_sensor_data` 存在，列为：`temp_value`、`humidity_level`、`room_name`、`is_active`。

**传出消息**

传出消息与传入相同。经由 `Success` 连接路由。

**结果**

在 `cs_tb_sensor_data` 中插入一条新记录：

- `temp_value`: 23.5 (Double)
- `humidity_level`: 60 (Long)
- `room_name`: "Room A" (String)
- `is_active`: true (Boolean)

### 示例 2 — 使用实体 ID 映射

**传入消息**

Originator: `DEVICE`，ID 为 `a1b2c3d4-e5f6-7g8h-9i0j-k1l2m3n4o5p6`

Data:

```json
{
  "reading": 150.7,
  "timestamp": 1640995200
}
```

**节点配置**

```json
{
  "tableName": "device_readings",
  "fieldsMapping": {
    "$entityId": "device_id",
    "reading": "sensor_value",
    "timestamp": "read_time"
  },
  "defaultTtl": 3600
}
```

**系统状态**

- 表 `cs_tb_device_readings` 存在，列为：`device_id`、`sensor_value`、`read_time`。

**传出消息**

传出消息与传入相同。经由 `Success` 连接路由。

**结果**

在 `cs_tb_device_readings` 中插入一条新记录，TTL 为 3600 秒：

- `device_id`: `a1b2c3d4-e5f6-7g8h-9i0j-k1l2m3n4o5p6`（发起者设备 ID）
- `sensor_value`: 150.7 (Double)
- `read_time`: 1640995200 (Long)
