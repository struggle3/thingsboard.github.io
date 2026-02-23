
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceName = "reComputer R1000" %}
{% assign deviceVendorLink = "https://wiki.seeedstudio.com/recomputer_r/" %}

* TOC
{:toc}

## 概述

[reComputer R1000]({{deviceVendorLink}}){: target="_blank"} 边缘 IoT 控制器基于高性能 Raspberry Pi CM4 平台，四核 A72 处理器，最高支持 8 GB RAM 与 32 GB eMMC。配备可灵活配置的双以太网接口及 3 路隔离 RS485，支持 BACnet、Modbus RTU、Modbus TCP/IP。R1000 系列具备丰富 IoT 网络通信能力，支持 4G、LoRa®、Wi-Fi/BLE 等无线方案，可灵活配置为对应无线网关。适用于远程设备管理、能源管理及智能建筑等场景。

## 与 ThingsBoard 集成

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/edge" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include /templates/device-library/ready-to-go-devices/pe-prerequisites-recomuterR.md %}
{% else %}
{% include /templates/device-library/ready-to-go-devices/ce-prerequisites-recomuterR.md %}
{% endif %}

## 配置 ModBus 连接器

新的 **IoT 网关设备** 将显示在 **「ThingsBoard IoT 网关」** 仪表板列表顶部，便于我们添加 **ModBus 连接器**。例如，可使用 ModBus 连接器从 [Siemens LOGO!]({{controllerVendorLink}}){: target="_blank"} 设备获取温度数据：

{% assign modbusConnectorPE = '
    ===
        image: /images/devices-library/edge/recomputer-r1000/5-connectors-button-pe.webp,
        title: 在 **「ThingsBoard IoT 网关」** 仪表板页面，点击 **「连接器」** 按钮。
    ===
        image: /images/devices-library/edge/recomputer-r1000/6-add-connector-pe.webp,
        title: 添加 **连接器**：点击 **「+」** 按钮，在弹出窗口的 **「类型」** 中选择 **MODBUS**，在 **「名称」** 中输入连接器名称，点击 **「添加」**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/7-advanced-config-pe.webp,
        title: 进一步配置：点击新添加的 **连接器**，在 **「MODBUS 配置」** 界面右侧选择 **「高级」** 选项卡下的 **「配置」** 子选项卡。
'
%}

{% assign modbusConnectorCE = '
    ===
        image: /images/devices-library/edge/recomputer-r1000/5-connectors-button.webp,
        title: 在 **「ThingsBoard IoT 网关」** 仪表板页面，点击 **「连接器」** 按钮。
    ===
        image: /images/devices-library/edge/recomputer-r1000/6-add-connector.webp,
        title: 添加 **连接器**：点击 **「+」** 按钮，在弹出窗口的 **「类型」** 中选择 **MODBUS**，在 **「名称」** 中输入连接器名称，点击 **「添加」**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/7-advanced-config.webp,
        title: 进一步配置：点击新添加的 **连接器**，在 **「MODBUS 配置」** 界面右侧选择 **「高级」** 选项卡下的 **「配置」** 子选项卡。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/edge" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=modbusConnectorPE %}
{% else %}  
{% include images-gallery.liquid showListImageTitles="true" imageCollection=modbusConnectorCE %}
{% endif %}

* 请插入以下配置代码，然后点击 **「保存」** 按钮。

```cpp
{
  "master": {
    "slaves": [
      {
        "host": "192.168.1.200",
        "port": 510,
        "type": "tcp",
        "method": "socket",
        "timeout": 35,
        "byteOrder": "BIG",
        "wordOrder": "BIG",
        "retries": true,
        "retryOnEmpty": true,
        "retryOnInvalid": true,
        "pollPeriod": 3000,
        "unitId": 1,
        "deviceName": "LOGO!",
        "deviceType": "siemens",
        "connectAttemptTimeMs": 5000,
        "connectAttemptCount": 5,
        "waitAfterFailedAttemptsMs": 300000,
        "attributes": [],
        "timeseries": [
          {
            "tag": "temp",
            "type": "16int",
            "functionCode": 4,
            "objectsCount": 1,
            "address": 2,
            "divider": 10
          },
          {
            "tag": "Q1",
            "type": "bit",
            "functionCode": 1,
            "objectsCount": 1,
            "address": 8193
          },
          {
            "tag": "Q2",
            "type": "16int",
            "functionCode": 3,
            "objectsCount": 2,
            "address": 507
          }
        ],
        "rpc": [
          {
            "tag": "getTemp",
            "type": "16int",
            "functionCode": 4,
            "objectsCount": 1,
            "address": 2
          }
        ],
        "attributeUpdates": [
          {
            "tag": "randNumber",
            "type": "16int",
            "functionCode": 6,
            "objectsCount": 1,
            "address": 507
          }
        ],
        "reportStrategy": {
          "type": "ON_REPORT_PERIOD",
          "reportPeriod": 3000
        }
      }
    ]
  },
  "slave": {}
}
```
{:.copy-code.expandable-15}

## 在 reComputer R1000 上安装 ThingsBoard IoT 网关

在 **reComputer R1000** 上开始安装 **IoT 网关**：

{% assign downloadYMLPE = '
    ===
        image: /images/devices-library/edge/recomputer-r1000/8-back-to-iot-dasboard-pe.webp,
        title: 返回 **「ThingsBoard IoT 网关」** 仪表板页面，点击新添加的 **网关设备**（reComputer R1000）。
    ===
        image: /images/devices-library/edge/recomputer-r1000/9-download-yml-pe.webp,
        title: 在 **网关设备** 页面，点击 **「启动命令」** 按钮并下载该网关的 **docker-compose.yml**。
'
%}

{% assign downloadYMLCE = '
    ===
        image: /images/devices-library/edge/recomputer-r1000/8-back-to-iot-dasboard.webp,
        title: 返回 **「ThingsBoard IoT 网关」** 仪表板页面，点击新添加的 **网关设备**（reComputer R1000）。
    ===
        image: /images/devices-library/edge/recomputer-r1000/9-download-yml.webp,
        title: 在 **网关设备** 页面，点击 **「启动命令」** 按钮并下载该网关的 **docker-compose.yml**。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/edge" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=downloadYMLPE %}
{% else %}  
{% include images-gallery.liquid showListImageTitles="true" imageCollection=downloadYMLCE %}
{% endif %}

* 在终端中打开新标签页，建立到 **reComputer R1000** 的 **SSH** 连接：

```bash
ssh recomputer@ip_address
```
{: .copy-code}

**ip_address：** reComputer R1000 的 IP 地址，请将 _ip_address_ 替换为实际 IP。<br>
**密码：** 终端会提示输入密码。reComputer R1000 的 **默认密码** 为：12345678

* 创建网关服务目录：

```bash
mkdir gateway_service
```
{: .copy-code}

* 进入该目录：

```bash
cd /home/recomputer/gateway_service
```
{: .copy-code}

* 为 **IoT 网关** 创建 docker compose 文件：

```bash
nano docker-compose.yml
```
{: .copy-code}

* 将之前下载的 **docker-compose.yml** 文件内容复制并粘贴到终端中的新文件中：

![image](/images/devices-library/edge/recomputer-r1000/10-copy-paste-configs.webp)

* 保存 **docker-compose.yml**：按 **CTRL+S** 保存，按 **CTRL+X** 退出编辑器。

* 在终端中执行以下命令启动 **网关**：

```bash
docker compose up -d
docker compose logs -f
```
{: .copy-code}

{% capture local-deployment %}
请在保存 docker-compose.yml 的同一目录下执行该命令。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

## 在仪表板中可视化数据

![image](/images/devices-library/edge/recomputer-r1000/logo-and-recomputer-r1000.webp){: style="float: left; max-width: 300px; max-height: 300px; margin: 0px 30px 0px 0px"}当 **ThingsBoard Edge** 与 **IoT 网关** 在 **reComputer R1000** 上运行且 **ModBus 连接器** 开始传输数据后，可在 **Edge 实例** 的 **仪表板** 上查看可视化：

{% assign dashboardPE = '
    ===
        image: /images/devices-library/edge/recomputer-r1000/11-create-new-dashboard-pe.webp,
        title: 进入 **仪表板** 区域，点击 **「+」** 图标并选择 **「创建新仪表板」**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/12-enter-name-pe.webp,
        title: 在弹出窗口中输入仪表板 **标题**，其他项可选，点击 **「添加」**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/13-configure-dashboard-pe.webp,
        title: 创建后仪表板会自动打开。点击 **「添加部件」**，选择所需部件，例如打开 **「图表」** 部件组并选择 **折线图**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/14-widget-configuration-pe.webp,
        title: 在 **「添加部件」** 弹出窗口中，将 **数据源** 选为 **设备**（本例为 Siemens LOGO!）。请确认 **序列键** 与连接器 **高级配置** 中填写的一致，例如使用 **"temp"** 时，序列键也需为 **"temp"**。点击 **「添加」**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/15-dashboard-pe.webp,
        title: 此时即可在仪表板上查看实时数据。
'
%}

{% assign dashboardCE = '
    ===
        image: /images/devices-library/edge/recomputer-r1000/11-create-new-dashboard.webp,
        title: 进入 **仪表板** 区域，点击 **「+」** 图标并选择 **「创建新仪表板」**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/12-enter-name.webp,
        title: 在弹出窗口中输入仪表板 **标题**，其他项可选，点击 **「添加」**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/13-configure-dashboard.webp,
        title: 创建后仪表板会自动打开。点击 **「添加部件」**，选择所需部件，例如打开 **「图表」** 部件组并选择 **折线图**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/14-widget-configuration.webp,
        title: 在 **「添加部件」** 弹出窗口中，将 **数据源** 选为 **设备**（本例为 Siemens LOGO!）。请确认 **序列键** 与连接器 **高级配置** 中填写的一致，例如使用 **"temp"** 时，序列键也需为 **"temp"**。点击 **「添加」**。
    ===
        image: /images/devices-library/edge/recomputer-r1000/15-dashboard.webp,
        title: 此时即可在仪表板上查看实时数据。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/edge" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=dashboardPE %}
{% else %}  
{% include images-gallery.liquid showListImageTitles="true" imageCollection=dashboardCE %}
{% endif %}
{% include add-device-banner.liquid %}