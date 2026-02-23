下面我们添加 **Modbus connector**，它将从演示 slave 读取部分数据到已创建的网关。

### 配置演示服务器

我们将使用 docker 镜像作为演示仿真 slave，可通过以下命令安装并运行：

```shell
docker run -it -p 5021:5021 thingsboard/tb-gw-modbus-server:latest
```
{:.copy-code}

运行 docker 镜像后，终端会显示以下日志：

![](/images/gateway/dashboard/run-demo-modbus-server.png)

### 配置 connector

此 Modbus connector 配置通过 TCP 与端口 5021 上 **"host.docker.internal"** 的 slave 设备通信。
配置包括字节序、字序、timeout、轮询周期等数据获取规格。
名为 **"Demo Device"** 的 slave 设备配置为处理 Modbus function code 4 请求。
为 **frequency**、**power**、**humidity**、**temperature** 等参数定义了 attribute 和 time series mapping。此外还提供连接尝试、重试及失败后等待时间的配置。

创建 connector 请按以下步骤操作：

{% assign addNewConnector = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-7-ce.png,
        title: 在右侧面板点击"**Connectors configuration**"按钮；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-8-ce.png,
        title: 点击"**+ Add connector**"按钮；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-modbus-9-ce.png,
        title: 在下拉中选择"**MODBUS**"connector 类型，填写"**Name**"，将"**Logging level**"设为"**INFO**"，关闭"**Fill configuration with default values**"并点击"**Add**"；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-modbus-10-ce.png,
        title: Connector 已创建。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addNewConnector %} 

首先添加新 slave 并配置到其的连接。从"**Master Connections**"标签页开始。
该部分提供 slave 添加及连接类型、host、port、unit ID、method 等详细连接配置。

- 进入"**Master Connections**"标签页，点击"**Add Slave**"；
- 按下列值填写字段：

| **字段名**    | **值**            |
|:------------------|:---------------------|
| Server Connection | TCP                  |
| Host              | host.docker.internal |
| Port              | 5021                 |
| Method            | Socket               |
| Unit ID           | 1                    |
| Device name       | Demo Device          |
| Device profile    | default              |
| ---               |                      |

{% assign addNewSlave = '
    ===
        image: /images/gateway/dashboard/add-new-slave-1-ce.png,
        title: 进入"**Master Connections**"标签页，点击"**Add Slave**"；
    ===
        image: /images/gateway/dashboard/add-new-slave-2-ce.png,
        title: 按文档填写字段值。
'
%}

{% include images-gallery.liquid imageCollection=addNewSlave %}

接下来进入"**Attributes**"部分。本部分配置用于处理 Modbus 服务器数据，在 ThingsBoard 中将被解释为设备 attribute。

按以下步骤配置 attribute 部分：

- 点击"**Attributes**"部分的"**铅笔**"图标；
- 在打开窗口中点击"**Add attribute**"；
- 填写字段：
  - 在"**Key**"中填写"**frequency**"；
  - 将"**Type**"选为"**16int**"；
  - 将"**Function code**"选为"**03 - Read Multiple Holding Registers**"；
  - 将"**Objects count**"设为"**1**"；
  - 将"**Address**"设为"**3**"。
  - 开启"**Modifier**"开关；
  - 在"**Modifier**"部分，将"**Type**"设为"**divider**"；
  - 在"**Modifier**"部分，将"**Value**"设为"**10**"。

{% assign attributeConfiguration1 = '
    ===
        image: /images/gateway/dashboard/slave-configuration-1-ce.png,
        title: 点击"**Attributes**"部分的"**铅笔**"图标；
    ===
        image: /images/gateway/dashboard/slave-configuration-2-ce.png,
        title: 在打开窗口中点击"**Add attribute**"；
    ===
        image: /images/gateway/dashboard/slave-configuration-3-ce.png,
        title: 按文档填写字段值。
'
%}

{% include images-gallery.liquid imageCollection=attributeConfiguration1 %}

添加另一 attribute：折叠刚添加的 "frequency" attribute，点击"**Add attribute**"，按相同步骤填写以下值：

| **字段名** | **值** |
|:---------------|:----------|
| Key            | power     |
| Type           | 16int     |
| Function code  | 3         |
| Objects count  | 1         |
| Address        | 2         |
| Modifier       | Divider   |
| Modifier Value | 10        |
| ---            |           |

完成"**Attributes**"配置后点击"**Apply**"。

{% assign attributeConfiguration2 = '
    ===
        image: /images/gateway/dashboard/slave-configuration-4-ce.png,
        title: 折叠刚添加的"**frequency**"attribute，点击"**Add attribute**"添加另一 attribute；
    ===
        image: /images/gateway/dashboard/slave-configuration-5-ce.png,
        title: 按文档填写字段值。然后点击"**Apply**"。
'
%}

{% include images-gallery.liquid imageCollection=attributeConfiguration2 %}

完成"**Attributes**"部分后，进入"**Time series**"部分。本部分配置用于处理 Modbus 服务器数据，在 ThingsBoard 中将被解释为设备 time series。

按以下步骤配置 time series 部分：

- 点击"**Time series**"部分的"**铅笔**"图标。
- 在打开窗口中点击"**Add time series**"；
- 填写字段：
  - 在"**Key**"中填写"**humidity**"；
  - 将"**Type**"选为"**16int**"； 
  - 将"**Function code**"选为"**03 - Read Multiple Holding Registers**"；
  - 将"**Objects count**"设为"**1**"； 
  - 将"**Address**"设为"**1**"。
  - 开启"**Modifier**"开关；
  - 在"**Modifier**"部分，将"**Type**"设为"**divider**"；
  - 在"**Modifier**"部分，将"**Value**"设为"**10**"。

{% assign timeSeriesConfiguration1 = '
    ===
        image: /images/gateway/dashboard/slave-configuration-6-ce.png,
        title: 点击"**Time series**"部分的"**铅笔**"图标；
    ===
        image: /images/gateway/dashboard/slave-configuration-7-ce.png,
        title: 在打开窗口中点击"**Add time series**"；
    ===
        image: /images/gateway/dashboard/slave-configuration-8-ce.png,
        title: 按文档填写字段值。
'
%}

{% include images-gallery.liquid imageCollection=timeSeriesConfiguration1 %}

添加另一 time series：折叠刚添加的"**humidity**"time series，点击"**Add time series**"，按相同步骤填写以下值：

| **字段名** | **值**   |
|:---------------|:------------|
| Key            | temperature |
| Type           | 16int       |
| Function code  | 3           |
| Objects count  | 1           |
| Address        | 0           |
| Modifier       | Divider     |
| Modifier Value | 10          |
| ---            |             |

{% assign timeSeriesConfiguration2 = '
    ===
        image: /images/gateway/dashboard/slave-configuration-9-ce.png,
        title: 折叠刚添加的"**humidity**"time series，点击"**Add time series**"添加另一 time series；
    ===
        image: /images/gateway/dashboard/slave-configuration-10-ce.png,
        title: 按文档填写字段值。然后点击"**Apply**"。
'
%}

{% include images-gallery.liquid imageCollection=timeSeriesConfiguration2 %}

配置完成后，connector 的最终效果如下。完成后点击"**Add**"。

{% assign finalSlaveConfiguration = '
    ===
        image: /images/gateway/dashboard/final-configured-slave-1-ce.png,
        title: 配置完成后的 connector 最终效果。完成后点击"**Add**"。
'
%}

{% include images-gallery.liquid imageCollection=finalSlaveConfiguration %}

最后，点击"**Save**"保存 Modbus 配置。

{% assign finalSlaveConfiguration2 = '
    ===
        image: /images/gateway/dashboard/final-configured-slave-2-ce.png,
        title: 最后，点击"**Save**"保存 Modbus 配置。
'
%}

{% include images-gallery.liquid imageCollection=finalSlaveConfiguration2 %}

完成上述步骤后，网关将接收并应用新配置，并与远程服务器同步状态。
可在"**Configuration**"列查看 connector 配置的同步状态，确认网关是否与远程设置一致。

{% assign finalSlaveConfiguration3 = '
    ===
        image: /images/gateway/dashboard/final-configured-slave-3-ce.png,
        title: 可在"**Configuration**"列查看 connector 配置的同步状态。
'
%}

{% include images-gallery.liquid imageCollection=finalSlaveConfiguration3 %}

此外，可查看 connector 日志以确认 connector 工作正常：
{% assign seeConnectorLogs = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-modbus-logs-14-ce.png,
        title: 在 connector 的"**General**"标签页中，开启"**Enable remote logging**"启用远程日志。在"**Log level**"下拉中选择"**DEBUG**"。点击"**Save**"应用更改；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-modbus-12-ce.png,
        title: 点击"**logs**"图标打开 connector 日志页面；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-modbus-logs-13-ce.png,
        title: 可看到由"**Created time**"、"**Status**"和"**Message**"列组成的"**Logs**"表格。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=seeConnectorLogs %}

至此，网关已可通过新建并配置的 Modbus connector 处理数据。
