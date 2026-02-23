* TOC
{:toc}

本指南将带领您完成通过 SIA Connect 将 OPC-UA 设备连接到 ThingsBoard 平台的全过程。

[SIA Connect](https://sia-connect.com/){:target="_blank"} 是实现这一连接的工具。通过将 OPC-UA 设备连接到 ThingsBoard 平台，您可以以高可扩展且灵活的方式监控、控制和自动化设备。请跟随我们一步步完成此过程。

{% capture difference %}
在开始本指南之前，建议您先完成[快速入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/){:target="_blank"}指南，以熟悉 ThingsBoard 的设备和仪表板。这将有助于您更好地理解本文档中介绍的概念。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 在 ThingsBoard 上创建设备

为简便起见，我们将通过 UI 手动创建设备：

{% include images-gallery.liquid showListImageTitles="true" imageCollection="creating-device-on-thingsboard" %}

## 启动演示 OPC-UA 服务器

我们将使用 Docker 镜像作为演示 OPC-UA 服务器，可通过以下命令安装并运行：

```text
docker run -it -p 4840:4840 thingsboard/tb-gw-opcua-server:latest
```
{: .copy-code}

运行 Docker 镜像后，您将在终端中看到以下日志：

![image](/images/user-guide/integrations/sia-connect/terminal-opc-ua.png)

## 配置 SIA Connect

### 安装 SIA Connect

本文示例中，我们通过 <b>.deb</b> 包安装了 SIA Connect。您可在[此处](https://help.sia-connect.com/en_US/linux-installation/install-sia-connect-on-linux){:target="_blank"}查看官方安装指南。此外，您也可以使用[此处](https://help.sia-connect.com/en_US/docker/install-sia-connect-using-docker){:target="_blank"}的 Docker 镜像进行安装。
安装成功后，访问默认地址 <b>127.0.0.1:80</b>（Web UI 运行地址，具体地址可能因您的设置而异）。

{% include images-gallery.liquid imageCollection="installing-sia-connect" %}

您需要登录并输入 LICENSE key。也可以使用演示版本，该版本有 30 分钟会话限制。

### 安装 OPC-UA 连接器

接下来需要下载 <b>OPC-UA</b> 连接器。请按以下步骤操作：

- 在侧边栏中进入「<b>Connectors</b>」页面；
- 点击「<b>Search for Connector to download & install</b>」输入框，输入连接器名称「<b>OPC-UA</b>」；
- 找到「<b>OPC-UA Client</b>」，点击相应按钮进行下载。

<b>OPC-UA</b> 连接器已安装。

{% include images-gallery.liquid imageCollection="installing-opc-ua-connector" %}

### 安装 MQTT 连接器

还需要下载 <b>MQTT</b> 连接器以建立与 ThingsBoard 的连接。步骤与下载其他连接器相同：

- 在侧边栏中进入「<b>Connectors</b>」页面；
- 点击「<b>Search for Connector to download & install</b>」输入框，输入「<b>MQTT</b>」；
- 找到「<b>MQTT</b>」，点击相应按钮进行下载。

<b>MQTT</b> 连接器已安装。

{% include images-gallery.liquid imageCollection="installing-mqtt-connector" %}

## 添加实例

要连接我们的测试设备，需要创建两个实例：

- 一个用于设备——该实例将连接到演示 OPC-UA 服务器并接收其数据；
- 一个用于 ThingsBoard——该实例将映射来自设备实例的数据，转换为合适格式，并发送到 ThingsBoard。

### 添加 OPC-UA 设备实例

首先创建 OPC-UA 设备实例，请按以下步骤操作：

- 在侧边栏的「<b>Instance</b>」标签页中点击「<b>+ Add new instance</b>」按钮；
- 填写输入字段：
  - 「<b>Name</b>」——「<b>OPC-UA Device</b>」；
  - 「<b>Address</b>」——「<b>opc.tcp://127.0.0.1:4840/freeopcua/server/</b>」；
- 禁用安全设置；
- 点击「<b>Save instance</b>」按钮。

OPC-UA 设备实例已添加。

{% include images-gallery.liquid imageCollection="adding-opc-ua-device-instance-1" %}

此外，需要创建项（item）。项代表实例内的数据点，例如 PLC 中的标签、MQTT broker 中的主题、REST API 的端点或数据库查询。请按以下步骤向 OPC-UA 设备实例添加新项：

- 在「<b>Items</b>」区域点击「<b>+ New item</b>」；
- 填写输入字段：
  - 「<b>Name</b>」——「<b>Temperature</b>」；
  - 将「<b>Read write</b>」设置为「<b>Read only</b>」；
  - 「<b>Identifier</b>」——「<b>ns=2;i=13</b>」；
- 点击「<b>Save item</b>」按钮。

此时您将看到已添加的「<b>Temperature</b>」项。

{% include images-gallery.liquid imageCollection="adding-opc-ua-device-instance-2" %}

按上述步骤添加其他项，如「<b>Power</b>」和「<b>Humidity</b>」。

| **Item Name** | **Identifier** |
|:--------------|:---------------|
| Power         | **ns=2;i=14**  |
| Humidity      | **ns=2;i=15**  |

完成后，您将得到如下项列表：

{% include images-gallery.liquid imageCollection="adding-opc-ua-device-instance-3" %}

### 添加 ThingsBoard 实例

该实例将映射来自设备实例的数据，转换为合适格式并发送到 ThingsBoard。要添加新实例，请按以下步骤操作：

- 在侧边栏的<b>「Instance」</b>标签页点击<b>「+ Add new instance」</b>按钮；
- 填写输入字段：
  - 「<b>Name</b>」——「<b>ThingsBoard</b>」；
  - 「<b>Address</b>」——「<b>您的 ThingsBoard 主机</b>」。本示例为 <b>thingsboard.cloud</b>；
  - <b>「Port」</b>——「<b>1883</b>」；
  - 在 <b>「Username」</b>、<b>「Device id」</b> 和 <b>「Password」</b> 字段中填入[创建设备](#creating-device-on-thingsboard)时指定的凭据；
- 点击<b>「Save instance」</b>按钮。

ThingsBoard 实例已添加。

{% include images-gallery.liquid imageCollection="adding-thingsboard-instance-1" %}

现在需要添加新项。请按以下步骤操作：

- 在「<b>Items</b>」区域点击<b>「+ New item」</b>；
- 填写输入字段：
  - 「<b>Name</b>」——「<b>Publish data</b>」；
  - 将「<b>Read write</b>」设置为<b>「Write only」</b>；
  - 「<b>Topic</b>」——「<b>v1/devices/me/telemetry</b>」；
  - 「<b>Input template</b>」——「<b>{&#37;ITEM.NAME&#37;: &#37;VALUE&#37;}</b>」；
- 点击<b>「Save item」</b>按钮。

<b>Publish data</b> 项已添加。

{% include images-gallery.liquid imageCollection="adding-thingsboard-instance-2" %}

最后，需要添加映射。映射是两个项之间的虚拟连接，用于处理二者之间的数据传输（例如从 PLC 项到 MQTT 项的映射）。请按以下步骤操作：

- 在「<b>Mappings on ThingsBoard</b>」区域点击<b>「+ New mapping」</b>；
- 「<b>Sender Item</b>」选择实例「<b>OPC-UA Device</b>」和项「<b>Temperature</b>」；
- 「<b>Receiver item</b>」选择「<b>Instance</b>」为「<b>ThingsBoard</b>」、项为「<b>Publish data</b>」；
- 点击「<b>Save mapping</b>」按钮。

映射已添加。

{% include images-gallery.liquid imageCollection="adding-thingsboard-instance-3" %}

按上述步骤添加其他映射，如「<b>Power</b>」和「<b>Humidity</b>」。

完成以上步骤后，您将得到如下映射列表：

{% include images-gallery.liquid imageCollection="adding-thingsboard-instance-4" %}

## 在 ThingsBoard 上查看数据

当您成功完成上述所有步骤且 SIA Connect 已发送数据后，可在 ThingsBoard 实例中设备的「Latest telemetry」标签页查看：

- 进入 <b>ThingsBoard</b> 实例「<b>Entities</b>」下的「<b>Devices</b>」页面；
- 点击表格中的 OPC-UA Device 行打开设备详情；
- 进入「<b>Latest telemetry</b>」标签页。

您应能看到传入数据。

{% include images-gallery.liquid imageCollection="check-data-on-thingsboard" %}

## 使用共享属性修改 OPC-UA 节点值

本节将配置 SIA Connect 以修改 OPC-UA 节点的值，具体为修改设备状态节点。

为此，需要在 <b>SIA Connect</b> 的 <b>ThingsBoard</b> 实例中再创建一个项：

- 在侧边栏的「<b>Instance</b>」标签页中选择「<b>ThingsBoard</b>」；
- 在「<b>Items</b>」区域点击「<b>+ New item</b>」；
- 填写输入字段：
  - 「<b>Name</b>」——「<b>Shared attribute update</b>」；
  - 将「<b>Read write</b>」下拉框设置为「<b>Read only</b>」；
  - 「<b>Topic</b>」——「<b>v1/devices/me/attributes</b>」；
- 点击「<b>Save item</b>」按钮。

项已添加。

{% include images-gallery.liquid imageCollection="shared-attributes" %}

此外，需要在 **OPC-UA Device** 实例上创建项，请按以下步骤操作：

- 在侧边栏的「<b>Instance</b>」标签页中选择 <b>OPC-UA Device</b>；
- 在「<b>Items</b>」区域点击「<b>+ New item</b>」；
- 填写输入字段：
  - 「<b>Name</b>」——「<b>Status</b>」；
  - 将「<b>Read write</b>」下拉框设置为「<b>Read and Write</b>」；
  - 「<b>Post-processing (reading)</b>」——<b>"%VALUE%"</b>；
  - 「<b>Identifier</b>」——「<b>ns=4;s=Status_s</b>」；
- 点击「<b>Save item</b>」按钮。

项已添加。

{% include images-gallery.liquid imageCollection="status-attributes" %}

下一步是创建另一个映射，用于 ThingsBoard 实例与 OPC-UA 设备之间的数据传输。请按以下步骤操作：

- 在 <b>ThingsBoard</b> 实例中向下滚动到「<b>Mappings</b>」区域，点击「<b>+ New Mapping</b>」按钮；
- 「<b>Sender Item</b>」选择实例「<b>ThingsBoard</b>」和项「<b>Shared attribute update</b>」；
- 「<b>Receiver item</b>」选择实例「<b>OPC-UA Device</b>」和项「<b>Status</b>」；
- 在「<b>Custom value</b>」字段粘贴「<b>%VALUE.status%</b>」；
- 点击「<b>Save mapping</b>」按钮。

{% include images-gallery.liquid imageCollection="create-another-mapping" %}

最后，需要在 ThingsBoard 平台的设备上创建共享属性。请按以下步骤操作：

- 进入 <b>ThingsBoard</b> 实例的「<b>Entities</b>」下的「<b>Devices</b>」页面；
- 点击「<b>OPC-UA Device</b>」，进入「<b>Attributes</b>」标签页；
- 在下拉框中选择「<b>Shared attributes</b>」，点击「<b>plus</b>」按钮创建新共享属性；
- 在「<b>Key</b>」字段填入「<b>status</b>」，并在下拉框中选择「<b>Boolean</b>」数据类型；
- 点击「<b>Add</b>」按钮。

共享属性已添加。

{% include images-gallery.liquid imageCollection="shared-attribute-on-device" %}

## 在 ThingsBoard 上可视化数据

为可视化 Sia Connect 的数据，我们将创建[仪表板](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}：

- 首先，下载 [sia_connect.json](/docs/pe/user-guide/resources/sia_connect.json){:target="_blank"} 文件；

{% include images-gallery.liquid showListImageTitles="true" imageCollection="import-dashboard" %}

导入仪表板后，请确认已在[实体别名](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}中指定您的 OPC-UA Device。这样可确保数据正确显示。

{% include images-gallery.liquid showListImageTitles="true" imageCollection="change-entity-alias-1" %}

若正确完成以上步骤，您现在应能看到仪表板中显示来自 OPC-UA Device 的数据。

{% include images-gallery.liquid imageCollection="visualize-data-on-thingsboard" %}

## 结论

按照本指南的说明，您可以轻松地使用 SIA Connect 在 OPC-UA 设备与 ThingsBoard 平台之间建立连接。
本指南经过精心设计，提供完成此连接所需的全部分析与步骤。无论您是资深专家还是初学者，本指南都能让该过程简单明了。
