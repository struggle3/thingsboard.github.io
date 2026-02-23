* TOC
{:toc}

### 概述

[MicroPython Client SDK](https://github.com/thingsboard/thingsboard-micropython-client-sdk)是用于MicroPython项目客户端集成的软件开发套件。允许您使用MQTT协议将MicroPython设备连接到ThingsBoard，发送遥测数据、属性并接收RPC调用。SDK提供简洁易用的API，便于开发者将MicroPython设备与平台集成。

MicroPython Client SDK支持以下功能：

- 使用MQTT协议连接ThingsBoard。
- 向ThingsBoard发送属性。
- 向ThingsBoard发送遥测数据。
- 从ThingsBoard接收RPC调用。
- 从ThingsBoard请求客户端和共享属性。
- 订阅ThingsBoard的属性更新。
- 设备认领。
- 设备预配置。

### 安装

要安装MicroPython Client SDK，可使用[mip](https://docs.micropython.org/en/latest/reference/packages.html)包管理器。在REPL或代码中运行以下命令：

```python
import mip

mip.install('github:thingsboard/thingsboard-micropython-client-sdk')
```
{: .copy-code}

建议使用以下代码片段，以确保SDK正确安装和导入，并避免每次运行代码时重复安装：

```python
try:
    from thingsboard_sdk.tb_device_mqtt import TBDeviceMqttClient

    print("thingsboard-micropython-client-sdk package already installed.")
except ImportError:
    print("Installing thingsboard-micropython-client-sdk package...")
    mip.install('github:thingsboard/thingsboard-micropython-client-sdk')
    from thingsboard_sdk.tb_device_mqtt import TBDeviceMqttClient
```
{: .copy-code}

### 方法

#### 简介

MicroPython Client SDK提供`TBDeviceMqttClient`类，用于连接ThingsBoard并发送数据。

该类设计简洁，便于MicroPython或ThingsBoard新手使用。

#### connect

使用MQTT协议连接ThingsBoard。在向ThingsBoard发送任何数据前需调用此方法。
创建`TBDeviceMqttClient`实例时需提供连接凭证。调用`connect`后，客户端的`self.connected`将设为`True`。

**方法语法**

`client.connect(timeout=10)`

**参数**

| **Arguments** | **Default value** | **Description**                                           |
|:--------------|-------------------|:----------------------------------------------------------|
| timeout       | **10**            | （可选）建立与ThingsBoard连接的超时时间。 |
| ---           |                   |                                                           |

**使用示例**

```python
# Default connecting
client.connect()

# Connecting with custom timeout
client.connect(timeout=20)

# Connecting with waiting for connection result
result = client.connect(timeout=20)
```
{: .copy-code}

#### disconnect

断开与ThingsBoard的连接。连接后即可调用。建议在不再需要发送数据或需释放资源时调用。
调用后需再次调用[connect](/docs/reference/micropython-client-sdk/#connect)才能发送数据。调用`disconnect`后，`self.connected`将设为`False`。

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

向ThingsBoard发送属性。连接后即可调用。支持以键值对形式发送。

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

向ThingsBoard发送遥测数据。连接后即可调用。支持以键值对、列表等格式发送。也支持按时间戳分组，便于发送历史数据。

**方法语法**

`client.send_telemetry(data)`

**Arguments**

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

Requests client and shared attributes from ThingsBoard. This method can be called after connecting to ThingsBoard.
Method supports requesting both client and shared attributes. You can specify which attributes you want to request by 
providing a list of attribute keys. If requested attributes are received from ThingsBoard, the provided callback 
function will be called with the result. If requested attributes are not found on ThingsBoard, the callback function 
will be called with empty result.

**Method Syntax**

`client.request_attributes(client_keys=None, shared_keys=None, callback=None)`

**Arguments**

| **Arguments** | **Description**                                                                                                                                                                                                                                                       |
|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| client_keys   | (Optional) List of client attribute keys to request from ThingsBoard.                                                                                                                                                                                                 |
| shared_keys   | (Optional) List of shared attribute keys to request from ThingsBoard.                                                                                                                                                                                                 |
| callback      | (Optional) Callback function that will be called when the requested attributes are received from ThingsBoard. The callback function should accept two arguments: `result` and `exception`, which will contain the requested attributes.                               |
| ---           |                                                                                                                                                                                                                                                                       |

**使用示例**

```python
def on_attributes_change(result, exception=None):
    # This is a callback function that will be called when client receive the response from the server
    if exception is not None:
        print("Exception: " + str(exception))
    else:
        print(result)


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
| secret_key    | (Required) Secret key that will be used to claim the device on ThingsBoard.                                                                                                |
| duration_ms   | (Optional) Duration in milliseconds for which the claim code will be valid. If not provided, the claim code will be valid indefinitely until it is used to claim a device. |
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

Subscribes to attribute updates from ThingsBoard. You can specify which shared attribute you want to subscribe to by 
providing an attribute key. If subscribed attribute value is updated, the provided callback function will be 
called with the corresponding attribute value.

Method will return a subscription ID that can be used to unsubscribe from attribute updates using 
the [unsubscribe_from_attribute](/docs/reference/micropython-client-sdk/#unsubscribe_from_attribute) method.

**Method Syntax**

`client.subscribe_to_attribute(key, callback)`

**Arguments**

| **Arguments** | **Description**                                                                                                                                                                                                        |
|:--------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| key           | (Required) Shared attribute key to subscribe to for updates from ThingsBoard.                                                                                                                                          |
| callback      | (Required) A user-defined function triggered whenever a subscribed attribute is updated on ThingsBoard. The callback must accept two parameters: result (the updated data dictionary) and *args (additional metadata). |
| ---           |                                                                                                                                                                                                                        |

**使用示例**

```python
def callback(result, *args):
    print("Received data: %r", result)


sub_id = client.subscribe_to_attribute("frequency", callback)
```
{: .copy-code}

#### subscribe_to_all_attributes

Subscribes to all shared attribute updates from ThingsBoard. Whenever any shared attribute is modified on the server, 
the SDK triggers the designated callback function, passing the updated data as the result.

Method will return a subscription ID that can be used to unsubscribe from attribute updates using 
the [unsubscribe_from_attribute](/docs/reference/micropython-client-sdk/#unsubscribe_from_attribute) method.

**Method Syntax**

`client.subscribe_to_all_attributes(callback)`

**Arguments**

| **Arguments** | **Description**                                                                                                                                                                               |
|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| callback      | (Required) Triggers when any shared attribute change is pushed from the server. The callback receives a result object containing the modified key-value pairs and *args for extended context. |
| ---           |                                                                                                                                                                                               |

**使用示例**

```python
def callback(result, *args):
    print("Received data: %r", result)


sub_id = client.subscribe_to_all_attributes(callback)
```
{: .copy-code}

#### unsubscribe_from_attribute

Terminates an existing subscription for shared attribute updates. This method requires the `subscription_id` returned 
by the original call to [subscribe_to_attribute](/docs/reference/micropython-client-sdk/#subscribe_to_attribute) or 
[subscribe_to_all_attributes](/docs/reference/micropython-client-sdk/#subscribe_to_all_attributes). Once unsubscribed, 
the associated callback will no longer trigger upon server-side changes.

**Method Syntax**

`client.unsubscribe_from_attribute(subscription_id)`

**Arguments**

| **Arguments**   | **Description**                                                                                                                                                                                                                                                                                     |
|:----------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| subscription_id | (Required) Subscription ID returned when subscribing to attribute updates using the [subscribe_to_attribute](/docs/reference/micropython-client-sdk/#subscribe_to_attribute) or [subscribe_to_all_attributes](/docs/reference/micropython-client-sdk/#subscribe_to_all_attributes) methods.         |
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

Configures a handler for [Remote Procedure Call](/docs/user-guide/rpc/) requests initiated from ThingsBoard. This 
method should be invoked after establishing a connection. When a request is received, the SDK executes the designated 
handler, passing the following arguments:

- `request_id` - a unique identifier for the specific RPC request, required for sending a response.
- `request_body` - a dictionary containing the command details, typically including the method name and params.

**Method Syntax**

`client.set_server_side_rpc_request_handler(handler)`

**Arguments**

| **Arguments** | **Description**                                                                                                                                                                                                         |
|:--------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| handler       | Defines the logic to execute when ThingsBoard initiates a remote command. The function receives two parameters: request_id, representing the transaction ID, and request_body, containing the specific request payload. |
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

#### get_provision_request

Static method that forms a request for [device provisioning](/docs/user-guide/device-provisioning/) by input arguments. 
The returned provision request should be sent to ThingsBoard using the 
[provision](/docs/reference/micropython-client-sdk/#provision) method.

**Method Syntax**

`TBDeviceMqttClient.get_provision_request(provision_key, provision_secret)`

**Arguments**

| **Arguments**    | **Description**                                                                                                                                              |
|:-----------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| provision_key    | (Required) Provisioning device key, you should take it from configured device profile.                                                                       |
| provision_secret | (Required) Provisioning device secret, you should take it from configured device profile.                                                                    |
| device_name      | (Optional) Device name in ThingsBoard.                                                                                                                       |
| access_token     | (Optional) Access token for device in ThingsBoard.                                                                                                           |
| client_id        | (Optional) Client id for device in ThingsBoard.                                                                                                              |
| username         | (Optional) Username for device in ThingsBoard.                                                                                                               |
| password         | (Optional) Password for device in ThingsBoard.                                                                                                               |
| hash             | (Optional) Public key X509 hash for device in ThingsBoard.                                                                                                   |
| gateway          | (Optional) Flag that indicates whether the provision request is for a gateway device. If not provided, the provision request will be for a regular device.   |
| ---              |                                                                                                                                                              |

**使用示例**

```python
# Forming provision request with required arguments
provision_request = TBDeviceMqttClient.get_provision_request("my_provision_key", "my_provision_secret")

# Forming provision request with specified device name
provision_request = TBDeviceMqttClient.get_provision_request("my_provision_key", "my_provision_secret", device_name="My Device")

# Forming provision request with specified access token
provision_request = TBDeviceMqttClient.get_provision_request("my_provision_key", "my_provision_secret", access_token="my_access_token")

# Forming provision request with specified client ID, username, and password
provision_request = TBDeviceMqttClient.get_provision_request("my_provision_key", "my_provision_secret", client_id="my_client_id", username="my_username", password="my_password")

# Forming provision request for a gateway device
provision_request = TBDeviceMqttClient.get_provision_request("my_provision_key", "my_provision_secret", gateway=True)
```
{: .copy-code}

#### provision

Sends a request to ThingsBoard for [device provisioning](/docs/user-guide/device-provisioning/). 
The argument of the method should be the provision request that is formed using the 
[get_provision_request](/docs/reference/micropython-client-sdk/#get_provision_request) static method. If the request 
is successful, the device will be provisioned on ThingsBoard and associated with the account that owns the 
provision key and provision secret. If the request is not successful, an exception will be raised.

**Method Syntax**

`client.provision(host, port, provision_request)`

**Arguments**

| **Arguments**     | **Description**                                                                                                                                                      |
|:------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| host              | (Required) Host of the ThingsBoard server.                                                                                                                           |
| port              | (Required) Port of the ThingsBoard server.                                                                                                                           |
| provision_request | (Required) Request that will be sent to ThingsBoard for device provisioning. The provision request should be formed using the `get_provision_request` static method. |
| ---               |                                                                                                                                                                      |

**使用示例**

```python
# Forming provision request
provision_request = TBDeviceMqttClient.get_provision_request("my_provision_key", "my_provision_secret")
# Sending provision request to ThingsBoard for device provisioning
provisioned_credentials = client.provision("thingsboard.cloud", 1883, provision_request)
```
{: .copy-code}

### 概念

#### 简介

本节介绍MicroPython Client SDK的核心概念，如连接ThingsBoard、发送和接收数据。理解这些概念有助于在项目中有效使用SDK。

Let's review the main concepts of the MicroPython Client SDK using the following code example:

```python
import time
import network
from thingsboard_sdk.tb_device_mqtt import TBDeviceMqttClient

# Enabling WLAN interface
wlan = network.WLAN(network.STA_IF)
wlan.active(True)

# Establishing connection to the Wi-Fi
if not wlan.isconnected():
    print("Connecting to network...")
    wlan.connect("WIFI_SSID", "WIFI_PASSWORD")
    while not wlan.isconnected():
        pass

print("Connected! Network config:", wlan.ifconfig())


# This callback will be called when an RPC request is received from ThingsBoard.
def on_server_side_rpc_request(request_id, request_body):
    # request_id: numeric id from the MQTT topic
    # request_body: decoded JSON dict, typically {"method": "...", "params": ...}
    print("[RPC] id:", request_id, "body:", request_body)

    client.send_rpc_reply(request_id, "ok")


# Initialising client to communicate with ThingsBoard
client = TBDeviceMqttClient("THINGSBOARD_HOST", port=1883, access_token="ACCESS_TOKEN")
# Register the server-side RPC callback before the main loop
client.set_server_side_rpc_request_handler(on_server_side_rpc_request)
# Connect to ThingsBoard
client.connect()


def safe_check_msg():
    """
    Non-blocking MQTT poll.
    """
    try:
        # non-blocking check
        client.check_for_msg()
        return True
    except OSError as e:
        print("[MQTT] check_msg OSError:", e)
    except Exception as e:
        print("[MQTT] check_msg error:", e)
    return False


# Main loop (non-blocking)
while True:
    # Non-blocking: poll for incoming MQTT packets, then continue doing other work
    safe_check_msg()
    client.send_telemetry({"CPU": 12.0})
    time.sleep_ms(50)
```
{:.copy-code.expandable-15}

#### 连接ThingsBoard

使用MicroPython Client SDK连接ThingsBoard时，实例化`TBDeviceMqttClient`并传入host、port和access token。初始化后调用[connect()](/docs/reference/micropython-client-sdk/#connect)建立MQTT会话。连接成功后即可发送遥测或订阅更新。推荐使用以下最小代码：

```python
import network
from thingsboard_sdk.tb_device_mqtt import TBDeviceMqttClient

wlan = network.WLAN(network.STA_IF)
wlan.active(True)

# Establishing connection to the Wi-Fi
if not wlan.isconnected():
    print('Connecting to network...')
    wlan.connect("YOUR_SSID", "YOUR_PASSWORD")
    while not wlan.isconnected():
        pass

print('Connected! Network config:', wlan.ifconfig())

client = TBDeviceMqttClient(host="thingsboard.cloud", port=1883, access_token="YOUR_ACCESS_TOKEN")
client.connect()

while True:
    # some tasks with ThingsBoard
```
{: .copy-code}

与ThingsBoard通信前，设备需先建立网络连接：

- 网络模块初始化Wi-Fi实例，使用STA_IF（站点接口）连接至现有接入点。
- `TBDeviceMqttClient`是主类，需要ThingsBoard host和在设备页面生成的唯一Access Token。

#### 处理服务端RPC

[远程过程调用](/docs/user-guide/rpc/)允许ThingsBoard向设备发送命令（如“打开LED”或“重置”）。要处理这些命令，需通过[set_server_side_rpc_request_handler](/docs/reference/micropython-client-sdk/#set_server_side_rpc_request_handler)设置处理器。收到服务端RPC请求时该处理器会被调用，函数应接受`request_id`和`request_body`，分别对应请求ID和请求数据。

```python
# This callback will be called when an RPC request is received from ThingsBoard.
def on_server_side_rpc_request(request_id, request_body):
    # request_id: numeric id from the MQTT topic
    # request_body: decoded JSON dict, typically {"method": "...", "params": ...}
    print("[RPC] id:", request_id, "body:", request_body)

    client.send_rpc_reply(request_id, "ok")

client.set_server_side_rpc_request_handler(on_server_side_rpc_request)
```
{: .copy-code}

SDK不会“等待”命令，而是通过回调`on_server_side_rpc_request`处理：

- 使用[set_server_side_rpc_request_handler()](/docs/reference/micropython-client-sdk/#set_server_side_rpc_request_handler)指定收到RPC时执行的函数。
- 收到RPC时，SDK自动将`request_id`和`request_body`传入处理器。
- [send_rpc_reply()](/docs/reference/micropython-client-sdk/#send_rpc_reply)告知服务器RPC已收到并处理成功。

#### 非阻塞循环

SDK实现中最关键的是主循环。在MicroPython中，使用`time.sleep_ms()`期间设备无法处理传入消息。

`client.check_for_msg()`是通信的“心跳”：

- 检查MQTT缓冲区中的传入消息。
- 封装在`safe_check_msg()`中，确保网络中断（如`OSError`）时程序不崩溃，仅记录错误并在下一轮重试。

#### 遥测与数据流

SDK提供向ThingsBoard发送遥测的方法，可使用[send_telemetry()](/docs/reference/micropython-client-sdk/#send_telemetry)以键值对、列表等格式发送。SDK也支持按时间戳分组，便于发送历史数据。

```python
# Main loop (non-blocking)
while True:
    # Non-blocking: poll for incoming MQTT packets, then continue doing other work
    safe_check_msg()
    client.send_telemetry({"CPU": 12.0})
    time.sleep_ms(50)
```
{: .copy-code}

将其置于主循环后，设备将持续上报状态。采用非阻塞方式，设备可同时发送遥测和接收RPC命令，互不阻塞。

### 示例

更多MicroPython Client SDK使用示例见GitHub上[thingsboard-micropython-client-sdk](https://github.com/thingsboard/thingsboard-micropython-client-sdk)仓库的[examples](https://github.com/thingsboard/thingsboard-micropython-client-sdk/tree/main/examples)目录。

### 故障排除

- **Mip安装失败 OSError: -202**

  设备未联网或网络异常时可能出现此错误。请确保设备已连接互联网且网络正常。可尝试重启设备后再次运行安装命令。

  建议先建立互联网连接再执行安装命令：

    ```python
    import network
    import mip
    
    # Enabling WLAN interface
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    
    # Establishing connection to the Wi-Fi
    if not wlan.isconnected():
        print('Connecting to network...')
        wlan.connect("YOUR_WIFI_SSID", "YOUR_WIFI_PASSWORD")
        while not wlan.isconnected():
            pass
    
    mip.install('github:thingsboard/thingsboard-micropython-client-sdk')
    ```
    {: .copy-code}
