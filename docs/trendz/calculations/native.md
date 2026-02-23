---
layout: docwithnav-trendz
title: 原生计算字段
description: 原生计算字段
---

* TOC
{:toc}

原生计算是设计为限制最少、灵活性最大的计算字段。它们允许您
自由定义使用哪些关系、遥测或属性以及使用哪个时间范围。您可以使用五个输入
参数和五个可用函数，从任意实体在任意时间范围内获取遥测、属性或关系。
本文稍后将介绍所有这些函数和参数。

## 规则

唯一规则是所需的输出格式。代码必须返回时间戳/值对象的数组：

```
[{"ts": <ts>, "value": <value>}]
```

此时间序列可在为发起者设置重处理或刷新任务时保存到 ThingsBoard。

## 参数

在原生计算中，您可以使用以下参数：

1. **startTs** - 起始时间戳（毫秒）
2. **endTs** - 结束时间戳（毫秒）
3. **groupBy** - 分组间隔（'minute'、'hour'、'day'、'week' 或 'month'）
4. **tzName** - 运行任务用户时区（如测试、刷新或重处理）
5. **tzOffsetMs** - UTC 与用户时区之间的毫秒偏移

这些参数可能因计算上下文而异。

## 函数

### get_originator_id()

返回当前计算发起者的 ID（UUID）。

```python
originator_id = get_originator_id()
```

### get_originator_type()

返回当前发起者的类型（'DEVICE' 或 'ASSET'）。

```python
originator_type = get_originator_type()
```

### get_telemetries()

从任意可用实体获取遥测数据。

```python
get_telemetries(
    keys,        # required: list of telemetry keys (e.g., ['key1', 'key2'])
    from_ts,# optional: start timestamp in ms (default startTs parameter)
    to_ts,  # optional: end timestamp in ms (default endTs parameter)
    entity_id, # optional: entity ID (defaults to originator ID)
    entity_type # optional: entity type (DEVICE or ASSET, defaults to originator type)
)
```

返回遥测值字典：

```
{
    "key1": [{"value": "<value>", "ts": "<ts>"}, ...],
    "key2": [{"value": "<value>", "ts": "<ts>"}],
    ...
}
```

#### 示例

使用默认时间范围从发起者获取遥测（temperature 和 heat_consumption）：

```python
keys = ['temperature', 'heat_consumption']
telemetries = get_telemetries(keys)
```

使用自定义时间范围获取遥测：

```python
keys = ['temperature', 'heat_consumption']
from_ts = 1704067200000 # 1 Jan 2024
to_ts = 1735689600000   # 1 Jan 2025
telemetries = get_telemetries(keys, from_ts=from_ts, to_ts=to_ts)
```

使用默认时间范围从 id 为 `8c790660-782a-4c7b-ae07-0c3163a6f968` 的设备获取遥测：

```python
keys = ['temperature', 'heat_consumption']
entity_id = '8c790660-782a-4c7b-ae07-0c3163a6f968'
entity_type = 'DEVICE'
telemetries = get_telemetries(keys, entity_id=entity_id, entity_type=entity_type)
```

使用自定义时间范围从 id 为 `8c790660-782a-4c7b-ae07-0c3163a6f968` 的设备获取遥测：

```python
keys = ['temperature', 'heat_consumption']
from_ts = 1704067200000 # 1 Jan 2024
to_ts = 1735689600000   # 1 Jan 2025
entity_id = '8c790660-782a-4c7b-ae07-0c3163a6f968'
entity_type = 'DEVICE'
telemetries = get_telemetries(keys, from_ts=from_ts, to_ts=to_ts, entity_id=entity_id, entity_type=entity_type)
```

在自定义逻辑中使用获取的遥测：

```python
if not telemetries['temperature']:
    print('No temperature telemetry found in the given range.')
    return []

for temperature_reading in telemetries['temperature']:
    value = temperature_reading['value']
    ts = temperature_reading['ts']
    # Perform custom logic here
```

### get_attributes()

从任意可用实体获取属性数据。

```python
get_attributes(
    attributes,     # required: list of attributes [{'scope': 'SERVER_SCOPE', 'key': 'attribute_key'}, ...]
    entity_id, # optional: entity ID (defaults to originator ID)
    entity_type # optional: entity type (DEVICE or ASSET, defaults to originator type)
)
```

返回按范围分组的字典：

```
{
    "SERVER_SCOPE": {"attribute_key_1": "<attribute_value_1>", ...},
    "CLIENT_SCOPE": {...},
    "SHARED_SCOPE": {...}
}
```

#### 示例

从发起者获取 area 属性（服务器范围）：

```python
attributes = [{'scope': 'SERVER_SCOPE', 'key': 'area'}]
fetched_attributes = get_attributes(attributes)
area = fetched_attributes.get('SERVER_SCOPE', {}).get('area')
```

从 id 为 `4e0aba8c-772d-4d61-9f16-3d8c896b1600` 的资产获取 area 属性（服务器范围）：

```python
attributes = [{'scope': 'SERVER_SCOPE', 'key': 'area'}]
entity_id = '4e0aba8c-772d-4d61-9f16-3d8c896b1600'
entity_type = 'ASSET'
fetched_attributes = get_attributes(attributes, entity_id=entity_id, entity_type=entity_type)
area = fetched_attributes.get('SERVER_SCOPE', {}).get('area')
```

### get_relations()

从任意可用实体获取关系数据。

```python
get_relations(
    entity_id, # optional: entity ID (defaults to originator ID)
    entity_type, # optional: entity type (DEVICE or ASSET, defaults to originator type)
    direction, # optional: direction (FROM or TO), keep empty if any
    relation_type, # optional: relation type, keep empty if any 
    target_entity_type, # optional: target entity type, keep empty if any 
    target_entity_profile_name # optional: target entity profile name, keep empty if any 
)
```

返回关系列表：

```
[
  {
    "relationType": "<relation type>",
    "direction": "<FROM or TO>",
    "entityId": "<target entity id>",
    "entityType": "<DEVICE or ASSET>",
    "entityProfileName": "<profile name>"
  }, ...
]
```

#### 示例

获取发起者的所有关系：

```python
relations = get_relations()
```

仅获取类型为 Contains、方向为 TO、目标资产配置文件为 EM apartment 的关系：

```python
relations = get_relations(direction='TO', relation_type='Contains', target_entity_type='ASSET', target_entity_profile_name='EM apartment')
```

获取 id 为 `8c790660-782a-4c7b-ae07-0c3163a6f968` 的设备的所有关系：

```python
entity_id = '8c790660-782a-4c7b-ae07-0c3163a6f968'
entity_type = 'DEVICE'
relations = get_relations(entity_id=entity_id, entity_type=entity_type)
```

获取 id 为 `8c790660-782a-4c7b-ae07-0c3163a6f968` 的设备的类型为 Contains、方向为 TO、目标资产配置文件为 EM apartment 的关系：

```python
entity_id = '8c790660-782a-4c7b-ae07-0c3163a6f968'
entity_type = 'DEVICE'
relations = get_relations(entity_id=entity_id, entity_type=entity_type, direction='TO', relation_type='Contains', target_entity_type='ASSET', target_entity_profile_name='EM apartment')
```

关系用法：从关联资产获取 area 属性：

```python
relations = get_relations(direction='TO', relation_type='Contains', target_entity_type='ASSET', target_entity_profile_name='EM apartment')
if not relations:
    print('No associated EM apartment found.') 
    return []

apartment_id = relations[0]['entityId']
apartment_type = relations[0]['entityType']
attributes = [{'scope': 'SERVER_SCOPE', 'key': 'area'}]
fetched_attributes = get_attributes(attributes, entity_id=apartment_id, entity_type=apartment_type)
area = fetched_attributes.get('SERVER_SCOPE', {}).get('area')
```

## 最佳实践

在以下情况使用原生计算：

* 您需要灵活的关系导航或遥测获取。
* 您想使用指标浏览器进行实验。

在以下情况避免使用原生计算：

* 简单或批量计算可实现相同结果（它们性能更好）。

## 限制

原生计算仅支持 **固定时间范围** 策略。

## 示例

示例：计算热表与建筑平均温度的温差的原生计算：

```python
import statistics

# 1. 从当前 EM 热表获取 'temperature' 遥测。
heat_meter_temperature_data = get_telemetries(keys=["temperature"])
if not heat_meter_temperature_data or "temperature" not in heat_meter_temperature_data:
    print("Temperature telemetry not found for the heat meter.")
    return []

heat_meter_temperature_values = heat_meter_temperature_data["temperature"]
if not heat_meter_temperature_values:
    print("Temperature telemetry values are empty.")
    return []

# 2. 使用关系类型 'Contains'（方向 TO）从 'EM heat meter' 遍历到 'EM apartment'。
apartment_relations = get_relations(direction="TO", relation_type="Contains", target_entity_type="ASSET", target_entity_profile_name="EM apartment")
if not apartment_relations:
    print("No related apartment found for the heat meter.")
    return []

apartment_id = apartment_relations[0]["entityId"]
apartment_type = apartment_relations[0]["entityType"]
print(f"Apartment ID: {apartment_id}")

# 3. 使用关系类型 'Contains'（方向 TO）从 'EM apartment' 遍历到 'EM building'。
building_relations = get_relations(entity_id=apartment_id, entity_type=apartment_type, direction="TO", relation_type="Contains", target_entity_type="ASSET", target_entity_profile_name="EM building")
if not building_relations:
    print("No related building found for the apartment.")
    return []

building_id = building_relations[0]["entityId"]
building_type = building_relations[0]["entityType"]
print(f"Building ID: {building_id}")

# 4. 使用关系类型 'Contains'（方向 FROM）查找与 'EM building' 相关的所有 'EM apartment' 实体。
apartment_relations_from_building = get_relations(entity_id=building_id, entity_type=building_type, direction="FROM", relation_type="Contains", target_entity_type="ASSET", target_entity_profile_name="EM apartment")
if not apartment_relations_from_building:
    print("No related apartments found for the building.")
    return []

building_heat_meter_temperatures = {}
# 5. 对于每个 'EM apartment'，使用关系类型 'Contains'（方向 FROM）查找所有相关的 'EM heat meter' 实体。
for apartment in apartment_relations_from_building:
    apartment_id = apartment["entityId"]
    apartment_type = apartment["entityType"]

    heat_meter_relations_from_apartment = get_relations(entity_id=apartment_id, entity_type=apartment_type, direction="FROM", relation_type="Contains", target_entity_type="DEVICE", target_entity_profile_name="EM heat meter")
    if heat_meter_relations_from_apartment:
        for heat_meter in heat_meter_relations_from_apartment:
            heat_meter_id = heat_meter["entityId"]
            heat_meter_type = heat_meter["entityType"]

            # 6. 对于步骤 5 中找到的每个 'EM heat meter'，获取 'temperature' 遥测。
            heat_meter_temperature_data = get_telemetries(keys=["temperature"], entity_id=heat_meter_id, entity_type=heat_meter_type)
            if heat_meter_temperature_data and "temperature" in heat_meter_temperature_data:
                heat_meter_temperature_values = heat_meter_temperature_data["temperature"]
                if heat_meter_temperature_values:
                    for temp_data in heat_meter_temperature_values:
                        ts = temp_data["ts"]
                        value = temp_data["value"]
                        try:
                            value = float(value)
                            if ts not in building_heat_meter_temperatures:
                                building_heat_meter_temperatures[ts] = []
                            building_heat_meter_temperatures[ts].append(value)
                        except ValueError as e:
                            print(f"Error converting temperature value to float: {e}")
                            continue

# 7. 计算建筑内所有 'EM heat meter' 实体在每个时间戳的平均温度。
building_average_temperatures = {}
for ts, temperatures in building_heat_meter_temperatures.items():
    if temperatures:
        building_average_temperatures[ts] = statistics.mean(temperatures)

# 8. 计算每个时间间隔的温差。
temperature_differences = []
for temp_data in heat_meter_temperature_values:
    ts = temp_data["ts"]
    heat_meter_temperature = temp_data["value"]
    try:
        heat_meter_temperature = float(heat_meter_temperature)
        if ts in building_average_temperatures:
            building_average_temperature = building_average_temperatures[ts]
            temperature_difference = heat_meter_temperature - building_average_temperature
            temperature_differences.append({"ts": ts, "value": temperature_difference})
    except ValueError as e:
        print(f"Error converting temperature value to float: {e}")
        continue

# 9. 输出 'temperature_difference' 作为指标值。
res = temperature_differences
return res
```

## 下一步

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}
