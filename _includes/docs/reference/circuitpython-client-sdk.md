* TOC
{:toc}

### 概述

[CircuitPython Client SDK](https://github.com/thingsboard/CircuitPython_thingsboard-client-sdk)是用于CircuitPython项目客户端集成的软件开发套件。[CircuitPython](https://circuitpython.org/)是面向微控制器的简化版MicroPython。
它允许您使用MQTT协议将CircuitPython设备连接到ThingsBoard，发送遥测数据、属性并接收RPC调用。提供简洁、易用的API，便于将CircuitPython设备与平台集成。

CircuitPython Client SDK支持以下功能：

- 使用MQTT协议连接ThingsBoard。
- 向ThingsBoard发送属性。
- 向ThingsBoard发送遥测数据。
- 从ThingsBoard接收RPC调用。
- 从ThingsBoard请求客户端和共享属性。
- 订阅ThingsBoard的属性更新。
- 设备认领。

### 安装

首先需具备CircuitPython兼容设备并配置开发环境。可参考[CircuitPython入门指南](https://learn.adafruit.com/welcome-to-circuitpython)完成准备工作。
要安装CircuitPython Client SDK，可使用[circup](https://learn.adafruit.com/keep-your-circuitpython-libraries-on-devices-up-to-date-with-circup/overview)包管理器。
在终端中运行以下命令：

```bash
circup install thingsboard-circuitpython-client-sdk
```
{: .copy-code}

若`circup install`命令出现问题，可尝试使用[Web-Workflow](https://adafruit-playground.com/u/tyeth/pages/using-circup-with-web-workflow)安装：

```bash
circup --host <your_device_ip> --password <your_password> install thingsboard-circuitpython-client-sdk
```
{: .copy-code}

### 方法

#### 简介

CircuitPython Client SDK提供`TBDeviceMqttClient`类，用于连接ThingsBoard并发送数据。

该类设计简洁，便于 CircuitPython 或 ThingsBoard 新手使用。

#### connect

使用MQTT协议连接ThingsBoard。在向ThingsBoard发送任何数据前需调用此方法。
创建`TBDeviceMqttClient`实例时需提供连接凭证。调用`connect`方法后，客户端的`self.connected`属性将设为`True`。

**方法语法**

`client.connect()`

**使用示例**

```python
# Default connecting
client.connect()

# Connecting and waiting for the connection result
response = client.connect()
```
{: .copy-code}

#### disconnect

断开与ThingsBoard的连接。连接后即可调用此方法。建议在不再需要向ThingsBoard发送数据或需释放资源时调用。
调用此方法后，需再次调用[connect](/docs/reference/circuitpython-client-sdk/#connect)才能向ThingsBoard发送数据。调用`disconnect`后，客户端的`self.connected`属性将设为`False`。

**方法语法**

`client.disconnect()`

**使用示例**

```python
client.connect()

# some tasks with ThingsBoard

client.disconnect()
```
{: .copy-code}

#### send_attributes

向ThingsBoard发送属性。连接后即可调用。支持以键值对形式发送属性。

**方法语法**

`client.send_attributes(data)`

**参数**

| **Arguments** | **Description**                                                 |
|:--------------|:----------------------------------------------------------------|
| data          | （必填）将作为属性发送至ThingsBoard的数据。 |
| ---           |                                                                 |

**使用示例**

```python
attributes = {"sensorModel": "DHT-22", "attribute_2": "value"}
client.send_attributes(attributes)
```
{: .copy-code}

#### send_telemetry

向ThingsBoard发送遥测数据。连接后即可调用。支持以键值对、列表等多种格式发送遥测。也支持按时间戳分组发送，便于发送历史数据。

**方法语法**

`client.send_telemetry(data)`

**参数**

| **Arguments** | **Description**                                                  |
|:--------------|:-----------------------------------------------------------------|
| data          | （必填）将作为遥测发送至ThingsBoard的数据。 |
| ---           |                                                                  |

**使用示例**

```python
# Sending telemetry data in dictionary format
telemetry = {"temperature": 25.5, "humidity": 60}
client.send_telemetry(telemetry)

# Sending telemetry data grouped by timestamps
from time import time
telemetry = [{"ts": 1451649600000, "values": {"temperature": 42.2, "humidity": 71}},
             {"ts": 1451649601000, "values": {"temperature": 42.3, "humidity": 72}}]
client.send_telemetry(telemetry)
```
{: .copy-code}

#### request_attributes

从ThingsBoard请求客户端和共享属性。连接后即可调用。支持同时请求两种属性。可通过属性键列表指定要请求的属性。收到请求的属性后，将调用提供的回调函数并传入结果；若未找到，则传入空结果。

**方法语法**

`client.request_attributes(client_keys=None, shared_keys=None, callback=None)`

**参数**

| **Arguments** | **Description**                                                                                                                                                                                                                                                       |
|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| client_keys   | （可选）要从ThingsBoard请求的客户端属性键列表。                                                                                                                                                                                                 |
| shared_keys   | （可选）要从ThingsBoard请求的共享属性键列表。                                                                                                                                                                                                 |
| callback      | （可选）收到请求属性时调用的回调函数，应接受`result`和`exception`两个参数。                               |
| ---           |                                                                                                                                                                                                                                                                       |

**使用示例**

```python
def on_attributes_change(result, exception=None):
    # Callback is called when the attributes response arrives
    if exception is not None:
        print("Exception:", exception)
    else:
        print("Attributes response:", result)


# Request client/shared attributes by keys (your SDK forms attributes/request/<id>)
client.request_attributes(client_keys=["atr1", "atr2"], callback=on_attributes_change)
```
{: .copy-code}

#### claim_device

Use this method to trigger the device claiming process. By passing a unique secret 
key, the device is automatically linked to the user’s account. This simplifies the onboarding experience, as users 
can activate their hardware without needing platform-level permissions.

More information about device claiming can be found in
the [Device claiming](/docs/user-guide/claiming-devices/) section of the documentation.

**Method Syntax**

`client.claim_device(secret_key, duration_ms=None)`

**Arguments**

| **Arguments** | **Description**                                                                                                                                                            |
|:--------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| secret_key    | （必填）在ThingsBoard上用于认领设备的密钥。                                                                                                |
| duration_ms   | （可选）认领码有效时长（毫秒）。不提供则有效期为无限，直至被用于认领设备。 |
| ---           |                                                                                                                                                                            |

**使用示例**

```python
# Claiming a device with a claim code that will be valid indefinitely until it is used to claim a device
client.claim_device("my_claim_code")

# Claiming a device with a claim code that will be valid for 60 seconds
client.claim_device("my_claim_code", duration_ms=60000)
```
{: .copy-code}

#### subscribe_to_attribute

订阅ThingsBoard的属性更新。通过属性键指定要订阅的共享属性。订阅的属性值更新时，将调用提供的回调并传入新值。

方法返回订阅ID，可用于[unsubscribe_from_attribute](/docs/reference/circuitpython-client-sdk/#unsubscribe_from_attribute)取消订阅。

**方法语法**

`client.subscribe_to_attribute(key, callback)`

**参数**

| **Arguments** | **Description**                                                                                                                                                                                                        |
|:--------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| key           | （必填）要订阅的ThingsBoard共享属性键。                                                                                                                                          |
| callback      | （必填）订阅属性在ThingsBoard上更新时触发的回调，须接受 result 和 *args 两个参数。 |
| ---           |                                                                                                                                                                                                                        |

**使用示例**

```python
def callback(result, *args):
    # Called when subscribed attribute update arrive
    print("Received data: %r", result)


sub_id = client.subscribe_to_attribute("frequency", callback)
```
{: .copy-code}

#### subscribe_to_all_attributes

订阅ThingsBoard全部共享属性更新。服务端任意共享属性修改时，SDK会触发指定回调并传入更新后的数据。

方法返回订阅ID，可用于[unsubscribe_from_attribute](/docs/reference/circuitpython-client-sdk/#unsubscribe_from_attribute)取消订阅。

**方法语法**

`client.subscribe_to_all_attributes(callback)`

**参数**

| **Arguments** | **Description**                                                                                                                                                                               |
|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| callback      | （必填）服务端推送共享属性变更时触发，回调接收包含修改后键值对的result对象及*args。 |
| ---           |                                                                                                                                                                                               |

**使用示例**

```python
def callback(result, *args):
    print("Received data: %r", result)


sub_id = client.subscribe_to_all_attributes(callback)
```
{: .copy-code}

#### unsubscribe_from_attribute

终止共享属性更新的现有订阅。需传入[subscribe_to_attribute](/docs/reference/circuitpython-client-sdk/#subscribe_to_attribute)或[subscribe_to_all_attributes](/docs/reference/circuitpython-client-sdk/#subscribe_to_all_attributes)返回的`subscription_id`。取消后，相关回调在服务端变更时不再触发。

**方法语法**

`client.unsubscribe_from_attribute(subscription_id)`

**参数**

| **Arguments**   | **Description**                                                                                                                                                                                                                                                                                     |
|:----------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| subscription_id | （必填）通过subscribe_to_attribute或subscribe_to_all_attributes订阅时返回的订阅ID。         |
| ---             |                                                                                                                                                                                                                                                                                                     |

**使用示例**

```python
# Subscribing to attribute updates
def callback(result, *args):
    print("Received data: %r", result)


sub_id = client.subscribe_to_attribute("frequency", callback)
# Unsubscribing from attribute updates
client.unsubscribe_from_attribute(sub_id)
```
{: .copy-code}

#### set_server_side_rpc_request_handler

配置处理ThingsBoard发起的[远程过程调用](/docs/user-guide/rpc/)请求的处理器。应在建立连接后调用。收到请求时，SDK执行指定处理器并传入：

- `request_id` - RPC请求的唯一标识符，用于发送响应。
- `request_body` - 包含命令详情的字典，通常含方法名和 params。

**方法语法**

`client.set_server_side_rpc_request_handler(handler)`

**参数**

| **Arguments** | **Description**                                                                                                                                                                                                         |
|:--------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| handler       | 定义 ThingsBoard 发起远程命令时执行的逻辑，函数接收 request_id 和 request_body 两个参数。 |
| ---           |                                                                                                                                                                                                                         |

**使用示例**

```python
def handler(request_id, request_body):
    print("Received RPC request with ID: %s and body: %r", request_id, request_body)


client.set_server_side_rpc_request_handler(handler)
```
{: .copy-code}

#### send_rpc_reply

Responds to an incoming RPC request from ThingsBoard. Use this method inside your RPC handler to return data to the 
server. It requires the `request_id` from the initial request and a `response` object containing the result. Failing to 
call this method may result in `request timeout` errors on the ThingsBoard dashboard.

**Method Syntax**

`client.send_rpc_reply(request_id, response)`

**Arguments**

| **Arguments** | **Description**                                                                 |
|:--------------|:--------------------------------------------------------------------------------|
| request_id    | (Required) ID of the received RPC request that will be used to send a reply to. |
| response      | (Required) Data that will be sent as a reply to the received RPC.               |
| ---           |                                                                                 |

**使用示例**

```python
def handler(request_id, request_body):
    print("Received RPC request with ID: %s and body: %r", request_id, request_body)
    client.send_rpc_reply(request_id, {"status": "success"})


client.set_server_side_rpc_request_handler(handler)
```
{: .copy-code}

#### send_rpc_reply

Responds to an incoming RPC request from ThingsBoard. Use this method inside your RPC handler to return data to the 
server. It requires the `request_id` from the initial request and a `response` object containing the result. Failing to 
call this method may result in `request timeout` errors on the ThingsBoard dashboard.

**Method Syntax**

`client.send_rpc_reply(request_id, response)`

**Arguments**

| **Arguments** | **Description**                                                                 |
|:--------------|:--------------------------------------------------------------------------------|
| request_id    | (Required) ID of the received RPC request that will be used to send a reply to. |
| response      | (Required) Data that will be sent as a reply to the received RPC.               |
| ---           |                                                                                 |

**使用示例**

```python
def handler(request_id, request_body):
    print("Received RPC request with ID: %s and body: %r", request_id, request_body)
    client.send_rpc_reply(request_id, {"status": "success"})


client.set_server_side_rpc_request_handler(handler)
```
{: .copy-code}

### Concepts

#### Introduction

In this section, we’ll cover the core concepts of the CircuitPython Client SDK:

- Connecting your device to ThingsBoard over MQTT.
- The non-blocking loop.
- Telemetry, attributes and data flow.
- Attributes requests.
- Attributes updates.
- Handling server-side RPC.

Let's review these concepts of the CircuitPython Client SDK:

#### 连接ThingsBoard

使用CircuitPython Client SDK连接ThingsBoard时，实例化`TBDeviceMqttClient`并传入服务器凭证：host、port和access token。初始化后调用[connect()](/docs/reference/circuitpython-client-sdk/#connect)建立MQTT会话。连接成功后即可发送遥测或订阅更新。推荐使用以下最小代码：

```python
import time

import wifi  # CircuitPython Wi-Fi module

from tb_device_mqtt import TBDeviceMqttClient  # ThingsBoard MQTT client wrapper (your SDK)

# Quick sanity-check that Wi-Fi is up before using MQTT
print("WiFi connected:", wifi.radio.connected)
print("IP:", wifi.radio.ipv4_address)

# ThingsBoard connection settings
HOST = "YOUR_HOST"  # e.g. "thingsboard.cloud" or "192.168.1.10"
PORT = "YOUR_PORT"  # e.g. 1883 (use an int)
TOKEN = "YOUR_ACCESS_TOKEN"  # device access token from ThingsBoard

# Create MQTT client instance
client = TBDeviceMqttClient(host=HOST, port=PORT, access_token=TOKEN)
print("Connecting...")
client.connect()  # open MQTT connection to ThingsBoard
time.sleep(1)  # small delay to ensure connection stabilizes on some boards

while True:
# some tasks with ThingsBoard
```
{: .copy-code}

与ThingsBoard通信前，请确保设备已接入网络。上述代码假设Wi-Fi已连接。
Wi-Fi连接方法详见[CircuitPython网络](https://learn.adafruit.com/networking-in-circuitpython/networking-with-the-wifi-module)。

- 首先确认Wi-Fi已连接并打印设备IP，MQTT客户端需要有效网络连接才能与ThingsBoard通信。
- `TBDeviceMqttClient`是主类，需要ThingsBoard host和在设备页面生成的唯一Access Token。
- 使用这些连接设置创建MQTT客户端实例，SDK据此确定连接地址和设备标识。
- 调用client.connect()后，可加短暂延迟，使部分板卡的连接更稳定。

#### 非阻塞循环

SDK实现中最关键的是主循环。在CircuitPython中，`time.sleep()`在等待事件时可降低CPU占用，但会阻塞代码。
要让设备持续处理传入的MQTT消息，需定期轮询客户端。

`client.check_for_msg()`是通信的“心跳”：

- 检查MQTT缓冲区中的传入消息。
- 处理收到的消息并触发相应回调（如RPC请求或属性更新）。

#### 遥测、属性与数据流

SDK提供向ThingsBoard发送遥测的方法，可使用[send_telemetry()](/docs/reference/circuitpython-client-sdk/#send_telemetry)以键值对、列表等格式发送。SDK也支持按时间戳分组发送，便于发送历史数据。

```python
# Main loop (non-blocking)
while True:
    # Non-blocking: poll for incoming MQTT packets, then continue doing other work
    client.check_for_msg()
    client.send_telemetry({"CPU": 12.0})
    client.send_attributes({"status": "ok"})
    time.sleep(0.05)  # small delay to prevent overwhelming the CPU and allow other tasks to run
```
{: .copy-code}

将其置于主循环后，设备将持续上报状态。采用非阻塞方式，设备可同时发送遥测和接收RPC命令，互不阻塞。

#### 属性请求

SDK提供操作ThingsBoard设备属性的方法，可使用[request_attributes()](/docs/reference/circuitpython-client-sdk/#request_attributes)按键请求客户端和/或共享属性。
ThingsBoard响应后，SDK会调用回调并传入收到数据（或错误）。

```python
TIMEOUT = 20  # how long we keep pumping MQTT loop (seconds)


def on_attributes_change(result, exception=None):
    # Callback is called when the attributes response arrives
    if exception is not None:
        print("Exception:", exception)
    else:
        print("Attributes response:", result)


# Request client/shared attributes by keys (your SDK forms attributes/request/<id>)
client.request_attributes(client_keys=["atr1", "atr2"], callback=on_attributes_change)

# IMPORTANT: CircuitPython needs a loop to receive/process MQTT packets
deadline = time.monotonic() + TIMEOUT
while time.monotonic() < deadline:
    client.check_for_msg()  # wraps MiniMQTT.loop() -> triggers callbacks
    time.sleep(0.05)  # small sleep to reduce CPU usagesks to run
```
{: .copy-code}

在主循环中加入轮询逻辑，设备可保持响应：既能请求/接收属性，又能处理其他MQTT事件（如RPC调用）而不阻塞整个应用。

- 定义回调`on_attributes_change`，在收到属性响应时触发。
- 对指定键（"atr1"、"atr2"）发起属性请求，SDK发布请求并等待ThingsBoard响应。
- 使用`time.monotonic()`控制循环在`TIMEOUT`内运行，若未收到响应不会无限等待。

#### 属性更新

SDK提供订阅属性更新的方法，可使用[subscribe_to_attribute()](/docs/reference/circuitpython-client-sdk/#subscribe_to_attribute)按键订阅客户端和/或共享属性的更新。
ThingsBoard发布该属性更新时，SDK将调用回调并传入收到的数据（或错误）。

```python
TIMEOUT = 20  # how long we keep pumping MQTT loop (seconds)


def callback(result, *args):  # noqa: F841
    # Called when subscribed attribute update arrives
    # (extra args may contain metadata depending on your SDK design)
    print("Received data:", result)


# Subscribe to updates of a single attribute key (e.g. shared attribute "frequency")
sub_id = client.subscribe_to_attribute("frequency", callback)  # returns subscription id (optional)

# IMPORTANT: keep looping so incoming MQTT messages are processed
deadline = time.monotonic() + TIMEOUT
while time.monotonic() < deadline:
    client.check_for_msg()  # wraps MiniMQTT.loop() -> triggers callbacks
    time.sleep(0.05)  # small sleep to reduce CPU usage
```
{: .copy-code}

在主循环中加入轮询逻辑，设备可保持响应：既能请求/接收属性，又能处理其他MQTT事件（如RPC调用）而不阻塞整个应用。

- 定义回调`callback`，每次收到订阅属性更新时触发。
- 订阅单个属性键（如共享属性"frequency"）的更新，方法可能返回后续用于管理订阅的subscription id。
- 使用`time.monotonic()`限制循环在`TIMEOUT`内运行，示例不会无限执行。

#### 处理服务端RPC

[远程过程调用](/docs/user-guide/rpc/)允许ThingsBoard向设备发送命令（如“打开LED”或“重置”）。要处理这些命令，需通过[set_server_side_rpc_request_handler](/docs/reference/circuitpython-client-sdk/#set_server_side_rpc_request_handler)设置处理器。收到服务端RPC请求时，该处理器会被调用，并传入`request_id`和`request_body`（分别对应请求ID和请求数据）。

```python
# This callback will be called when an RPC request is received from ThingsBoard.
def on_server_side_rpc_request(request_id, request_body):
    # request_id: numeric id from the MQTT topic
    # request_body: decoded JSON dict, typically {"method": "...", "params": ...}
    print("[RPC] id:", request_id, "body:", request_body)

    client.send_rpc_reply(request_id, "ok")


client.set_server_side_rpc_request_handler(on_server_side_rpc_request)

while True:
    # Non-blocking: poll for incoming MQTT packets
    client.check_for_msg()
    time.sleep(0.1)  # small delay to avoid busy-waiting (adjust as need)
```
{: .copy-code}

SDK不会“等待”命令，而是通过回调`on_server_side_rpc_request`处理：

- 使用[set_server_side_rpc_request_handler()](/docs/reference/circuitpython-client-sdk/#set_server_side_rpc_request_handler)指定收到RPC时执行的函数。
- 收到RPC时，SDK自动将`request_id`（用于回复）和`request_body`传入处理器。
- [send_rpc_reply()](/docs/reference/circuitpython-client-sdk/#send_rpc_reply)告知服务器RPC已收到并处理成功。

### 示例

更多CircuitPython Client SDK使用示例见GitHub上[thingsboard-circuitpython-client-sdk](https://github.com/thingsboard/CircuitPython_thingsboard-client-sdk)仓库的[examples](https://github.com/thingsboard/CircuitPython_thingsboard-client-sdk/tree/main/examples)目录。

### 故障排除

- **内存不足、SDK不稳定**

  常见于板子CircuitPython可用RAM有限，或应用及其依赖占用内存过多。
  可尝试减少代码内存占用（如避免大块分配、精简import）。建议阅读[CircuitPython内存优化](https://github.com/kmatch98/CircuitPython_memory_saving)指南。

- **circup安装错误**

  部分板子在使用USB/串口工作流时`circup install`可能失败。此时可改用[Web-Workflow](https://adafruit-playground.com/u/tyeth/pages/using-circup-with-web-workflow)安装库。
  该方法通过指定设备IP（host）和Web Workflow密码，直接在网络上目标设备安装，常可解决上传/权限问题。

  ```bash
  circup --host <your_device_ip> --password <your_password> install thingsboard-circuitpython-client-sdk
  ```
  {: .copy-code}
  