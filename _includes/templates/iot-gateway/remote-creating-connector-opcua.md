下面我们添加 **OPC-UA connector**，它将从演示服务器读取部分数据到已创建的网关。

### 配置演示服务器

我们将使用 docker 镜像作为演示仿真服务器，可通过以下命令安装并运行：

```shell
docker run -it -p 4840:4840 thingsboard/tb-gw-opcua-server:latest
```
{:.copy-code}

运行 docker 镜像后，终端会显示以下日志：

![](/images/gateway/dashboard/run-demo-opcua-server.png)

### 配置 connector

此 OPC-UA connector 配置在 **"opc.tcp://host.docker.internal:4840/freeopcua/server/"** 连接到名为 **"OPC-UA Demo Server"** 的服务器。
配置指定了 timeout、scan period、security 机制（如 anonymous 身份的 **"Basic128Rsa15"**）等。

mapping 部分定义 OPC-UA 节点如何映射到设备及其 attribute 和 time series。本例中将名为 **"Demo Device"**、类型为 **"default"** 的设备映射到 **"`Root\.Objects\.MyObject`"** 下的节点。
**frequency** 和 **power** 等 attribute，以及 **temperature** 和 **humidity** 等 time series，映射到 OPC-UA 服务器中的特定 path。
此外，配置支持 RPC 方法和 attribute update。

创建 connector 请按以下步骤操作：

{% assign addNewConnector = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-7-ce.png,
        title: 在右侧面板点击"**Connectors configuration**"按钮；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-8-ce.png,
        title: 点击"**+ Add connector**"按钮；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-9-ce.png,
        title: 在下拉中选择"**OPCUA**"connector 类型，填写"**Name**"，将"**Logging level**"设为"**INFO**"，关闭"**Fill configuration with default values**"并点击"**Add**"；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-10-ce.png,
        title: Connector 已创建。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addNewConnector %} 

首先配置到演示 OPC-UA 服务器的连接。从"**Server**"标签页开始。
该部分提供 server endpoint url、security、scan period、poll period、subscriptions 等详细连接配置选项。

- 进入"**Server**"标签页，按下列值填写字段：

| **字段名**      | **值**                                             |
|:--------------------|:------------------------------------------------------|
| Server endpoint url | opc.tcp://host.docker.internal:4840/freeopcua/server/ |
| Enable subscription | false                                                 |
| Security            | Anonymous                                             |
| Poll period         | 5000                                                  |
| Security policy     | Basic128RSA15                                         |
| ---                 |                                                       |

{% assign serverConfiguration = '
    ===
        image: /images/gateway/dashboard/server-configuration-1-ce.png,
        title: 进入"**Server**"标签页，按文档填写字段值。
'
%}

{% include images-gallery.liquid imageCollection=serverConfiguration %}

接下来进入"**Data mapping**"部分。该部分包含网关连接 OPC-UA 服务器后将订阅的节点列表，以及处理这些节点数据的配置。

按以下步骤添加新节点：

- 进入"**Data mapping**"标签页，点击"**Add mapping**"。
- 在打开窗口中，将"**Device node**"类型设为"**Path**"，值设为"`Root\.Objects\.MyObject`"；
- 对于"**Device**"子节使用以下选项/值：
    - "**Name**"行：在"**Source**"下拉中选择"**Constant**"，在"**Value / Expression**"中填写"**Device Demo**"；
    - "**Profile name**"行：在"**Source**"下拉中选择"**Constant**"，在"**Value / Expression**"中填写"**default**"。

{% assign dataMappingConfiguration1 = '
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-1-ce.png,
        title: 进入"**Data mapping**"标签页，点击"**Add mapping**"；
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-2-ce.png,
        title: 按文档填写字段值。
'
%}

{% include images-gallery.liquid imageCollection=dataMappingConfiguration1 %}

进入"**Attributes**"部分添加 "frequency" 和 "power" attribute。本部分配置用于处理 OPC-UA 服务器数据，在 ThingsBoard 中将被解释为设备 attribute。我们使用 path 查找对应节点。

{% capture difference %}
**Path** 类型指 OPC-UA 服务器命名空间中的层级地址，用于定位服务器中的特定节点。attribute/time series 的 path 可为绝对或相对（本例为相对）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

按以下步骤配置 attribute 部分：

- 点击"**Attributes**"部分的"**铅笔**"图标；
- 在打开窗口中点击"**Add attribute**"；
- 在"**Key**"中填写"**frequency**"，将"**Type**"选为"**Path**"，在"**Value**"中填写"**${Frequency}**"。

{% assign dataMappingConfiguration2 = '
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-3-ce.png,
        title: 点击"**Attributes**"部分的"**铅笔**"图标；
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-4-ce.png,
        title: 在打开窗口中点击"**Add attribute**"；
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-5-ce.png,
        title: 在"**Key**"中填写"**frequency**"，将"**Type**"选为"**Path**"，在"**Value**"中填写"**${Frequency}**"。
'
%}

{% include images-gallery.liquid imageCollection=dataMappingConfiguration2 %}

添加另一个 attribute：折叠刚添加的 "frequency" attribute，点击"**Add attribute**"，按相同步骤填写以下值：

| **字段名** | **值** |
|:---------------|:----------|
| Key            | power     |
| Type           | Path      |
| Value          | ${Power}  |
| ---            |           |

完成配置后点击"**Apply**"。

{% assign dataMappingConfiguration3 = '
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-6-ce.png,
        title: 折叠刚添加的 "frequency" attribute，点击"**Add attribute**"添加另一 attribute；
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-7-ce.png,
        title: 按文档填写字段值。然后点击"**Apply**"。
'
%}

{% include images-gallery.liquid imageCollection=dataMappingConfiguration3 %}

完成"**Attributes**"部分后，进入"**Time series**"部分。本部分配置用于处理 OPC-UA 服务器数据，在 ThingsBoard 中将被解释为设备 time series。

按以下步骤配置 time series 部分：

- 点击"**Time series**"部分的"**铅笔**"图标；
- 在打开窗口中点击"**Add time series**"；
- 填写字段：
  - 在"**Key**"中填写"**temperature**"；
  - 将"**Type**"选为"**Path**"；
  - 在"**Value**"中填写"**${Temperature}**"。

{% assign dataMappingConfiguration4 = '
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-8-ce.png,
        title: 点击"**Time series**"部分的"**铅笔**"图标；
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-9-ce.png,
        title: 在打开窗口中点击"**Add time series**"；
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-10-ce.png,
        title: 按文档填写字段值。
'
%}

{% include images-gallery.liquid imageCollection=dataMappingConfiguration4 %}

添加另一 time series：折叠刚添加的"**temperature**"time series，点击"**Add time series**"，按相同步骤填写以下值：

| **字段名** | **值**   |
|:---------------|:------------|
| Key            | humidity    |
| Type           | Path        |
| Value          | ${Humidity} |
| ---            |             |

{% assign dataMappingConfiguration5 = '
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-11-ce.png,
        title: 折叠刚添加的"**temperature**"time series，点击"**Add time series**"添加另一 time series；
    ===
        image: /images/gateway/dashboard/data-mapping-configuration-12-ce.png,
        title: 按文档填写字段值。然后点击"**Apply**"。
'
%}

{% include images-gallery.liquid imageCollection=dataMappingConfiguration5 %}

配置完成后，connector 的最终效果如下。完成后点击"**Add**"。

{% assign finalDataMappingConfiguration1 = '
    ===
        image: /images/gateway/dashboard/final-configured-data-mapping-1-ce.png,
        title: 配置完成后的 connector 最终效果。完成后点击"**Add**"。
'
%}

{% include images-gallery.liquid imageCollection=finalDataMappingConfiguration1 %}

最后，点击"**Save**"保存 OPC-UA 配置。

{% assign finalDataMappingConfiguration2 = '
    ===
        image: /images/gateway/dashboard/final-configured-data-mapping-2-ce.png,
        title: 最后，点击"**Save**"保存 OPC-UA 配置。
'
%}

{% include images-gallery.liquid imageCollection=finalDataMappingConfiguration2 %}

完成上述步骤后，网关将接收并应用新配置，并与远程服务器同步状态。
可在"**Configuration**"列查看 connector 配置的同步状态，确认网关是否与远程设置一致。

{% assign finalDataMappingConfiguration3 = '
    ===
        image: /images/gateway/dashboard/final-configured-data-mapping-3-ce.png,
        title: 可在"**Configuration**"列查看 connector 配置的同步状态。
'
%}

{% include images-gallery.liquid imageCollection=finalDataMappingConfiguration3 %}

此外，可查看 connector 日志以确认 connector 工作正常：
{% assign seeConnectorLogs = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-14-ce.png,
        title: 在 connector 的"**General**"标签页中，开启"**Enable remote logging**"启用远程日志。在"**Log level**"下拉中选择"**DEBUG**"。点击"**Save**"应用更改；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-12-ce.png,
        title: 点击日志图标打开 connector 日志页面；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-logs-13-ce.png,
        title: 可看到由"**Created time**"、"**Status**"和"**Message**"列组成的"**Logs**"表格。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=seeConnectorLogs %}

至此，网关已可通过新建并配置的 OPC-UA connector 处理数据。
