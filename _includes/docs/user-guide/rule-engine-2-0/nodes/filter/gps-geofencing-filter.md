从入站消息中提取经纬度，并检查该点是否位于配置的地理围栏（多边形或圆形）**内部**。
若匹配，消息经 `True` 路由；否则经 `False` 路由。

## 前置条件

入站消息的 **data** 必须为有效 JSON 对象。配置的坐标键必须存在于消息中（可在 data 或 metadata 中，可来自不同来源），其值必须**可解析为十进制数**。

## 配置

### 字段说明

* **纬度字段名** — 包含待检查点纬度的键名。
* **经度字段名** — 包含待检查点经度的键名。
* **围栏类型** — 定义用于比对的地理围栏形状。可为 *Polygon*（多边形）或 *Circle*（圆形）。
* **从 metadata 获取围栏信息** — 启用后，从消息 **metadata** 读取围栏。禁用后，节点使用静态配置中定义的围栏。
* **围栏键名** — 存储围栏定义的 metadata 键。仅在**从 metadata 获取围栏信息**启用时使用。
  行为取决于配置的**围栏类型**：
    * 若为 *Polygon*：metadata 键必须包含表示定义多边形的坐标 JSON 数组的字符串。
    * 若为 *Circle*：metadata 键必须包含表示定义圆形的 JSON 对象的字符串。

当**围栏类型**为 *Polygon* 且**从 metadata 获取围栏信息**禁用时，以下字段必填：

* **多边形定义** — 表示定义多边形坐标的 JSON 数组的字符串。

当**围栏类型**为 *Circle* 且**从 metadata 获取围栏信息**禁用时，以下字段必填：

* **中心纬度** — 圆形地理围栏中心点的纬度。
* **中心经度** — 圆形地理围栏中心点的经度。
* **半径** — 圆的半径，表示围栏距中心的延伸距离。必须为正数。
* **半径单位** — 半径的计量单位。可为：*Meter*（米）、*Kilometer*（千米）、*Foot*（英尺）、*Mile*（英里）、*Nautical mile*（海里）。

### 围栏定义格式

#### 多边形定义格式

多边形定义必须为包含有效坐标 JSON 数组的字符串。每个坐标为两元素数组：`[latitude, longitude]`。

**单个多边形**

基本多边形至少需三个点（最后一个点自动闭合形成环）：

```json
[[48.195,24.645],[48.200,24.655],[48.205,24.645]]
```

**矩形（两个对角点）**

可使用仅两个对角点定义矩形，节点自动计算其余角点：

```json
[[48.195,24.645],[48.205,24.655]]
```

**多多边形**

可将多个多边形包装在额外数组中：

```json
[
  [[48.195,24.645],[48.200,24.655],[48.205,24.645]],
  [[48.210,24.650],[48.215,24.660],[48.220,24.650]]
]
```

**带孔多边形**

若一个多边形完全包含在另一个内，视为**孔**并从区域中排除：

```json
[
  [[48.190,24.640],[48.210,24.640],[48.210,24.660],[48.190,24.660]],
  [[48.197,24.647],[48.203,24.647],[48.203,24.653],[48.197,24.653]]
]
```

{% capture defining_polygons_in_metadata_note %}
在 metadata 中定义多边形时，值必须为**字符串**，即使内容为 JSON 数组。
{% endcapture %}
{% include templates/info-banner.md content=defining_polygons_in_metadata_note %}

---

#### 圆形定义格式

圆形定义为包含以下字段的 JSON 对象：

```json
{
  "latitude": 48.1986,
  "longitude": 24.6532,
  "radius": 100.0,
  "radiusUnit": "METER"
}
```

* `latitude` — 圆心纬度。
* `longitude` — 圆心经度。
* `radius` — 圆半径（必须为正数）。
* `radiusUnit` — 计量单位（可选，未指定时默认为 `"METER"`）；可为：
    * `"METER"`
    * `"KILOMETER"`
    * `"FOOT"`
    * `"MILE"`
    * `"NAUTICAL_MILE"`

{% capture defining_circles_in_metadata_note %}
在 metadata 中存储圆形定义时，整个对象必须序列化为**字符串**。
示例 metadata 值：`"{\"latitude\":48.1986,\"longitude\":24.6532,\"radius\":100.0,\"radiusUnit\":\"METER\"}"`
{% endcapture %}
{% include templates/info-banner.md content=defining_circles_in_metadata_note %}

---

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGpsGeofencingFilterNodeConfiguration",
  "type": "object",
  "required": [
    "latitudeKeyName",
    "longitudeKeyName",
    "perimeterType",
    "fetchPerimeterInfoFromMessageMetadata"
  ],
  "properties": {
    "latitudeKeyName": {
      "type": "string",
      "description": "Name of the key that holds the latitude of the point to check."
    },
    "longitudeKeyName": {
      "type": "string",
      "description": "Name of the key that holds the longitude of the point to check."
    },
    "perimeterType": {
      "type": "string",
      "description": "Specifies whether the geofence is a Polygon or a Circle.",
      "enum": [
        "CIRCLE",
        "POLYGON"
      ]
    },
    "fetchPerimeterInfoFromMessageMetadata": {
      "type": "boolean",
      "description": "Whether to load the geofence definition from message metadata or use static configuration."
    },
    "perimeterKeyName": {
      "type": "string",
      "description": "Name of the metadata key that contains the perimeter definition."
    },
    "polygonsDefinition": {
      "type": "string",
      "description": "String representing a JSON array of coordinates for polygon perimeter."
    },
    "centerLatitude": {
      "type": "number",
      "description": "Latitude of the center of the circle perimeter."
    },
    "centerLongitude": {
      "type": "number",
      "description": "Longitude of the center of the circle perimeter."
    },
    "range": {
      "type": "number",
      "description": "Radius of the circle perimeter."
    },
    "rangeUnit": {
      "type": "string",
      "description": "Unit of measurement for the circe radius.",
      "enum": [
        "METER",
        "KILOMETER",
        "FOOT",
        "MILE",
        "NAUTICAL_MILE"
      ]
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. **解析入站消息**
   消息 `data` 必须为有效 JSON 对象。若不是，消息经 `Failure` 连接路由。
2. **提取待检查坐标**
   节点使用配置的键获取纬度和经度：
    * 先在消息 data 中查找。
    * 若未找到，回退到消息 metadata。
      两个值必须存在且可解析为十进制数。否则，消息经 `Failure` 路由。
3. **解析地理围栏（围栏）**
   地理围栏通过以下两种方式之一确定：
    * 若**从 metadata 获取围栏信息**禁用，围栏从静态配置字段构建。
    * 若启用，围栏从**围栏键名**指定的 metadata 键加载，格式取决于配置的**围栏类型**：
        * 若为 *Polygon*：metadata 值必须为包含坐标 JSON 数组的字符串。
        * 若为 *Circle*：metadata 值必须为包含 latitude、longitude、radius 及可选 radius unit 的 JSON 对象的字符串。
          若 metadata 键缺失或包含无效值，消息经 `Failure` 路由。
4. **检查点是否在围栏内**
    * 对于**圆形**围栏，节点计算点与中心之间的测地距离。若距离**小于**配置的半径，则视为**在内部**。
    * 对于**多边形**围栏，节点检查点是否位于定义的形状内。若提供多个多边形，任一包含多边形即算通过。完全被其他多边形包围的多边形视为**孔**。
5. **路由消息**
    * 若点在围栏**内部** → 经 `True` 连接路由。
    * 若点在围栏**外部** → 经 `False` 连接路由。
    * 若解析、坐标提取或围栏解析过程中发生错误 → 经 `Failure` 连接路由。

{% capture normalization_note %}
经度在内部进行规范化，支持跨越 ±180° 经线的多边形。
{% endcapture %}
{% include templates/info-banner.md content=normalization_note %}

## 输出连接

* `True`：
    * 提取的点位于配置的地理围栏（圆形或多边形）**内部**。
* `False`：
    * 提取的点位于配置的地理围栏**外部**（或恰好在圆形边界上）。
* `Failure`：
    * 入站 data 不是 JSON 对象。
    * data 和 metadata 中均缺少纬度/经度或值非数字。
    * **从 metadata 获取围栏信息**已启用但围栏定义缺失或无效。
    * 其他意外错误。

## 示例

以下示例仅展示**相关**字段。除非另有说明，其他消息字段可为任意值。

### 示例 1 — 点在静态圆形内 → `True`

**入站消息**

Data:

```json
{
  "latitude": 48.199,
  "longitude": 24.653
}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": false,
  "perimeterType": "CIRCLE",
  "centerLatitude": 48.1986,
  "centerLongitude": 24.6532,
  "range": 150.0,
  "rangeUnit": "METER"
}
```

**结果**

经 **`True`** 路由

**说明**

该点在配置的圆心 150 米范围内。

---

### 示例 2 — 点在静态圆形外 → `False`

**入站消息**

Data:

```json
{
  "latitude": 48.205,
  "longitude": 24.660
}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": false,
  "perimeterType": "CIRCLE",
  "centerLatitude": 48.1986,
  "centerLongitude": 24.6532,
  "range": 100.0,
  "rangeUnit": "METER"
}
```

**结果**

经 **`False`** 路由

**说明**

该点距中心超过 100 米，位于地理围栏外。

---

### 示例 3 — 点在静态多边形内 → `True`

**入站消息**

Data:

```json
{
  "latitude": 48.200,
  "longitude": 24.650
}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": false,
  "perimeterType": "POLYGON",
  "polygonsDefinition": "[[48.195,24.645],[48.205,24.645],[48.205,24.655],[48.195,24.655]]"
}
```

**结果**

经 **`True`** 路由

**说明**

该点位于定义的矩形多边形内。

---

### 示例 4 — 点在带孔多边形内部孔中 → `False`

**入站消息**

Data:

```json
{
  "latitude": 48.200,
  "longitude": 24.650
}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": false,
  "perimeterType": "POLYGON",
  "polygonsDefinition": "[[[48.190,24.640],[48.210,24.640],[48.210,24.660],[48.190,24.660]], [[48.197,24.647],[48.203,24.647],[48.203,24.653],[48.197,24.653]]]"
}
```

**结果**

经 **`False`** 路由

**说明**

外多边形包含该点，但其位于内部孔中。

---

### 示例 5 — 点在 metadata 中的圆形围栏内 → `True`

**入站消息**

Data:

```json
{
  "latitude": 48.1988,
  "longitude": 24.6531
}
```

Metadata:

```json
{
  "geofence": "{\"latitude\":48.1986,\"longitude\":24.6532,\"radius\":100.0,\"radiusUnit\":\"METER\"}"
}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": true,
  "perimeterKeyName": "geofence",
  "perimeterType": "CIRCLE"
}
```

**结果**

经 **`True`** 路由

**说明**

围栏从 metadata 加载，该点位于定义的圆形内。

---

### 示例 6 — 点在 metadata 中的多边形围栏外 → `False`

**入站消息**

Data:

```json
{
  "latitude": 48.210,
  "longitude": 24.670
}
```

Metadata:

```json
{
  "zone": "[[48.195,24.645],[48.205,24.645],[48.205,24.655],[48.195,24.655]]"
}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": true,
  "perimeterKeyName": "zone",
  "perimeterType": "POLYGON"
}
```

**结果**

经 **`False`** 路由

**说明**

该点位于 metadata 中定义的多边形外。

---

### 示例 7 — 坐标取自 metadata → `True`

**入站消息**

Data:

```json
{
  "type": "location-report"
}
```

Metadata:

```json
{
  "latitude": "48.199",
  "longitude": "24.653",
  "geofence": "{\"latitude\":48.1986,\"longitude\":24.6532,\"radius\":200.0}"
}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": true,
  "perimeterKeyName": "geofence",
  "perimeterType": "CIRCLE"
}
```

**结果**

经 **`True`** 路由

**说明**

在 metadata 中找到坐标且与地理围栏匹配。

---

### 示例 8 — 缺少坐标 → `Failure`

**入站消息**

Data:

```json
{
  "type": "heartbeat"
}
```

Metadata:

```json
{}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": false,
  "perimeterType": "CIRCLE",
  "centerLatitude": 48.1986,
  "centerLongitude": 24.6532,
  "range": 100.0,
  "rangeUnit": "METER"
}
```

**结果**

经 **`Failure`** 路由

**说明**

data 和 metadata 中均不存在 `latitude` 和 `longitude` 键，节点无法提取坐标。

---

### 示例 9 — 无效的围栏 metadata → `Failure`

**入站消息**

Data:
```json
{
  "latitude": 48.1989,
  "longitude": 24.6531
}
```

Metadata:
```json
{
  "zone": "not-a-valid-json"
}
```

**节点配置**

```json
{
  "latitudeKeyName": "latitude",
  "longitudeKeyName": "longitude",
  "fetchPerimeterInfoFromMessageMetadata": true,
  "perimeterKeyName": "zone",
  "perimeterType": "POLYGON"
}
```

**结果**

经 **`Failure`** 路由

**说明**

metadata 键中的值不是有效的 JSON 字符串，无法解析围栏。
