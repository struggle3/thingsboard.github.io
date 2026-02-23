* TOC
{:toc}

> 在继续前，建议您先阅读[快速入门指南](/docs/{{docsPrefix}}getting-started-guides/helloworld/){:target="_blank"}以了解ThingsBoard基础。此外，建议查阅[设备配置](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}文档。

## Sparkplug基础

[Sparkplug](https://sparkplug.eclipse.org/)是一种开源软件规范，为MQTT客户端提供框架，使其能够在MQTT基础设施内无缝集成来自应用、传感器、设备和网关的数据，目前已实现至Sparkplug 3.0版本。

### Sparkplug B Edge Node

ThingsBoard充当MQTT服务器，支持SparkPlug负载和主题结构，并允许来自MQTT网络边缘（EoN）节点的连接。

EoN节点是符合v3.1.1或v5.0规范的MQTT客户端应用，负责管理MQTT会话并提供参与本文档所述主题命名空间和负载定义所需的物理和/或逻辑网关功能。Edge Node负责与现有设备（PLC、RTU、流量计算机、传感器等）的本地协议接口、本地离散I/O、以及逻辑内部过程变量（PV）。

该协议[规范](https://sparkplug.eclipse.org/specification/version/2.2/documents/sparkplug-specification-2.2.pdf)定义了EoN节点与MQTT服务器通信的MQTT主题和消息结构。

### Sparkplug B Device

单个EoN节点可代表多个物理设备和传感器，并为每个设备上传设备指标。
ThingsBoard从Sparkplug负载解码设备指标，并将其存储为相应设备的[属性](/docs/{{docsPrefix}}user-guide/attributes/)或[时序](/docs/{{docsPrefix}}user-guide/telemetry/)数据。
您也可通过[共享属性更新](#update-metrics-from-shared-attributes-to-mqtt-eondevice)或[RPC命令](#update-metrics--using-the-thingsboard-rpc-command-from-server-to-mqtt-eondevice)向Sparkplug设备发出更新。

{% capture difference %}
**注意：**
<br>
ThingsBoard仅支持**Sparkplug™ B**负载。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### Sparkplug B主题与消息类型

Sparkplug B负载与Sparkplug主题命名空间结合，形成分层数据结构，可用带指标（通常称为标签）的文件夹结构表示。

```shell
spBv1.0/Sparkplug Group 1/NBIRTH /Sparkplug Node 1/Sparkplug Device 1
````

#### ThingsBoard中的Sparkplug B消息类型

| Type      | Description                                            |
|:----------|:-------------------------------------------------------|
| NBIRTH    | MQTT网络边缘（EoN）节点出生证书 |
| NDEATH    | MQTT网络边缘（EoN）节点死亡证书 |
| DBIRTH    | MQTT设备出生证书                     |
| DDEATH    | MQTT设备死亡证书                     |
| NDATA     | 网络边缘（EoN）节点数据消息                |
| DDATA     | 设备数据消息                                    |
| NCMD      | 网络边缘（EoN）节点命令消息             |
| DCMD      | 设备命令消息                                 |
| STATE     | 设备在线/离线状态（活动）                |
| DRECORD   | 设备记录消息                                  |
| NRECORD   | 网络边缘（EoN）节点记录消息              |


Group ID、edge_node_id、device_id的格式必须为有效UTF-8字符串，但不允许保留字符+（加号）、/（正斜杠）、#（井号）。
BIRTH的MQTT QoS必须为0。 -dcmd-subscribe MUST subscribe on this topic with a QoS of 1, The MQTT Will Message’s MQTT QoS MUST be 1 (at least once)
可为Sparkplug客户端定义ACL，将每个Edge Node限制在其可发布和订阅的特定主题集中。（Edge Node发布NBIRTH，设备发布DBIRTH）。

- 含消息类型的主题示例

```shell
    $sparkplug/certificates:  spBv1.0/group_id/NBIRTH/edge_node_id
    Subscribe:  spBv1.0/group_id/NBIRTH/edge_node_id/#
    $sparkplug/certificates: spBv1.0/group_id/DBIRTH/edge_node_id/device_id
    Subscribe: spBv1.0/group_id/DBIRTH/edge_node_id/device_id/#
    $sparkplug/state: spBv1.0/STATE/sparkplug_host_id 

````

- 验证主题数据订阅

```shell
    Subscribe: spBv1.0/G1/DDATA/E1
    Subscribe: spBv1.0/G1/DDATA/E1/#
    Subscribe: spBv1.0/G1/DDATA/E1/+
    Subscribe: spBv1.0/G1/DDATA/E1/D1
    Subscribe: spBv1.0/G1/DDATA/E1/D1/#
    Subscribe: spBv1.0/G1/DDATA/E1/D1/+
````

### Edge Node的持久与非持久连接
#### 持久连接

- 始终保持连接
- 正常运行时从不发送MQTT DISCONNECT
- 允许主机应用在保活期内通过BIRTH/DEATH消息跟踪实时状态

#### 非持久连接（如GPS追踪器或周期性传感器更新）

- 临时连接并定期发送数据
- 离线前应发送MQTT DISCONNECT以实现优雅断开
- 不发送DEATH消息——主机应用仅能看到带时间戳的最后已知良好数据，而非实时状态

#### 非持久设备建议：

- 重新连接后，在再次断开前发送DEATH证书
- 有助于主机应用维持准确的状态跟踪

#### MQTT协议要求：

MQTT 3.1.1 → Clean Session = true
MQTT 5.0 → Clean Start = true 且 Session Expiry Interval = 0

#### Sparkplug B负载中的别名用法

- **Alias**为可选的无符号64位整数，用于标识指标，有助于减小负载大小。
- 若**未使用别名**，则**必须在**每条消息中**包含指标名称**。
- **别名为可选**，但使用时须遵循以下规则：

##### 使用别名的规则

- **[tck-id-payloads-alias-uniqueness]**  
  若在**NBIRTH**或**DBIRTH**中提供了别名，则该别名**必须**在Edge Node的所有指标中**唯一**。  
  ▪ *同一节点的任意两个指标不得共享相同别名。*

- 在NBIRTH/DBIRTH中定义后，**后续消息**（NDATA、DDATA等）可**仅使用别名**替代完整指标名称。

- **[tck-id-payloads-alias-birth-requirement]**  
  **NBIRTH和DBIRTH**消息**必须同时包含**指标名称**及其**别名。

- **[tck-id-payloads-alias-data-cmd-requirement]**  
  **NDATA、DDATA、NCMD和DCMD**消息**必须仅包含别名**，**必须省略**指标名称。

## 入门

本指南将介绍如何：将Sparkplug EoN节点连接到ThingsBoard、收集设备指标并存储为ThingsBoard时序数据、以及将命令推送回设备。

### 步骤1. 创建设备配置

首先需为Sparkplug设备创建MQTT[设备配置](/docs/{{docsPrefix}}user-guide/device-profiles/)：

1. 进入*配置 -> 设备配置*页面，点击设备配置表头的"+"图标以打开*添加设备配置*对话框；
2. 将配置名称设为*MQTT EoN Node*或任意有意义的值；
3. 进入*传输配置*选项卡并选择*MQTT*传输类型；
4. 确保已勾选"MQTT Sparkplug B Edge of Network (EoN) node"复选框；
5. 输入您希望存储为属性而非时序数据的Sparkplug指标名称。
   该列表还应包含您可能希望从服务端更新并推送到设备的指标。
   支持简单星号后缀作为通配符，例如："Node Control/\*"、"Device Control/\*"、"Properties/\*"。

{% include images-gallery.html imageCollection="sparkplug-create-device-profile" %}

### 步骤2. 配置EoN节点凭证

1. 进入*实体 -> 设备*页面，点击设备表头的"+"图标以打开*添加新设备*对话框；
2. 输入EoN节点设备名称（如*Node 1*）并选择现有设备配置：*MQTT EoN Node*。
3. 创建设备并进入设备详情。复制访问令牌，我们将在下一步使用。注意您也可使用其他类型的[凭证](/docs/{{docsPrefix}}user-guide/device-credentials/)。

{% include images-gallery.html imageCollection="sparkplug-create-device" %}

### 步骤3. 启动EoN节点模拟器

我们已为测试准备了sparkplug节点[模拟器](https://github.com/thingsboard/sparkplug-emulator)。
启动模拟器并连接到我们的平台实例，使用上一步的访问令牌凭证：

```bash
docker run -e SPARKPLUG_SERVER_URL='tcp://{{apiHostName}}:1883' -e SPARKPLUG_CLIENT_MQTT_USERNAME='YOUR_THINGSBOARD_DEVICE_TOKEN' thingsboard/tb-sparkplug-emulator:latest
```
{: .copy-code}

请勿忘记将<code>YOUR_THINGSBOARD_DEVICE_TOKEN</code>替换为实际的令牌值。
也请将<code>{{apiHostName}}</code>替换为您的服务器主机名。

{% capture difference %}
**请注意**
<br>
在docker容器内不可将<code>localhost</code>用作<code>SPARKPLUG_SERVER_URL</code>。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% if docsPrefix == null %}
![image](/images/reference/sparkplug/sparkplug-emulator-ce.png)
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix contains "paas/" %}
![image](/images/reference/sparkplug/sparkplug-emulator-pe.png)
{% endif %}

模拟器成功启动后，您应看到以下消息：

```shell
2023-05-04 13:40:42,787 [pool-2-thread-1] INFO  o.t.sparkplug.SparkplugEmulation - Publishing [Sparkplug Node 1] NBIRTH
2023-05-04 13:40:42,815 [pool-2-thread-1] INFO  o.t.sparkplug.SparkplugEmulation - Publishing [Sparkplug Device 1] DBIRTH
2023-05-04 13:40:42,816 [pool-2-thread-1] INFO  o.t.sparkplug.SparkplugEmulation - Publishing [Sparkplug Device 2] DBIRTH
```

### 步骤4. 以属性和遥测形式查看设备指标

进入EoN节点设备（如*Node 1*）的详情并打开*最新遥测*选项卡。您应看到设备指标，例如*Current Grid Voltage*。
进入*属性*选项卡并选择*共享属性*范围。您将看到在[步骤1](#step-1-create-device-profile)（第5项）中先前配置的指标。

{% include images-gallery.html imageCollection="sparkplug-create-device-telemetry-and-attributes" %}

刷新*设备*页面，可见模拟器创建了两个新的Sparkplug设备："Sparkplug Device 1"和"Sparkplug Device 2"。
两个设备各有其由模拟器生成的属性和遥测值。

此外，为这两个新设备创建了单独的设备配置，名称由您的Sparkplug节点名称+"device"组成。

{% include images-gallery.html imageCollection="sparkplug-create-two-devices" %}

### 步骤5. 将ThingsBoard服务端的Sparkplug指标更新推送到MQTT EoN和设备

您可通过共享属性更新或RPC命令从ThingsBoard向Sparkplug节点/设备指标推送更新。 

#### 使用共享属性更新指标

ThingsBoard[共享属性](/docs/{{docsPrefix}}user-guide/attributes/#shared-attributes)用于向设备传递指标值更新。
您可通过多种方式修改共享属性——管理界面、部件、REST API或规则引擎节点。

<br>
我们手动修改属性"*Outputs/LEDs/Green*"和"*Device Control/Scan Rate*"的值。

要修改属性"Outputs/LEDs/Green"的值，需先在*MQTT EoN Node*设备配置中添加该指标，将其存储为共享属性而非遥测。
在*传输配置*选项卡中，添加新的Sparkplug指标名称——*"Outputs/\*"*。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-1" %}

返回*设备*页面并选择*Sparkplug Device 1*。
在*共享属性*选项卡中，您将看到两个新属性："*Outputs/LEDs/Green*"值为"*true*"，"*Outputs/LEDs/Yellow*"值为"*false*"。
这些为存储为属性的指标，我们可修改并将其值发送至设备。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-2" %}

点击"铅笔"图标，取消勾选对应复选框，将属性"*Outputs/LEDs/Green*"的值从"true"改为"false"。然后点击更新。名为"*Outputs/LEDs/Green*"、值为"*false*"的属性将从服务器发送至设备"*Sparkplug Device 1*"。

在运行模拟器的*终端*中，您应看到以下消息：

```shell
2023-05-04 14:09:00,417 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Message Arrived on topic spBv1.0/Sparkplug Group 1/DCMD/Sparkplug Node 1/Sparkplug Device 1
2023-05-04 14:09:00,417 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Command: [DCMD]  nodeDeviceId: [Sparkplug Device 1]
2023-05-04 14:09:00,417 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Metric [Outputs/LEDs/Green] value [false]
```

如您所见，属性"*Outputs/LEDs/Green*"的新值已成功发送至设备。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-3" %}

现在修改"*Device Control/Scan Rate*"属性的值。点击"铅笔"图标，将值从"*60000*"改为"*30000*"。点击更新。

当"*Device Control/Scan Rate*"属性的新值发送至"*Sparkplug Device 1*"设备时，您将在*终端*中看到以下消息：

```shell
2023-05-04 14:16:51,715 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Message Arrived on topic spBv1.0/Sparkplug Group 1/DCMD/Sparkplug Node 1/Sparkplug Device 1
2023-05-04 14:16:51,715 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Command: [DCMD]  nodeDeviceId: [Sparkplug Device 1]
2023-05-04 14:16:51,715 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Metric [Device Control/Scan Rate] value [30000]
```

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-4" %}

属性"*Outputs/LEDs/Green*"和"*Device Control/Scan Rate*"的值已更改并发送至"*Sparkplug Device 1*"设备。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-5" %}

- 可通过共享属性和RPC终端（Json）发送**CMD**、**DATA**、**DCMD**、**DDATA**命令：

```json
{"NCMD":{"MyFloat":123.345}}
 ```
{: .copy-code}

```json
{"NDATA":{"MyFloat":123.345}}
 ```
{: .copy-code}


```json
{"DCMD":{"MyFloat":123.345}}
 ```
{: .copy-code}

```json
{"DDATA":{"MyFloat":123.345}}
 ```
{: .copy-code}

- 若从共享属性（ts/kv）发送：

```shell
{"MyFloat":123.345}      // 若来自Edge Node，默认将添加"NCMD"
{"MyFloat":123.345}      // 若来自设备，默认将添加"DCMD"
```

#### 使用ThingsBoard RPC命令从服务器向MQTT EoN/设备更新指标

ThingsBoard支持通过RPC（远程过程调用）功能按需更新Sparkplug EoN节点或设备的指标。为简化起见我们也使用"command"替代RPC。
您可通过REST API、部件、规则引擎或自定义脚本发送命令。
命令结构文档见[此处](/docs/{{docsPrefix}}user-guide/rpc/#server-side-rpc)。

命令的关键属性为*method*和*params*。
*method*定义Sparkplug操作，为以下之一：

 * NCMD - 发给EoN节点的命令；
 * DCMD - 发给EoN设备的命令；

*params*为定义指标和值的JSON。

例如，要重启Sparkplug EoN*节点*，应发送以下命令：

  ```json
  {
    "method": "NCMD",
    "params": {"metricName": "Node Control/Reboot", "value": true}
  }
  ```
  {: .copy-code}

要重启Sparkplug EoN*设备*，应发送以下命令： 

  ```json
  {
    "method": "DCMD",
    "params": {"metricName": "Device Control/Reboot", "value": true}
  }
  ```
  {: .copy-code}

本示例中使用"*RPC按钮*"部件重启*Sparkplug EoN节点*。参见下方分步指南与截图。

进入*仪表板*页面并创建名为*Sparkplug*的新仪表板。打开仪表板，点击*实体别名*图标添加新别名。
命名别名（例如*EoN Node*），选择筛选类型"*单个实体*"，类型"*设备*"并选择*Node 1*。点击添加然后保存。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-the-thingsboard-rpc-command-1" %}

现在创建新部件。点击"添加新部件"，从下拉菜单选择*控制部件*包并选择*RPC按钮*部件。在*数据*字段选择已创建的别名（EoN Node）。
进入*高级*选项卡并输入*按钮标签* - REBOOT NODE。在*RPC设置*中输入*RPC方法* - "NCMD"（发给EoN节点的命令）和*RPC方法参数* - "*{"metricName": "Node Control/Reboot", "value": true}*"。点击添加并保存更改。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-the-thingsboard-rpc-command-2" %}

现在点击部件上的"*REBOOT NODE*"按钮。名称为"Node Control/Reboot"、值为"true"的RPC命令将从服务器发送至节点"*Sparkplug Node 1*"。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-the-thingsboard-rpc-command-3" %}

在运行模拟器的*终端*中，您应看到以下消息：

```shell
2023-05-04 14:27:02,215 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Message Arrived on topic spBv1.0/Sparkplug Group 1/NCMD/Sparkplug Node 1
2023-05-04 14:27:02,215 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Command: [NCMD]  nodeDeviceId: [Sparkplug Node 1]
2023-05-04 14:27:02,215 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Metric [Node Control/Reboot] value [true]
```

*Sparkplug EoN Node 1*已重启。

## Next steps

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
