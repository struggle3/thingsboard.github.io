* TOC
{:toc}

[ThingsBoard Edge](/docs/{{docsPrefix}}getting-started-guides/what-is-edge/){: target="_blank"} 可与 [ThingsBoard IoT Gateway](/docs/iot-gateway/what-is-iot-gateway/){: target="_blank"} 一起运行。
由于 **Edge** 在源头处理数据的能力以及 **IoT Gateway** 扩展的通信协议列表，此方式可创建稳健的分布式物联网架构。

## 工作原理

**ThingsBoard IoT Gateway** 在本地收集数据，将其转换为 [ThingsBoard 兼容的通信协议](/docs/{{peDocsPrefix}}edge/api/){: target="_blank"}，并传输到 **ThingsBoard Edge**。
[Rule Engine](/docs/{{peDocsPrefix}}user-guide/rule-engine-2-0/re-getting-started/){: target="_blank"} 实时处理数据，支持即时可视化和事件响应。如需要，可将汇总或聚合数据发送到中央服务器进行分析。

![image](/images/edge/how-does-it-work.webp){: style="display: block; margin: auto; max-width: 600px; max-height: 600px"}

{% capture local-deployment %}
在互联网连接不可靠的偏远地区部署时，**Edge** 将在连接恢复前持续运行。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

## 前置条件
* 已安装 [Docker](https://docs.docker.com/engine/install/){: target="_blank"}
* **ThingsBoard Cloud** 账户（Demo、Professional edition 或 Community edition）
* 任意基于 Linux 的 **IoT Gateway** 设备

## 步骤 1. 创建新的 Edge 实例

{% include images-gallery.html imageCollection="startEdge" showListImageTitles="true" %}

## 步骤 2. 在 Gateway 设备上安装 Edge

要在 **IoT Gateway** 设备上安装 **Edge 实例**，请通过终端发起到 **设备** 的 **SSH (Secure Shell)** 连接：

```bash
ssh username@ip_address
```
{: .copy-code}

* **username：** 输入具有 Gateway 设备访问权限的实际用户名；
* **ip_address：** 输入 Gateway 设备的实际 IP 地址；
* **password：** 终端将请求认证凭据。

{% capture local-deployment %}
若 **SSH** 服务器在非默认端口运行，请使用 **-p** 命令指定。<br>
示例：_ssh -p 2222 username@ip_address_
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

连接后，创建新目录：

```bash
mkdir tb_edge
```
{: .copy-code}

在此目录中为 **ThingsBoard Edge** 服务创建 docker-compose 文件：

```bash
nano docker-compose.yml
```
{: .copy-code}

配置此文件：

{% include images-gallery.html imageCollection="copyYml" showListImageTitles="true" %}

要在 **IoT Gateway 设备** 上运行 **Edge 实例**，请执行以下命令：

```bash
docker compose up -d
docker compose logs -f mytbedge
```
{: .copy-code}

{% capture local-deployment %}
必须在保存 **docker-compose.yml** 文件的同一目录中执行该命令。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

要配置 **通过 SSH 的本地端口转发**，请打开 **另一个终端标签** 并执行以下命令：

```bash
ssh -N -L 8080:127.0.0.1:8080 username@ip_address
```
{: .copy-code}

* **8080：** 本地机器上的端口；
* **127.0.0.1：** IoT Gateway 设备可访问的目标远程主机；
* **8080：** 访问 IoT Gateway 设备的端口。
* **username：** 输入具有 Gateway 设备访问权限的实际用户名；
* **ip_address：** 输入 Gateway 设备的实际 IP 地址；

本地机器上对 **localhost:8080** 的任何连接将转发到 **IoT Gateway 设备** 的 **127.0.0.1:8080**。**ThingsBoard Edge** 实例可通过 [**http://127.0.0.1:8080**](http://127.0.0.1:8080){: target="_blank"} 访问。使用您的凭据登录。

## 步骤 3. 在 Edge 上配置 ThingsBoard IoT Gateway

要在 **Edge** 实例上配置 **ThingsBoard Gateway**：

{% include images-gallery.html imageCollection="provisionGW" showListImageTitles="true" %}

## 步骤 4. 在 Gateway 设备上安装 ThingsBoard IoT Gateway 软件

下载 **docker-compose.yml** 文件后，打开终端并发起到 **IoT Gateway 设备** 的 **SSH** 连接：

```bash
ssh username@ip_address
```
{: .copy-code}

* **username：** 输入具有 Gateway 设备访问权限的实际用户名；
* **ip_address：** 输入 Gateway 设备的实际 IP 地址；
* **password：** 终端将请求认证凭据。

要安装 **ThingsBoard IoT Gateway**，请创建新目录：

```bash
mkdir iot_gateway
```
{: .copy-code}

在此目录中为 **ThingsBoard IoT Gateway** 创建 docker-compose 文件：

```bash
nano docker-compose.yml
```
{: .copy-code}

将之前下载的 **docker-compose.yml** 文件内容通过终端复制并粘贴到新文件中：

{% include images-gallery.html imageCollection="copyPasteYml" %}

保存 **docker-compose.yml** 文件中的更改。要关闭，请按 **CTRL+X**。

要在终端中启动 **ThingsBoard IoT Gateway**，请执行以下命令：

```bash
docker compose up -d
docker compose logs -f
```
{: .copy-code}

**ThingsBoard Edge** 和 **ThingsBoard IoT Gateway** 在 **IoT Gateway 设备** 上运行后，即可连接物联网设备和传感器以传输数据。当 **ThingsBoard Edge** 和 **Gateway** 部署在同一 **IoT Gateway 设备** 上时，请参阅[此在仪表板上可视化物联网设备数据的实际示例](/docs/{{docsPrefix}}device-library/recomputer-r1000/#visualize-incoming-data-with-the-dashboard){: target="_blank"}。

## 下一步

{% include templates/edge/guides-banner-edge.md %}
