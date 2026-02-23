---
layout: docwithnav-gw
title: BACnet 连接器配置
description: ThingsBoard IoT Gateway 的 BACnet 协议支持

---

* TOC
{:toc}

## 概述

本文档将帮助您为 ThingsBoard IoT Gateway 配置 BACnet 连接器。我们将用简单易懂的方式解释配置参数，便于您理解与操作。BACnet 协议广泛应用于楼宇自动化与控制系统，如暖通空调（HVAC）、照明控制、门禁控制以及消防检测系统等。请使用 [通用配置](/docs/iot-gateway/configuration/){:target="_blank"} 启用此扩展。

BACnet 连接器使 ThingsBoard IoT Gateway 能够与 BACnet 设备通信，实现数据交换与控制。该连接器可通过用户界面表单进行配置，帮助您建立与 BACnet 设备的连接、采集数据并写入设备。下面我们将逐一说明所有可用设置，便于您理解整体工作方式。

{% capture difference %}
**请注意**：
在创建连接器之前，请先连接网关。否则界面将显示旧版配置字段以保持向后兼容。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 配置模式

BACnet 连接器支持两种配置模式：**基本**（Basic）和**高级**（Advanced）。

- **基本**模式面向不熟悉 ThingsBoard IoT Gateway 的用户，通过最少配置快速完成连接器设置，提供简化的界面和必要选项。
- **高级**模式面向需要更细致配置控制的用户，提供更多选项和高级使用场景的灵活性。

{% capture difference %}
**请注意：**
若不熟悉 IoT Gateway，请使用「**基本**」配置模式；若您熟悉 IoT Gateway 配置，则可使用「**高级**」配置模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

您可通过配置页面顶部的切换按钮在两种模式间切换：

![image](/images/gateway/bacnet-connector/bacnet-modes-toggle.png)

## 通用设置

{% include /templates/iot-gateway/connector-commons/general-settings.md %}

![image](/images/gateway/bacnet-connector/bacnet-general-basic-1-ce.png)

{% capture difference %}
设置中的「通用」标签页在基本和高级配置中相同。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 应用

本部分配置用于在 BACnet 网络中配置网关。以下参数用于配置应用设置：

{% include /templates/iot-gateway/bacnet-connector/bacnet-application-section-basic.md %}

## 高级应用设置

可配置额外的应用参数，如：APDU 长度、分段、网络号及发现超时。

| **参数**                     | **默认值** | **说明**                                                                                                        |
|:-----------------------------|:------------------|------------------------------------------------------------------------------------------------------------------|
| APDU 长度（字节）            | **1476**          | APDU 的最大长度。                                                                                                |
| 分段                         | **Both**          | 传输大型 BACnet 消息的分段类型。可选：**Both**、**Transmit**、**Receive**、**None**。                             |
| 网络号                       | **3**             | 网络段的标识符。                                                                                                 |
| 发现超时（秒）               | **5**             | 连接器尝试发现 BACnet 设备的时长。                                                                               |
| ---                          |                   |                                                                                                                  |

{% capture difference %}
所有配置参数及其详细说明请参阅 [高级配置](/docs/iot-gateway/config/bacnet/#advanced-configuration) 部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/bacnet-connector/bacnet-advanced-application-settings.png)

## 数据映射

本配置部分包含可连接至连接器并发送数据的 BACnet 设备数组。未包含在此数组中的 BACnet 设备将被连接器拒绝。

{% include /templates/iot-gateway/bacnet-connector/bacnet-device-subsection-basic.md %}

### 属性和时序数据

本配置部分包含处理传入数据的参数。您可指定哪些数据作为设备属性、哪些作为时序数据。属性用于存储静态或较少变化的数据，时序数据用于存储动态或频繁变化的数据。

{% include /templates/iot-gateway/bacnet-connector/device-time-series-and-attributes-basic-section.md %}

### 使用示例

{% capture bacnet-attributes-timeseries-examples %}
Dynamic device name/profile<small></small>%,%dynamicdevicenameandprofile%,%templates/iot-gateway/bacnet-connector/examples/time-series-and-attributes/dynamic-device-name-and-profile.md%br%
Alternative responses addresses<small></small>%,%alternativeresponsesaddresses%,%templates/iot-gateway/bacnet-connector/examples/time-series-and-attributes/alternative-responses-addresses.md%br%
Discovering all device<small>(advanced configuration mode only)</small>%,%discoveringalldevice%,%templates/iot-gateway/bacnet-connector/examples/time-series-and-attributes/discovering-all-device.md%br%
Reading all device objects<small>(advanced configuration mode only)</small>%,%readingalldeviceobjects%,%templates/iot-gateway/bacnet-connector/examples/time-series-and-attributes/reading-all-device-objects.md%br%
Filtering objects and properties<small>(advanced configuration mode only)</small>%,%filteringobjectsandproperties%,%templates/iot-gateway/bacnet-connector/examples/time-series-and-attributes/filtering-objects-and-properties.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="bacnet-attributes-timeseries-examples" toggle-spec=bacnet-attributes-timeseries-examples %}

## 请求映射

请求映射部分用于配置 ThingsBoard 平台实例与设备的交互方式，即平台如何向设备请求数据、如何更新设备属性以及如何向设备发送 RPC 命令。

BACnet 连接器支持以下请求映射：

- **属性更新**：支持从 ThingsBoard 平台实例更新设备对象值。
- **RPC 方法**：支持向设备发送 RPC 命令。使用 RPC 方法可读取或设置 BACnet 设备对象值。BACnet 连接器支持多种 RPC 方法，例如：
  - **保留的 GET/SET 方法**：为每个属性和时序参数自动创建，可用于读取或设置 BACnet 设备对象值。
  - **可配置的 RPC 到设备**：可在连接器配置中定义自定义 RPC 命令并发送至设备。

### 属性更新

本小节包含 ThingsBoard 平台实例发起属性更新请求的配置。

ThingsBoard 支持预配设备属性，并可从设备应用拉取部分属性。可将其视为设备的远程配置，使设备能够从 ThingsBoard 请求共享属性。详见 [用户指南](/docs/user-guide/attributes/)。

以下参数用于配置属性更新：
- **Key**：ThingsBoard 中共享属性的键，可为静态值。
- **Object ID**：BACnet 设备中的对象 ID。
- **Object Type**：BACnet 设备中的对象类型。
- **Property ID**：BACnet 设备中的属性 ID。

{% capture difference %}
所有配置参数及其详细说明请参阅 [高级配置](/docs/iot-gateway/config/bacnet/#device-attribute-updates) 部分。更多使用示例请参阅 [使用示例](/docs/iot-gateway/config/bacnet/#usage-examples-1) 部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/bacnet-connector/attribute-updates-overview.png)

{% include /templates/iot-gateway/bacnet-connector/device-attribute-updates-basic-section.md %}

### RPC 方法

ThingsBoard 支持向直接连接或经网关连接的设备发送 [RPC 命令](https://thingsboard.io/docs/user-guide/rpc/)。以下参数用于配置 RPC 方法：
- **Method** - the RPC method name.
- **Request Type** - “**writeProperty**” to write data and “**readProperty**” to read data.
- **Object ID** - the object id in the BACnet device.
- **Object Type** - the object type in the BACnet device.
- **Property ID** - the property id in the BACnet device.
- **Request Timeout** - timeout in milliseconds for the RPC method execution.

{% capture difference %}
All configuration parameters list, and their detailed description can be found in the
[Advanced configuration](/docs/iot-gateway/config/bacnet/#device-rpc-methods) section.

More usage examples can be found in the [Example usage](/docs/iot-gateway/config/bacnet/#usage-examples-1) section.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/bacnet-connector/rpc-overview.png)

{% include /templates/iot-gateway/bacnet-connector/device-rpc-basic-section.md %}

{% capture methodFilterOptions %}
此外，每个遥测和属性参数均内置 GET 和 SET RPC 方法，
无需手动配置。参见 [指南](/docs/iot-gateway/guides/how-to-use-get-set-rpc-methods)。
{% endcapture %}
{% include templates/info-banner.md content=methodFilterOptions %}

### 使用示例

{% capture bacnet-shared-attributes-rpc-examples %}
Attribute Updates<small></small>%,%sharedattribute%,%templates/iot-gateway/bacnet-connector/examples/shared-attributes-and-rpc/attribute-updates.md%br%
RPC to Device<small></small>%,%rpctodevice%,%templates/iot-gateway/bacnet-connector/examples/shared-attributes-and-rpc/rpc-to-device.md%br%
Reserved RPCs<small></small>%,%reservedrpc%,%templates/iot-gateway/bacnet-connector/examples/shared-attributes-and-rpc/reserved-rpc.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="bacnet-shared-attributes-rpc-examples" toggle-spec=bacnet-shared-attributes-rpc-examples %}

## EDE 文件解析（仅高级配置模式）

BACnet 连接器支持 EDE 文件解析。 EDE（工程数据交换）文件用于描述 BACnet 设备的结构与属性。通过解析 EDE 文件，BACnet 连接器可自动配置自身，以与文件中描述的设备交互。

要使用 EDE 文件解析，需在连接器配置中提供 EDE 文件路径。连接器将读取该文件并提取与 BACnet 设备通信所需的信息。EDE 文件应为 CSV 格式并符合 BACnet EDE 规范。

下面以 EDE 文件解析配置为例说明。

我们将使用从 YABE（Yet Another BACnet Explorer）导出的 EDE 文件。该文件包含一个具有多个对象的 BACnet 设备描述，示例文件如下：

![image](/images/gateway/bacnet-connector/ede-file-overview.png)

现在配置 BACnet 连接器以使用此 EDE 文件。 在高级配置模式下，粘贴以下连接器配置（**请确保使用正确的 EDE 文件路径**）：

```json
{
  "application": {
    "objectName": "TB_gateway",
    "host": "YOUR_HOST",
    "port": 47808,
    "objectIdentifier": 599,
    "vendorIdentifier": 15,
    "maxApduLengthAccepted": 1476,
    "segmentationSupported": "segmentedBoth",
    "deviceDiscoveryTimeoutInSec": 5
  },
  "edeFilePath": "/path/to/your/file.ede"
}
```
{:.copy-code}

{% capture difference %}
**请注意**：
- EDE 文件解析仅在**高级**配置模式下可用。
- EDE 文件需可被 IoT Gateway 访问。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

应用配置后，BACnet 连接器将解析 EDE 文件并自动配置自身，以与文件中描述的 BACnet 设备交互。随后可使用连接器从设备读取数据、更新设备属性并发送 RPC 命令。如下方截图所示，连接器已根据 EDE 文件自动创建设备名称与配置文件，以及文件中的全部属性和时序数据：

![image](/images/gateway/bacnet-connector/ede-device-overview.png)

## 高级配置

高级配置部分提供 BACnet 连接器所有可用参数的详细说明。

### 应用

应用配置参数用于在 BACnet 网络中配置网关。

| **Parameter**                                          | **Default value**       | **Description**                                                                                                       |
|:-------------------------------------------------------|:------------------------|-----------------------------------------------------------------------------------------------------------------------|
| application.objectName                                 | **ThingsBoard Gateway** | The gateway object name in the BACnet network.                                                                        |
| application.host                                       |                         | The gateway host in the BACnet network                                                                                |
| application.port                                       | **47808**               | The gateway port in the BACnet network.                                                                               |
| application.mask                                       |                         | The gateway mask in the BACnet network.                                                                               |
| application.networkNumber                              |                         | Identifier of the network segment.                                                                                    |
| application.objectIdentifier                           | **599**                 | The gateway object identifier in the BACnet network.                                                                  |
| application.vendorIdentifier                           | **15**                  | The gateway vendor identifier in the BACnet network.                                                                  |
| application.maxApduLengthAccepted                      | **1476**                | Maximal length of the APDU.                                                                                           |
| application.segmentationSupported                      | **segmentedBoth**       | The type of segmentation, can be: **segmentedBoth**, **segmentedTransmit**, **segmentedReceive**, **noSegmentation**. |
| application.deviceDiscoveryTimeoutInSec (in sec)       | **5**                   | Timeout for discovering devices.                                                                                      |
| application.devicesDiscoverPeriodSeconds (in sec)      | **30**                  | Period of time when the connector will try to discover BACnet devices.                                                |
| application.devicesRescanObjectsPeriodSeconds (in sec) | **60**                  | The period of time when the connector will try to reread device objects that it failed to read last time.             |
| application.loadProprietaryDevices *                   | **false**               | Allow dynamically loading proprietary devices from extensions.                                                        |
| ---                                                    |                         |                                                                                                                       |

{% capture difference %}
\* -- Feature available from Gateway v.3.8.0 and only in advanced configuration mode. You need to upload your 
proprietary device extension to the `/extensions/bacnet/proprietary` folder of the IoT Gateway installation directory. 
You can also find an example of such a proprietary device [here](https://github.com/thingsboard/thingsboard-gateway/blob/master/thingsboard_gateway/extensions/bacnet/proprietary/desigo_cc.py){:target="_blank"}.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

应用配置示例：

```json
{
  "application": {
    "objectName": "TB_gateway",
    "host": "192.168.1.168",
    "port": 47808,
    "objectIdentifier": 599,
    "vendorIdentifier": 15,
    "maxApduLengthAccepted": 1476,
    "segmentationSupported": "segmentedBoth",
    "networkNumber": 3,
    "deviceDiscoveryTimeoutInSec": 5
  }
}
```

### 外部设备（v.3.7.6+）

外部设备配置参数用于将网关配置为 BACnet 网络中的外部设备。当网关位于 NAT 后且需向 BACnet 广播管理设备（BBMD）注册时，此功能很有用。

| **Parameter**              | **Default value** | **Description**                                   |
|:---------------------------|-------------------|---------------------------------------------------|
| foreignDevice.ttl (in sec) | **900**           | Time to live for the foreign device registration. |
| foreignDevice.address      | **0.0.0.0**       | The address of the BBMD to register with.         |
| ---                        |                   |                                                   |

### 设备

设备列表包含可连接至连接器并与之交互的 BACnet 设备数组。未包含在此数组中的 BACnet 设备将被连接器拒绝。

| **Parameter**                                      | **Description**                                                                                                                             |
|:---------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| devices[].host                                     | The host of the device.                                                                                                                     |
| devices[].port                                     | The port of the device.                                                                                                                     |
| devices[].mask                                     | The mask of the device.                                                                                                                     |
| devices[].networkMask                              | The identifier of the device network segment.                                                                                               |
| devices[].pollPeriod                               | The period of time when the connector will try to poll the BACnet device.                                                                   |
| devices[].altResponsesAddresses[]                  | Array of alternative addresses for device responses (you can find detail examples [here](/docs/iot-gateway/config/bacnet/#usage-examples)). |
| devices[].reportStrategy                           | Report strategy object using for configuring report strategy for device.                                                                    |                                          
| devices[].deviceInfo                               | Device info object using for configuring device name and profile.                                                                           |
| devices[].deviceInfo.deviceNameExpressionSource    | The source of the device name: **constant**, **expression**.                                                                                |
| devices[].deviceInfo.deviceNameExpression          | The device name (you can find detail examples [here](/docs/iot-gateway/config/bacnet/#usage-examples)).                                     |
| devices[].deviceInfo.deviceProfileExpressionSource | The source of the device profile: **constant**, **expression**.                                                                             |
| devices[].deviceInfo.deviceProfileExpression       | The device profile name (you can find detail examples [here](/docs/iot-gateway/config/bacnet/#usage-examples)).                             |
| ---                                                |                                                                                                                                             |

设备映射配置示例：

```json
{
  "devices": [
    {
      "deviceInfo": {
        "deviceNameExpression": "BACnet Device ${objectName}",
        "deviceProfileExpression": "default",
        "deviceNameExpressionSource": "expression",
        "deviceProfileExpressionSource": "constant"
      },
      "host": "192.168.2.110",
      "port": "47808",
      "pollPeriod": 10000,
      "attributes": [],
      "timeseries": [],
      "attributeUpdates": [],
      "serverSideRpc": []
    }
  ]
}
```

#### 设备名称/配置文件表达式可用变量

可使用以下参数构造设备名称和配置文件：
- `${objectName}` - the device object name of the BACnet device.
- `${objectId}` - the device object identifier of the BACnet device.
- `${vendorId}` - the device vendor identifier of the BACnet device.
- `${address}` - the device host address.
- `${routerId}` - the device router identifier.
- `${routerName}` - the device router name.
- `${routerAddress}` - the device router address.
- `${routerVendorId}` - the device router vendor identifier.

详细示例请参阅 [此处](/docs/iot-gateway/config/bacnet/#usage-examples)。

#### 设备属性和时序数据

| **Parameter**                         | **Description**                                                                                                 |
|:--------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| devices[].attributes[]                | This subsection contains parameters of the device data, that will be interpreted as attributes for the device.  |
| devices[].attributes[].key            | The name for time series on the platform.                                                                       |
| devices[].attributes[].objectType     | The object type in the BACnet device.                                                                           |
| devices[].attributes[].objectId       | The object id in the BACnet device.                                                                             |
| devices[].attributes[].propertyId     | The property id in the BACnet device.                                                                           |
| devices[].attributes[].reportStrategy | Report strategy object using for configuring report strategy for device attribute.                              |
| devices[].timeseries[]                | This subsection contains parameters of the device data, that will be interpreted as time series for the device. |
| devices[].timeseries[].key            | The name for time series on the platform.                                                                       |
| devices[].timeseries[].objectType     | The object type in the BACnet device.                                                                           |
| devices[].timeseries[].objectId       | The object id in the BACnet device.                                                                             |
| devices[].timeseries[].propertyId     | The property id in the BACnet device.                                                                           |
| devices[].timeseries[].reportStrategy | Report strategy object using for configuring report strategy for device time series.                            |
| ---                                   |                                                                                                                 |

设备属性和时序数据配置示例：

```json
{
  "attributes": [
    {
      "key": "location",
      "objectType": "analogValue",
      "objectId": 1,
      "propertyId": "presentValue"
    }
  ],
  "timeseries": [
    {
      "key": "temperature",
      "objectType": "analogInput",
      "objectId": 2,
      "propertyId": "presentValue"
    }
  ]
}
```

#### 设备属性更新

| **Parameter**                                | **Default value** | **Description**                                           |
|:---------------------------------------------|-------------------|-----------------------------------------------------------|
| devices[].attributeUpdates[]                 |                   | List of attributes that will be updated on the device.    |
| devices[].attributeUpdates[].key             |                   | The name of the shared attribute on platform instance.    |
| devices[].attributeUpdates[].objectType      |                   | The object type in the BACnet device.                     |
| devices[].attributeUpdates[].objectId        |                   | The object id in the BACnet device.                       |
| devices[].attributeUpdates[].propertyId      |                   | The property id in the BACnet device.                     |
| devices[].attributeUpdates[].timeout (in ms) | **5000**          | Timeout in milliseconds for the attribute update request. |
| ---                                          |                   |                                                           |

设备属性更新配置示例：

```json
{
  "attributeUpdates": [
    {
      "key": "setpoint",
      "objectType": "analogValue",
      "objectId": 3,
      "propertyId": "presentValue",
      "timeout": 5000
    }
  ]
}
```

#### 设备 RPC 方法

| **Parameter**                             | **Default value** | **Description**                                                               |
|:------------------------------------------|:------------------|-------------------------------------------------------------------------------|
| devices[].serverSideRpc[]                 |                   | List of RPC methods that will be sent to the device.                          |
| devices[].serverSideRpc[].method          |                   | RPC method name.                                                              |
| devices[].serverSideRpc[].requestType     |                   | “**writeProperty**” to write data and “**readProperty**” to read data.        |
| devices[].serverSideRpc[].objectType      |                   | The object type in the BACnet device.                                         |
| devices[].serverSideRpc[].objectId        |                   | The object id in the BACnet device.                                           |
| devices[].serverSideRpc[].propertyId      |                   | The property id in the BACnet device.                                         |
| devices[].serverSideRpc[].priority        |                   | Priority of the value to write (optional, should be an integer from 1 to 16). |
| devices[].serverSideRpc[].timeout (in ms) | **5000**          | Timeout in milliseconds for the RPC method execution.                         |
| ---                                       |                   |                                                                               |

设备 RPC 方法配置示例：

```json
{
  "serverSideRpc": [
    {
      "method": "set_state",
      "requestType": "writeProperty",
      "objectType": "analogValue",
      "objectId": 3,
      "propertyId": "presentValue",
      "timeout": 5000
    }
  ]
}
```

## 附加信息

### 支持的对象类型

BACnet 连接器支持以下 BACnet 对象类型：

| **BACnet object id** | **ThingsBoard object id** |
|----------------------|---------------------------|
| **Binary input**     | **binaryInput**           |
| **Binary Output**    | **binaryOutput**          |
| **Binary Value**     | **binaryValue**           |
| **Analog Input**     | **analogInput**           |
| **Analog Output**    | **analogOutput**          |
| **Analog Value**     | **analogValue**           |
| **Schedule Object**  | **schedule**              |
| ---                  | ---                       |

### 支持的属性标识符

属性标识符取决于 BACnet 对象类型，以 camelCase 格式提供，例如：
- presentValue
- objectName
- objectDescription
- units
- eventState
- outOfService
- priorityArray
- relinquishDefault
- currentCommandPriority
- eventMessageTexts
- eventMessageTextsConfig
- eventAlgorithmInhibitReference
- timeDelayNormal
- weeklySchedule
- listOfObjectPropertyReferences
- location

## 故障排查

### Linux 下 Docker Compose 设备发现问题

若在 Linux 上通过 Docker Compose 运行网关且出现设备发现问题时，请确认 docker compose 文件中已正确设置网络模式。请在 docker compose 文件的 `tb-gateway` 服务中添加以下行：

```yaml
network_mode: "host"
extra_hosts:
    - "host.docker.internal:host-gateway"
```
{: .copy-code}

### Windows 下 Docker Compose 设备发现问题

受 Windows 上 Docker 网络栈限制，BACnet 连接器不支持 Windows 下的设备发现。请使用源码安装或其他安装方式在 Windows 上运行网关。

## 下一步

探索与 ThingsBoard 主要功能相关的指南：

 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据
