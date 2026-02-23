---
layout: docwithnav-gw
title: BLE 连接器配置
description: ThingsBoard IoT Gateway 的 BLE 协议支持

---

* TOC
{:toc}

本指南将帮助您熟悉 ThingsBoard IoT Gateway 的 BLE 连接器配置。
请使用 [通用配置](/docs/iot-gateway/configuration/) 启用此扩展。
下面将说明连接器配置文件。

**BLE 连接器需要一些系统库，请根据您系统下的包管理器选择对应版本并运行命令安装所需库：**

{% capture systemtogglespec %}
APT-GET<br>%,%deb%,%templates/iot-gateway/ble-requirements-deb.md%br%
YUM<br>%,%rpm%,%templates/iot-gateway/ble-requirements-rpm.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="SystemLibraries" toggle-spec=systemtogglespec %}

<b>BLE 连接器配置文件示例。</b>

{% capture bleConf %}

{
    "name": "BLE Connector",
    "passiveScanMode": true,
    "showMap": false,
    "scanner": {
        "timeout": 10000,
        "deviceName": "STH11"
    },
    "devices": [
        {
            "name": "Temperature and humidity sensor",
            "MACAddress": "4C:65:A8:DF:85:C0",
            "pollPeriod": 5000,
            "showMap": false,
            "timeout": 10000,
            "telemetry": [
                {
                    "key": "temperature",
                    "method": "notify",
                    "characteristicUUID": "226CAA55-6476-4566-7562-66734470666D",
                    "valueExpression": "[2]"
                },
                {
                    "key": "humidity",
                    "method": "notify",
                    "characteristicUUID": "226CAA55-6476-4566-7562-66734470666D",
                    "valueExpression": "[:]"
                }
            ],
            "attributes": [
                {
                    "key": "name",
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
                    "method": "read",
                    "valueExpression": "[0:2]"
                }
            ],
            "attributeUpdates": [
                {
                    "attributeOnThingsBoard": "sharedName",
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB"
                }
            ],
            "serverSideRpc": [
                {
                    "methodRPC": "sharedName",
                    "withResponse": true,
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
                    "methodProcessing": "write"
                }
            ]
        }
    ]
}


{% endcapture %}
{% include code-toggle.liquid code=bleConf params="conf|.copy-code.expandable-20" %}

<br>

为便于理解连接器工作方式，下面以小米温湿度传感器通过网关连接 ThingsBoard 为例说明。

已知设备参数如下：
设备 **MAC 地址**：4C:65:A8:DF:85:C0  
默认名称特征 ID：00002A00-0000-1000-8000-00805F9B34FB（默认特征，ID 来自 [GATT 特征文档](https://www.bluetooth.com/specifications/gatt/characteristics/)）  
温度特征 ID：00002A00-0000-1000-8000-00805F9B34FB（自定义特征，在扫描设备特征后获得）

已为该设备创建默认配置以处理其数据、接收通知并写入部分信息。

在 [主部分](#main-section) 中编写连接器的通用配置（如连接器名称、扫描模式、扫描器等）。  
在 [设备子节](#device-object-subsection) 中编写与设备连接相关的通用配置（如 ThingsBoard 中的设备名称、设备 MAC 地址等）。  
在 [遥测子节](#subsection-telemetry) 中编写处理设备数据的配置（网关从何处获取数据、方法及转换器如何将数据解析为 ThingsBoard 的遥测和属性）。  
在 [属性更新子节](#subsection-attributes) 中编写在收到 ThingsBoard 属性更新请求后重命名设备的配置。  
若设备名为「sharedName」的共享属性发生变化，网关会将该属性的数据写入 ID 为 00002A00-0000-1000-8000-00805F9B34FB 的特征。  

## 主部分

本部分包含连接器的通用设置。

| **参数**                       | **默认值**                                   | **说明**                                                                 |
|:-|:-|-
| name                           | **BLE Connector**                           | 连接器名称，用于日志和持久化设备保存。                                   |
| showMap                        | **false**                                   | 显示所有或特定发现的 MAC 地址设备。                                      |
| scanner                        | **{"timeout": 1000, "deviceName": "NH11"}** | 用于按名称查找特定设备。为可选节，删除后 BLE 连接器将发现**所有**可用设备。 |
| passiveScanMode                | **true**                                    | 使用被动模式扫描。                                                       |
| devices                        |                                             | 包含目标设备数组。                                                       |
|---


该部分配置示例如下：  

```json
{
    "name": "BLE Connector",
    "passiveScanMode": true,
    "showMap": false,
    "scanner": {
        "timeout": 10000,
        "deviceName": "NH11"
    },
    "devices": [
        ...
    ]
}
```

下面介绍发现可用设备的两种方法。
1. **第一种场景**

   在第一种场景中，由于我们不知道设备的 MAC 地址和名称，需将 BLE 连接器配置为显示所有发现的设备。
   需使用以下配置：
   ```json
   {
       ...
       "showMap": true
       ...
   }
   ```
   **网关输出：**

   24:71:89:cc:09:05 - NH11

   54:bb:12:ff:09:01 - Unknown

   23:cc:34:23:bb:56 - XYZ123
2. **第二种场景**

   在第二种场景中，我们知道蓝牙显示设备的名称，仅需获知其 MAC 地址。
   需使用以下配置：
   ```json
   {
       ...
       "showMap": true,
       "scanner": {
           "timeout": 10000,
           "deviceName": "NH11"
       }
       ...
   }
   ```
   **网关输出：**

   24:71:89:cc:09:05 - NH11

### 设备对象子节

本子节包含设备的通用设置及处理数据的各子节。

| **参数**          | **默认值**         | **说明**                                                                                                 |
|:-|:-|-
| name              | **BLE Connector** | ThingsBoard 中的设备名称。                                                                               |
| MACAddress        | **4C:65:A8:DF:C0**| 目标设备的 MAC 地址。                                                                                    |
| deviceType        | **BLEDevice**     | ThingsBoard 中的设备类型，默认无此参数，可自行添加。                                                     |
| pollPeriod        | **5000**          | 读取设备数据的周期（毫秒）。                                                                             |
| showMap           | **false**         | 设为 **true** 将显示设备中所有 GATT 对象（特征、服务等）。                                                 |
| timeout           | **10000**         | BLE 连接器尝试连接设备的时间。                                                                           |
| telemetry         |                   | 处理设备遥测的对象数组。                                                                                 |
| attributes        |                   | 处理设备属性的对象数组。                                                                                 |
| attributeUpdates  |                   | 处理 ThingsBoard 属性更新请求的对象数组。                                                                 |
| serverSideRpc     |                   | 处理 ThingsBoard RPC 请求的对象数组。                                                                    |
|---


该部分配置示例如下：  

```json
{
    "name": "Temperature and humidity sensor",
    "MACAddress": "4C:65:A8:DF:85:C0",
    "showMap": true,
    "pollPeriod": 5000,
    "timeout": 10000,
    "telemetry": [
        ...
    ],
    "attributes": [
        ...
    ],
    "attributeUpdates": [
        ...
    ],
    "serverSideRpc": [
        ...
    ]
}
```

#### 遥测子节

本子节包含将数据解析为遥测的通用设置。

| **参数**              | **默认值**                                  | **说明**                                                                 |
|:-|:-|-
| key                   | **temperature**                            | ThingsBoard 中的遥测名称。                                               |
| method                | **notify**                                 | 特征处理方式（可为 **NOTIFY** 或 **READ**）。                            |
| characteristicUUID    | **226CAA55-6476-4566-7562-66734470666D**   | 设备上的特征 UUID。                                                      |
| valueExpression       | **[0:1]**                                  | 发送至 ThingsBoard 的数据最终形式，[0:1] 将按 Python 切片规则替换为设备数据 |
|---


该部分配置示例如下：  

```json
{
    "key": "temperature",
    "method": "notify",
    "characteristicUUID": "226CAA55-6476-4566-7562-66734470666D",
    "valueExpression": "[0:1]"
},
```

**表中数值可能因您的配置而异。**

例如设备返回字节数组 b'\x08<\x08\x00' 时，**8** 被解析为键的值。

若需将完整响应解析为值，请使用 **"valueExpression": "[:]"**。

更多数据转换示例请参阅 **「数据转换示例」** 部分。



#### 属性子节

本子节包含将数据解析为属性的通用设置。

| **参数**              | **默认值**                                  | **说明**                                                                 |
|:-|:-|-
| key                   | **name**                                   | ThingsBoard 中的遥测名称。                                               |
| method                | **read**                                   | 特征处理方式（可为 **NOTIFY** 或 **READ**）。                             |
| characteristicUUID    | **00002A00-0000-1000-8000-00805F9B34FB**   | 设备上的特征 UUID。                                                      |
| valueExpression       | **[0:1] cm**                               | 发送至 ThingsBoard 的数据最终形式，[0:1] 将按 Python 切片规则替换为设备数据 |
|---


该部分配置示例如下：  

```json
{
    "key": "name",
    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
    "method": "read",
    "valueExpression": "[0:1] cm"
}
```


**The values shown in the table above may differ in your configuration.**

例如设备返回字节串 b'**\x08<\x08\x00**' 时，**8 cm** 被解析为键的值。

若需将完整响应解析为值，请使用 **"valueExpression": "[:]"**。

更多数据转换示例请参阅 **「数据转换示例」** 部分。
<br><br>
  
{% capture bleGATTinfo %}
来自 <a target="_blank" rel="noopener noreferrer" href="https://www.bluetooth.com/specifications/gatt/services/">GATT 规范</a> 的服务和特征也将被解析为设备属性并自动加载至 ThingsBoard。
{% endcapture %}
{% include templates/info-banner.md content=bleGATTinfo %}



#### 数据转换示例

下面列举更多数据转换示例：

**基本场景：** 有一台测量温湿度的设备，设备具有可读特征，收到数据时数据包含温度和湿度。设备数据形式为：**b'\x08<\x08\x00'**，可读格式为：**[8, 34]**（数组第一个元素为温度，第二个为湿度）。
1. 仅读取温度值
   
   **"valueExpression": "[0]"**
   
   发送至 ThingsBoard 的数据：**8**
2. 仅读取湿度值

   **"valueExpression": "[1]"**
   
   发送至 ThingsBoard 的数据：**34**
3. 读取所有值

   "valueExpression": "[:]" 或 "valueExpression": "[0:2]"
   
   发送至 ThingsBoard 的数据：**834**
4. 读取所有值及单位

   **"valueExpression": "[0]°C [1]%"**
   
   发送至 ThingsBoard 的数据：**8°C 34%**    

#### 属性更新子节

本子节包含处理 ThingsBoard 属性更新请求的设置。

| **参数**               | **默认值**                                  | **说明**                                                     |
|:-|:-|-
| attributeOnThingsBoard | **sharedName**                              | ThingsBoard 中共享设备属性的名称。                            |
| characteristicUUID     | **00002A00-0000-1000-8000-00805F9B34FB**    | 将写入属性值的特征 UUID。                                     |
|---


该部分配置示例如下：  

```json
{
    "attributeOnThingsBoard": "sharedName",
    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB"
}
```

{% capture bleAttrUpdInfo %}
处理属性更新请求时，特征需支持 **WRITE** 方法。
{% endcapture %}
{% include templates/info-banner.md content=bleAttrUpdInfo %}


#### 服务端 RPC 子节

本子节包含处理 ThingsBoard RPC 请求的设置。

| **参数**             | **默认值**                                  | **说明**                                                                  |
|:-|:
| methodRPC            | **rpcMethod1**                              | RPC 方法名称。                                                             |
| withResponse         | **true**                                    | 为 true 时，将向 ThingsBoard 发送响应。                                    |
| characteristicUUID   | **00002A00-0000-1000-8000-00805F9B34FB**    | 特征 UUID。                                                                |
| methodProcessing     | **read**                                    | 特征处理方法（**READ**/**WRITE**/**NOTIFY**）。                            |
|---


该部分配置示例如下：  

```json
{
    "methodRPC": "rpcMethod1",
    "withResponse": true,
    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
    "methodProcessing": "read"
}
```


## 下一步

探索与 ThingsBoard 主要功能相关的指南：

 - [连接 BLE 传感器](/docs/iot-gateway/guides/how-to-connect-ble-sensor-using-gateway/) - 如何使用 ThingsBoard IoT Gateway 连接 BLE 传感器
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据
