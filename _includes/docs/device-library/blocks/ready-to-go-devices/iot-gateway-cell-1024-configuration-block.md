{% assign gatewayConfiguration = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/conn1.png,  
        title: 使用 URL https://[IP_DEVICE] 在浏览器中打开 Cell 1024 的管理界面，进入「<b>Cloud</b>」选项卡。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/conn2.png,
        title: 启用 Cloud 控制，并配置所有参数以通过 MQTT 将设备连接到指定的 ThingsBoard 平台。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/conn3.png,
        title: 点击「<b>保存配置</b>」按钮。
'
%}  

{% include images-gallery.liquid showListImageTitles="true" imageCollection=gatewayConfiguration %}

| 配置参数 | 说明 |
|-|-|
|**Cloud Platform（云平台）**| 选择 ThingsBoard。 |
|**MQTT broker URL（MQTT 代理 URL）**| 要集成的服务器 Broker 的 URL。 |
|**MQTT broker port（MQTT 代理端口）**| 服务器使用的端口号。 |
|**TLS**| 若服务器使用传输层安全协议，请选择 true。 |
|**Connection Type（连接类型）**| 选择「Access Token」选项。将使用在 ThingsBoard 中先前创建的访问令牌。 |
|**Access Token（访问令牌）**| 填入先前在 ThingsBoard 中复制的访问令牌。 |

{% capture provisioningIsComing %}
**注意**

目前，EXXN IoT 网关使用「Access Token」集成方式。  
EXXN 团队正在开发 Pre-Provisioning 集成方式，届时将无需在设备上复制此访问令牌。

{% endcapture %}
{% include templates/info-banner.md content=provisioningIsComing %}

要验证设备是否正确连接到 ThingsBoard，请进入 **设备组** 菜单 -> **全部** 设备，选择您的设备。  
在 **设备详情** 中选择 **客户端属性** 选项卡，检查客户端属性是否已下发到设备。

{% assign checkConnection = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-client-attributes-device-1.png,
        title: 若配置正确，我们将看到如 <i>serial_number</i>、<i>last_reboot</i>、<i>device_model</i> 等客户端属性。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=checkConnection %}

EXXN IoT 网关将使用 MQTT API 连接到 ThingsBoard。  
前面已介绍如何配置设备以连接 ThingsBoard。  
下面介绍在 ThingsBoard 中配置设备以监控数据和管理设备的步骤。

要为 EXXN IoT 网关配置数据记录器选项，需要为设备创建键为「**config**」的新 JSON「**共享属性**」。

使用以下 JSON：

```json
{
  "control_config": {
    "debug_level": 10
  },
  "datalogger_config": {
    "csv_path": "/opt/celling/datalogger/data/",
    "redis_list_max_len": 16384,
    "sensor_list": [
      {
        "id": "system_monitor",
        "description": "CPU usage (%), disk free (MB), memory available (MB)",
        "model": "sys_mon",
        "storage_device": "/dev/mmcblk0p2",
        "measures": [
          "disk_free",
          "mem_available",
          "cpu_usage"
        ],
        "enabled": true,
        "period": 60,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "temp_sc0",
        "description": "Temperature of the small cell #0",
        "model": "ds18b20",
        "name": "sc0",
        "address": "28-01212e9c95be",
        "measures": [
          "temperature"
        ],
        "enabled": true,
        "period": 15,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "temp_sc1",
        "description": "Temperature of the small cell #1",
        "model": "ds18b20",
        "name": "sc1",
        "address": "28-01212e96afff",
        "measures": [
          "temperature"
        ],
        "enabled": false,
        "period": 15,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "fan_rpm",
        "description": "Fan tachometer monitor",
        "model": "tachometer",
        "name": "fan",
        "gpio": 22,
        "sampling_window": 5000,
        "measures": [
          "rpm"
        ],
        "enabled": true,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "temp_hum",
        "description": "Temperature (celsius degrees), humidity (%)",
        "model": "cwt_th01s",
        "name": "th",
        "config_params": {
          "port": "/dev/ttyS1",
          "baudrate": 9600,
          "read_timeout": 0.5,
          "slave_id": 2
        },
        "measures": [
          "temperature",
          "humidity"
        ],
        "enabled": true,
        "period": 15,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "gpio_monitor",
        "description": "GPIOs configuration and monitoring",
        "model": "gpio_mon",
        "name": "gpio",
        "measures": [
          "state"
        ],
        "mapping": {
          "LOCK": {
            "pin": 1,
            "gpio": 4,
            "direction": "out",
            "boot_value": 0
          },
          "LED": {
            "pin": 3,
            "gpio": 2,
            "direction": "out",
            "boot_value": 0
          },
          "FAN": {
            "pin": 5,
            "gpio": 34,
            "direction": "out",
            "boot_value": 0
          },
          "BUZZER": {
            "pin": 1,
            "gpio": 43,
            "direction": "out",
            "boot_value": 0
          }
        },
        "enabled": true,
        "period": 15,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "energy_meter",
        "description": "Voltage (V), Current (A), Active Power (KWh), Power Factor",
        "model": "ddm18sd",
        "config_params": {
          "port": "/dev/ttyS1",
          "baudrate": 9600,
          "read_timeout": 1,
          "slave_id": 0
        },
        "measures": [
          "voltage",
          "current",
          "active_power",
          "power_factor"
        ],
        "enabled": true,
        "period": 15,
        "csv": true,
        "mqtt": true
      }
    ]
  }
}
```
{: .copy-code}

通过此 JSON 文件正确配置设备的所有信息，请参见 EXXN IoT 网关手册。

{% assign configureTheGateway = "
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-shared-attributes-device-1.png,
        title: 进入设备详情中的 <b>属性</b> 选项卡。添加键为「<b>config</b>」、类型为 <b>JSON</b> 的新「<b>共享属性</b>」。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/ennx-config-json.png,
        title: 将属性内容展开至全屏以便编写。将设备配置文件内容粘贴到属性值中。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-shared-attributes-device-2.png,
        title: 点击「<b>添加</b>」属性。
"
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=configureTheGateway %}
