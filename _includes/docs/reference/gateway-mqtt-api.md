* TOC
{:toc}

ThingsBoard中的网关是一种特殊设备类型，充当外部设备与平台之间的桥梁。 
网关保持与ThingsBoard的单条MQTT连接，同时为连接在其后的多台物理设备代理数据。

网关本身也是标准ThingsBoard设备。它可使用[MQTT Device API](/docs/{{docsPrefix}}reference/mqtt-api/){:target="_blank"}完成：
- 发布自身的遥测与属性
- 接收配置更新
- 执行RPC命令

此外，本API定义网关专用的MQTT主题与载荷格式，被开源[ThingsBoard IoT Gateway](/docs/iot-gateway/what-is-iot-gateway/){:target="_blank"}所使用。

{% capture difference %}
设备级MQTT细节（认证、QoS、载荷格式等）请参见[MQTT Device API](/docs/{{docsPrefix}}reference/mqtt-api/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

## 客户端库配置

不同平台和语言有多种MQTT客户端库可用。

本指南示例使用：   
&#8194;**&#8226;**&#8194;**Mosquitto**（命令行工具）   
&#8194;**&#8226;**&#8194;**MQTT.js**（JavaScript）

按以下说明安装命令行工具：   
&#8194;**&#8226;**&#8194;<span class="code-light">mosquitto_pub</span>   
&#8194;**&#8226;**&#8194;<span class="code-light">mosquitto_sub</span>

选择您的操作系统继续安装：

{% capture connectdevicetogglespec %}
MQTT<small>Linux or macOS</small>%,%mqtt-linux%,%templates/helloworld-pe/mqtt-linux.md%br%
MQTT<small>Windows</small>%,%mqtt-windows%,%templates/helloworld-pe/mqtt-windows.md{% endcapture %}
{% include content-toggle.html content-toggle-id="connectdevice" toggle-spec=connectdevicetogglespec %}

<hr>

## 设备连接 API

使用此API告知ThingsBoard：网关后的某台设备已连接并准备交换数据。

**Topic:**

```shell
v1/gateway/connect
```
{: .copy-code}

**Payload:**

```shell
{"device": "Device A", "type": "Sensor A"}
```
{: .copy-code}
- **device** - 必填。设备在ThingsBoard中的名称。
- **type** – 可选。设备配置名称。省略时使用 `default` 设备配置。

**行为：**

- 若不存在同名设备，ThingsBoard将自动创建。
- 若提供设备配置名称且该配置不存在，ThingsBoard将自动创建。
- 连接后，ThingsBoard将通过网关为该设备路由以下事件：
  - 共享属性更新。
  - RPC命令。

{% capture difference %}
**仅适用于MQTT v.5**

建议等待PUBACK响应以确认设备连接成功。
若连接过程中出错（例如超出设备限制），PUBACK将返回对应的[状态码](/docs/{{docsPrefix}}reference/mqtt-v5-errors-code/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**示例**

{% unless docsPrefix contains "paas/" %}

> ⚠️ 本页所有示例中的主机名均指**本地**ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}安装。   
若您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}实例部署在其他主机，请将<code>localhost</code>替换为相应主机名或IP地址。

{% endunless %}

> 请勿忘记将<code>$ACCESS_TOKEN</code>替换为您的网关设备访问令牌。

**示例1.** 连接设备。

为告知ThingsBoard设备已连接至网关，需发布以下消息：

```bash
mosquitto_pub -h "{{mqttHostName}}" -t "v1/gateway/connect" -u "$ACCESS_TOKEN" -m '{"device": "Device A"}'
```
{: .copy-code}

**示例2.** 使用指定设备配置连接设备。

为告知ThingsBoard设备已以指定设备配置连接至网关，需发布以下消息：

```bash
mosquitto_pub -h "{{mqttHostName}}" -t "v1/gateway/connect" -u "$ACCESS_TOKEN" -m '{"device": "Device A", "type": "Sensor A"}'
```
{: .copy-code}

<hr>

## 设备断开连接API

使用此API告知ThingsBoard：网关后的某台设备已不再活跃。

**Topic:**

```shell
v1/gateway/disconnect
```
{: .copy-code}

**Payload:**

```shell
{"device": "Device A"}
```
{: .copy-code}

**行为：**

- 若不存在同名设备，ThingsBoard将忽略该消息。
- 处理此消息后，ThingsBoard将停止向网关发送该设备的属性和RPC更新。

{% capture difference %}
**仅适用于MQTT v.5**

断开过程中若出错，PUBACK将返回对应的[状态码](/docs/{{docsPrefix}}reference/mqtt-v5-errors-code/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**示例**

> ⚠️ 请将<code>$ACCESS_TOKEN</code>替换为您的网关设备访问令牌。

断开前请确保设备已连接。

为告知ThingsBoard设备已从网关断开，需发布以下消息：

```bash
mosquitto_pub -h "{{mqttHostName}}" -t "v1/gateway/disconnect" -u "$ACCESS_TOKEN" -m '{"device": "Device A"}'
```
{: .copy-code}

<hr>

## Attributes API

ThingsBoard属性API允许设备：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
- 将[客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性上传至服务器。
- 从ThingsBoard平台请求[客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}和[共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性。
- 订阅ThingsBoard平台的[共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性。
{% endif %}
{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
- 将[客户端](/docs/pe/user-guide/attributes/#attribute-types){:target="_blank"}设备属性上传至服务器。
- 从ThingsBoard平台请求[客户端](/docs/pe/user-guide/attributes/#attribute-types){:target="_blank"}和[共享](/docs/pe/user-guide/attributes/#attribute-types){:target="_blank"}设备属性。
- 订阅ThingsBoard平台的[共享](/docs/pe/user-guide/attributes/#attribute-types){:target="_blank"}设备属性。
{% endif %}

<hr>

### 发布属性至ThingsBoard

使用此主题将客户端设备属性发布至ThingsBoard平台。载荷中所有属性将作为对应设备的客户端属性存储。

**Topic:**

```shell
v1/gateway/attributes
```
{: .copy-code}

**Payload:**

```json
{
  "Device A": {
    "attribute1": "value1",
    "attribute2": 42
  },
  "Device B": {
    "attribute1": "value1",
    "attribute2": 42
  }
}
```
{: .copy-code}

**行为：**

- 若不存在同名设备，ThingsBoard将自动创建并使用 `default` 配置名称。
- 若属性不存在则创建。
- 若属性已存在则更新其值。

{% capture difference %}
**仅适用于MQTT v.5**

发布过程中若出错，PUBACK将返回对应的[状态码](/docs/{{docsPrefix}}reference/mqtt-v5-errors-code/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**示例**

> ⚠️ 请将<code>$ACCESS_TOKEN</code>替换为您的网关设备访问令牌。

为将客户端设备属性发布至ThingsBoard平台，需发布以下消息：

```bash
mosquitto_pub -h "{{mqttHostName}}" -t "v1/gateway/attributes" -u "$ACCESS_TOKEN" -m '{"Device A": { "fw_version": "1.0", "battery": 87 }}'
```
{: .copy-code}

<hr>

### 从ThingsBoard请求属性值

使用此API从ThingsBoard平台请求客户端或共享设备属性。注意需先订阅响应主题才能收到响应。

**Subscribe topic:**

```shell
v1/gateway/attributes/response
```
{: .copy-code}

**Publish topic:**

```shell
v1/gateway/attributes/request
```
{: .copy-code}

**Payload:**

```json
{
  "id": "$request_id",
  "device": "Device A",
  "client": ["key1", "key2"],
  "shared": ["key3", "key4"]
}
```
{: .copy-code}

字段：
- **id** – 必填。整数请求标识符。
- **device** – 必填。设备在ThingsBoard中的名称。
- **client** – 可选。要请求的客户端属性键数组。
- **shared** – 可选。要请求的共享属性键数组。

<hr>

### 订阅ThingsBoard的属性更新

使用此主题订阅共享设备属性变更。注意需先订阅主题才能接收更新。

**Subscribe topic:**

```shell
v1/gateway/attributes
```
{: .copy-code}

**Response message format:**

```json
{
  "device": "Device A",
  "data": {
    "attribute1": "value1",
    "attribute2": 42
  }
}
```
{: .copy-code}

字段：
- **device** – 设备在ThingsBoard中的名称。
- **data** – 更新后的共享属性映射。

<hr>

## 遥测上传API

使用此API在单条MQTT消息中为一台或多台设备发布遥测。

**Topic:**

```shell
v1/gateway/telemetry
```
{: .copy-code}

**Payload:**

```json
{
  "Device A": [
    {
      "ts": 1483228800000,
      "values": {
        "temperature": 42,
        "humidity": 80
      }
    },
    {
      "ts": 1483228801000,
      "values": {
        "temperature": 43,
        "humidity": 82
      }
    }
  ],
  "Device B": [
    {
      "ts": 1483228800000,
      "values": {
        "temperature": 42,
        "humidity": 80
      }
    }
  ]
}
```
{: .copy-code}

字段：
- **device** – 必填。设备在ThingsBoard中的名称。
- **ts** – 可选。Unix毫秒时间戳。
- **values** – 必填。遥测字段键值映射（如temperature、humidity）。

**行为：**

- 若不存在同名设备，ThingsBoard将自动创建并使用 `default` 配置名称。
- 若遥测键不存在则创建。
- 遥测数据以提供的时间戳存储。

{% capture difference %}
**仅适用于MQTT v.5**

发布过程中若出错，PUBACK将返回对应的[状态码](/docs/{{docsPrefix}}reference/mqtt-v5-errors-code/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**示例**

> ⚠️ 请将<code>$ACCESS_TOKEN</code>替换为您的网关设备访问令牌。

为将设备遥测发布至ThingsBoard平台，需发布以下消息：

```bash
mosquitto_pub -h "{{mqttHostName}}" -t "v1/gateway/telemetry" -u "$ACCESS_TOKEN" -m '{"Device A": [{"ts": 1700000000000, "values": {"temperature": 23.5, "humidity": 61 }}]}'
```
{: .copy-code}

<hr>

## RPC API

### Server-side RPC

使用此API接收并响应ThingsBoard针对网关后设备发来的RPC命令。

**Subscribe topic:**

```shell
v1/gateway/rpc
```
{: .copy-code}

**Request message format:**

```shell
{"device": "Device A", "data": {"id": $request_id, "method": "toggle_gpio", "params": {"pin": 1}}}
```
{: .copy-code}

**Response topic:**

```shell
v1/gateway/rpc
```
{: .copy-code}

**Response message format:**

```shell
{"device": "Device A", "id": $request_id, "data": {"success": true}}
```
{: .copy-code}

字段：
- **device** – 设备在ThingsBoard中的名称。
- **id** – 整数请求标识符。
- **data** – 响应载荷。

需先订阅请求主题才能接收RPC命令。处理完RPC命令后，可将响应消息发布至响应主题。

{% capture difference %}
确保设备通过网关连接以接收其RPC命令。

注意响应消息中的 **id** 应与请求消息中的 **id** 一致。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

## 设备认领API

ThingsBoard支持认领机制，允许最终用户取得预配置设备的所有权。概念详见[认领设备](/docs/{{docsPrefix}}user-guide/claiming-devices){:target="_blank"}指南。

**Topic:**

```shell
v1/gateway/claim
```
{: .copy-code}

**Payload:**

```json
{
  "Device A": {
    "secretKey": "value_A",
    "durationMs": 60000
  },
  "Device B": {
    "secretKey": "value_B",
    "durationMs": 60000
  }
}
```
{: .copy-code}

每设备参数：
- **secretKey** – 可选。设备认领用密钥。省略时使用空字符串。
- **durationMs** – 可选。认领有效期（毫秒）。省略时使用系统参数 
**device.claim.duration**（位于 **/etc/thingsboard/conf/thingsboard.yml**）。

**示例**

> ⚠️ 请将<code>$ACCESS_TOKEN</code>替换为您的网关设备访问令牌。

测试认领前请确保设备已连接。

为通知ThingsBoard平台启动设备认领流程，需发布以下消息：

```bash
mosquitto_pub -h "{{mqttHostName}}" -t "v1/gateway/claim" -u "$ACCESS_TOKEN" -m '{"Device A": {"secretKey": "mySecret", "durationMs": 60000}}'
```
{: .copy-code}

<hr>

## 协议自定义

可通过修改对应[模块](https://github.com/thingsboard/thingsboard/tree/master/transport/mqtt){:target="_blank"}，针对特定用例完全自定义MQTT传输。

<hr>

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
