---
layout: docwithnav-gw
title: IoT Gateway 配置
description: ThingsBoard IoT Gateway 安装结构与配置说明 

---


* TOC
{:toc}


## 目录结构

daemon 安装的默认目录结构如下：

```text
/etc/thingsboard-gateway/config                   - Configuration folder.
    tb_gateway.json                               - Main configuration file for Gateway.
    logs.json                                     - Configuration file for logging.
    modbus.json                                   - Modbus connector configuration.
    mqtt.json                                     - MQTT connector configuration.
    ble.json                                      - BLE connector configuration.
    opcua.json                                    - OPC-UA connector configuration.
    request.json                                  - Request connector configuration.
    can.json                                      - CAN connector configuration. 
    ... 

/var/lib/thingsboard_gateway/extensions           - Folder for custom connectors/converters.                      
    modbus                                        - Folder for Modbus custom connectors/converters.
    mqtt                                          - Folder for MQTT custom connectors/converters.
        __init__.py                               - Default Python package file, needed for correct imports.
        custom_uplink_mqtt_converter.py           - Custom MQTT converter example.
    ...
    opcua                                         - Folder for OPC-UA custom connectors/converters.
    ble                                           - Folder for BLE custom connectors/converters.
    request                                       - Folder for Request custom connectors/converters.
    can                                           - Folder for CAN custom connectors/converters.

/var/log/thingsboard-gateway                      - Logs folder.
    connector.log                                 - Connector logs.
    service.log                                   - Main gateway service logs.
    storage.log                                   - Storage logs.
    tb_connection.log                             - Logs for connection to the ThingsBoard instance.
```

## Environmental variables

{% capture difference %}
**Values of environment variables have a higher priority than values of parameters from the configuration file.
This means that the gateway will use the values of the environment variables (if they are set) 
and not the values from the configuration file.**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

The gateway provides the capability to configure essential connection parameters using environment variables. 
For example, let's illustrate how you can configure basic parameters such as the host, port, and access token by using 
environment variables within a Docker Compose file. Here’s how you can achieve this:

```yaml
version: '3.4'
services:
  # ThingsBoard IoT Gateway Service Configuration
  tb-gateway:
    image: thingsboard/tb-gateway
    container_name: tb-gateway
    ...
    # Environment variables
    environment:
      - TB_GW_HOST=host.docker.internal
      - TB_GW_PORT=1883
      - TB_GW_ACCESS_TOKEN=YOUR_ACCESS_TOKEN
    ...
```

上例中，通过 "**TB_GW_HOST**"、"**TB_GW_PORT**" 和 "**TB_GW_ACCESS_TOKEN**" 环境变量，分别将 "**host.docker.internal**" 设为 host，**1883** 设为 port，"**YOUR_ACCESS_TOKEN**" 设为 access token。

下列环境变量可用于配置 ThingsBoard IoT Gateway：

| **ENV variable**     | **Default value**             | **说明**                                                                   |
|----------------------|-------------------------------|-----------------------------------------------------------------------------------|
| TB_GW_HOST           | **host.docker.internal**      | ThingsBoard 服务器的主机名或 IP 地址。                                     |
| TB_GW_PORT           | **1883**                      | ThingsBoard 服务器上的 MQTT 服务端口。                                       |
| TB_GW_ACCESS_TOKEN   | **YOUR_ACCESS_TOKEN**         | ThingsBoard 中网关的访问令牌。                             |
| TB_GW_CA_CERT        |                               | CA 证书文件路径。                                                      |
| TB_GW_PRIVATE_KEY    |                               | 私钥文件路径。                                                         |
| TB_GW_CERT           |                               | 证书文件路径。                                                         |
| TB_GW_CLIENT_ID      |                               | ThingsBoard 端网关的 MQTT 客户端 ID。                           |
| TB_GW_USERNAME       |                               | ThingsBoard 端网关的 MQTT 用户名。                           |
| TB_GW_PASSWORD       |                               | ThingsBoard 端网关的 MQTT 密码。                           |
| TB_GW_RATE_LIMITS    | **15:1,300:60,**              | 向 ThingsBoard 发送消息的速率限制，格式为 `MESSSAGE_COUNT:TIME,`。       |
| TB_GW_DP_RATE_LIMITS | **15:1,300:60,**              | 向 ThingsBoard 发送数据点的速率限制，格式为 `DATA_POINTS_COUNT:TIME,`。 |
| TB_GW_LOGS_PATH      | **/thingsboard_gateway/logs** | 日志目录路径。                                                          |

## 通用配置文件

主配置文件用于连接 ThingsBoard 平台实例及启用/禁用 connector。 

以下示例将连接位于 thingsboard.cloud 的 ThingsBoard 实例，使用内存存储，最多保存 100,000 条记录。
示例中启用了 4 种 connector。若只需一种，可从配置中移除其余 connector。

<b>主配置文件示例。点击展开。</b>

{% capture genConf %}

{
  "thingsboard": {
    "host": "thingsboard.cloud",
    "port": 1883,
    "remoteShell": false,
    "remoteConfiguration": true,
    "statistics": {
      "enable": true,
      "statsSendPeriodInSeconds": 60
    },
    "deviceFiltering": {
      "enable": false,
      "filterFile": "list.json"
    },
    "maxPayloadSizeBytes": 1024,
    "minPackSendDelayMS": 60,
    "minPackSizeToSend": 500,
    "checkConnectorsConfigurationInSeconds": 10,
    "handleDeviceRenaming": true,
    "security": {
      "type": "accessToken",
      "accessToken": "YOUR_ACCESS_TOKEN"
    },
    "qos": 1,
    "checkingDeviceActivity": {
      "checkDeviceInactivity": false,
      "inactivityTimeoutSeconds": 200,
      "inactivityCheckPeriodSeconds": 500
    }
  },
  "storage": {
    "type": "memory",
    "read_records_count": 100,
    "max_records_count": 10000
  },
  "grpc": {
    "enabled": false,
    "serverPort": 9595,
    "keepaliveTimeMs": 10000,
    "keepaliveTimeoutMs": 5000,
    "keepalivePermitWithoutCalls": true,
    "maxPingsWithoutData": 0,
    "minTimeBetweenPingsMs": 10000,
    "minPingIntervalWithoutDataMs": 5000,
    "keepAliveTimeMs": 10000,
    "keepAliveTimeoutMs": 5000
  },
  "connectors": [
    {
      "type": "mqtt",
      "name": "MQTT Broker Connector",
      "configuration": "mqtt.json"
    },
    {
      "type": "modbus",
      "name": "Modbus Connector",
      "configuration": "modbus.json"
    },
    {
      "type": "modbus",
      "name": "Modbus Serial Connector",
      "configuration": "modbus_serial.json"
    },
    {
      "type": "opcua",
      "name": "OPC-UA Connector",
      "configuration": "opcua.json"
    }
  ]
}

{% endcapture %}
{% include code-toggle.liquid code=genConf params="conf|.copy-code.expandable-20" %}

### 配置文件各区块

+ **thingsboard** -- 连接 ThingsBoard 平台的配置。
  - *security* -- 加密与鉴权类型配置。
+ **storage** -- 设备上报数据的本地存储配置。
+ **connectors** -- connector 数组及其配置。

### 连接 ThingsBoard

|**参数**             | **默认值**                            | **说明**                                                                         |
|---                       |---                                           |-----------------------------------------------------------------------------------------|
| ***thingsboard***        |                                              | 连接服务器的配置。                                                 |
| host                     | **thingsboard.cloud**                        | ThingsBoard 服务器的主机名或 IP 地址。                                           |
| port                     | **1883**                                     | ThingsBoard 服务器上的 MQTT 服务端口。                                             |
| qos                      | **1**                                        | QoS 级别：0（最多一次）和 1（至少一次）。                                      |
| minPackSendDelayMS       | **200**                                      | 发送数据包之间的延迟（降低此值将增加 CPU 占用）。 |
| minPackSizeToSend        | **500**                                      | 发送数据包的最小大小。                                                          |

#### 子区块「statistics」

该子区块用于配置统计数据的采集及上报至 ThingsBoard 网关设备属性。

|**参数**|**默认值**| **说明**                                                                |
|:-|:-|--------------------------------------------------------------------------------
| statistics                   |                 | 启用统计采集的配置。                              |
| ... enable                   | true            | 布尔值，用于开启/关闭统计采集。                  |
| ... statsSendPeriodInSeconds | 3600            | 整数，表示定期发送数据的间隔（秒）。       |
| ... configuration            | statistics.json | 额外用户统计数据配置文件名（单位：秒）。 |
|---

可定义额外参数「configuration」，并提供自定义命令采集附加数据。
配置文件示例如下：
```json
[
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "ps -A -o cpu,%mem | awk '{cpu += $1}END{print cpu}'"],
    "attributeOnGateway": "CPU"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "ps -A -o %cpu,%mem | awk '{mem += $2}END{print mem}'"],
    "attributeOnGateway": "Memory"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "ipconfig getifaddr en0"],
    "attributeOnGateway": "IP address"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "sw_vers -productName"],
    "attributeOnGateway": "OS"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "uptime"],
    "attributeOnGateway": "Uptime"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "system_profiler SPUSBDataType"],
    "attributeOnGateway": "USBs"
  }
]
```
不同操作系统（Linux、macOS、Windows）的示例文件可参见 `/config/statistics/` 目录。

#### 子区块「deviceFiltering」

该子区块为可选，用于过滤允许向 ThingsBoard 发送数据的设备。

设备过滤功能可按指定条件定义过滤规则。

| **参数**                    | **默认值** | **说明**                                       |
|:---------------------------------|:------------------|------------------------------------------------------- 
| deviceFiltering                  |                   | 设备过滤配置。                    |
| ... enable                       | **false**         | 布尔值，用于开启/关闭设备过滤。 |
| ... filterFile                   | **list.json**     | 配置文件名。                          |
| ---                              

配置文件示例如下：
```json
{
  "deny": {
    "MQTT Broker Connector": [
      "Temperature Device",
      "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)"
    ],
    "Modbus Connector": [
      "My Modbus Device"
    ]
  },
  "allow": {
    "MQTT Broker Connector": [
      "My Temperature Sensor"
    ]
  }
}
```
上述配置包含两个主要属性：「deny」和「allow」。每个属性的键为 connector 类型，值为设备名称数组。

「deny」用于指定哪些设备被禁止访问指定的 connector。列在各 connector 名称下的设备将被阻止访问该 connector。

The structure of the "deny" property is as follows:
```json
"deny": {
  "<Connector Name>": [
    "<Device Name 1>",
    "<Device Name 2>",
    ...
  ],
  ...
}
```
Example:
```json
"deny": {
  "MQTT Broker Connector": [
    "Temperature Device",
    "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)"
  ],
  "Modbus Connector": [
    "My Modbus Device"
  ]
}
```

上例中定义的规则为：
* 设备「Temperature Device」及任何符合邮箱格式的设备均被禁止访问「MQTT Broker Connector」。
* 设备「My Modbus Device」被禁止访问「Modbus Connector」。

「allow」用于指定明确允许访问特定 connector 的设备。列在各 connector 下的设备将拥有该 connector 的完全访问权限。

The structure of the "allow" property is as follows:
```json
"allow": {
  "<Connector Name>": [
    "<Device Name 1>",
    "<Device Name 2>",
    ...
  ],
  ...
}
```

Example:
```json
"allow": {
  "MQTT Broker Connector": [
    "My Temperature Sensor"
  ]
}
```

上例中定义的规则为：
* 设备「My Temperature Sensor」被允许访问「MQTT Broker Connector」。

设备过滤功能通过设备名称灵活定义允许或禁止访问 connector 的规则。使用「deny」和「allow」可方便控制网关内设备的访问权限。


#### Subsection “checkingDeviceActivity”

该子区块为可选，用于监控每个已连接设备的活跃度。

定义该区块后，网关将按间隔秒数检查各设备活跃度；若设备在指定秒数内无活动，网关将断开该设备。

|**参数**|**默认值**|**说明**|
|:-|:-|- 
| checkingDeviceActivity           |              | 设备活跃度检查配置。                   |
| ... checkDeviceInactivity        | **false**    | 布尔值，用于开启/关闭设备活跃度检查。 |
| ... inactivityTimeoutSeconds     | **120**      | 设备无活动时长，超过后网关将断开。 |
| ... inactivityCheckPeriodSeconds | **10**       | 设备活跃度检查周期（秒）。                          |
|---

#### 子区块「security」

{% capture securitytogglespec %}
Access Token<small>Basic security</small>%,%accessToken%,%templates/iot-gateway/security-accesstoken-config.md%br%
Username and password<small>Basic security</small>%,%usernamepassword%,%templates/iot-gateway/security-usernamepassword-config.md%br%
TLS + Access Token<small>Advanced security</small>%,%tlsToken%,%templates/iot-gateway/security-tls-token-config.md%br%
TLS + Private Key<small>Advanced security</small>%,%tls%,%templates/iot-gateway/security-tls-config.md{% endcapture %}

security 子区块共 3 种配置方式：

{% include content-toggle.liquid content-toggle-id="securityConfig" toggle-spec=securitytogglespec %}

#### 子区块「provisioning」

{% capture provisioningtogglespec %}
Auto<small>Server generated access token</small>%,%auto%,%templates/iot-gateway/provisioning-auto-config.md%br%
Access Token<small>Predefined access token</small>%,%accesstoken%,%templates/iot-gateway/provisioning-access-token-config.md%br%
Basic MQTT<small>Basic MQTT Credentials</small>%,%basicmqtt%,%templates/iot-gateway/provisioning-basic-mqtt-config.md%br%
X.509 Certificate<small></small>%,%x509%,%templates/iot-gateway/provisioning-x-509-config.md%br%{% endcapture %}

供应配置共有 4 种选项（更多供应说明见[官方文档](/docs/user-guide/device-provisioning/)）：
{% include content-toggle.liquid content-toggle-id="provisioningConfig" toggle-spec=provisioningtogglespec %}

### 存储配置

storage 子区块用于配置在将数据发送至 ThingsBoard 平台前的本地保存方式。

该区块共有 3 种类型：memory、file、SQLite。
1. **Memory** 存储 - 将接收的数据保存到内存。
2. **File** 存储 - 将接收的数据保存到硬盘。
3. **SQLite** 存储 - 将接收的数据保存到 .db 文件。

{% capture storagetogglespec %}
Memory storage<br> <small>(use for development or low-volume data when disk space is limited)</small>%,%memory%,%templates/iot-gateway/storage-memory-config.md%br%
SQLite storage<br> <small>(high-performance on-disk persistence — recommended for most production setups)</small>%,%sqlite%,%templates/iot-gateway/sqlite-storage-config.md%br%
File storage<br> <small>(simple on-disk persistence — good for small/medium workloads) (Legacy)</small>%,%file%,%templates/iot-gateway/storage-file-config.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="storageConfig" toggle-spec=storagetogglespec %}

### Connectors 配置

connectors 区块用于配置通过已实现协议连接设备的 connector。
每个 connector 的配置需包含下表所列参数：  
 
|**参数**|**默认值**|**说明**|
|:-|:-|- 
| useGRPC                  | **true**                                     | **可选**，用于开启/关闭默认 connector 的 GRPC 传输 |
| name                     | **MQTT Broker Connector**                    | connector 名称。                                                                   |
| type                     | **mqtt**                                     | connector 类型，需与配置文件所在目录名一致。                |
| configuration            | **mqtt.json**                                | config 目录下配置文件名。*                                         |
|---

\* -- 配置文件所在目录。  

配置文件中的 connectors 区块可不同于下述示例，但结构应保持一致：  

```json
...
"connectors": [
  {
    "type": "mqtt",
    "name": "MQTT Broker Connector",
    "configuration": "mqtt.json"
  },
  {
    "type": "modbus",
    "name": "Modbus Connector",
    "configuration": "modbus.json"
  },
  {
    "type": "modbus",
    "name": "Modbus Serial Connector",
    "configuration": "modbus_serial.json"
  },
  {
    "type": "opcua",
    "name": "OPC-UA Connector",
    "configuration": "opcua.json"
  }
]
...
```

**注意：** 可同时使用多个同类型 connector，但需为各自指定不同的名称和配置文件。

如需其他类型的 connector，可参考[自定义指南](/docs/iot-gateway/custom/)自行实现，或发送邮件至：<info@thingsboard.io>。
