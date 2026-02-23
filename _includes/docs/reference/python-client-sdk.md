
* TOC
{:toc}

SDK支持：
- 未加密及加密（TLS v1.2）连接；
- QoS 0和1；
- 自动重连；
- 全部[**Device MQTT APIs**](/docs/{{docsPrefix}}reference/mqtt-api/)
- 全部[**Gateway MQTT APIs**](/docs/{{docsPrefix}}reference/gateway-mqtt-api/)

SDK基于Paho MQTT库。 

## 安装

使用pip安装：

```bash
pip3 install tb-mqtt-client
```
{:.copy-code}

## 快速入门

客户端初始化与遥测发布。

```python
from tb_device_mqtt import TBDeviceMqttClient, TBPublishInfo


telemetry = {"temperature": 41.9, "enabled": False, "currentFirmwareVersion": "v1.2.2"}
client = TBDeviceMqttClient("127.0.0.1", username="A1_TEST_TOKEN")
# Connect to ThingsBoard
client.connect()
# Sending telemetry without checking the delivery status
client.send_telemetry(telemetry) 
# Sending telemetry and checking the delivery status (QoS = 1 by default)
result = client.send_telemetry(telemetry)
# get is a blocking call that awaits delivery status  
success = result.get() == TBPublishInfo.TB_ERR_SUCCESS
# Disconnect from ThingsBoard
client.disconnect()

```
{:.copy-code}

### 使用TLS连接

连接至localhost的TLS。 {% unless docsPrefix contains "paas/" %}有关客户端和ThingsBoard配置的更多信息，请参阅[MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/)。{% endunless %}
要通过MQTT over SSL连接ThingsBoard，首先需生成证书，并拥有类似以下代码：

```python
from socket import gethostname
from tb_device_mqtt import TBDeviceMqttClient


client = TBDeviceMqttClient(gethostname())
client.connect(tls=True,
               ca_certs="mqttserver.pub.pem",
               cert_file="mqttclient.nopass.pem")
client.disconnect()

```
{:.copy-code}

## 使用Device APIs

**TBDeviceMqttClient**提供对ThingsBoard平台Device MQTT APIs的访问。
支持发布遥测和属性更新、订阅属性变更、发送和接收RPC命令等。    

### 订阅属性

如需接收共享属性更新，可使用类似以下代码：  

```python
from time import sleep
from tb_device_mqtt import TBDeviceMqttClient


def callback(result):
    print(result)

client = TBDeviceMqttClient("127.0.0.1", username="A1_TEST_TOKEN")
client.connect()
client.subscribe_to_attribute("uploadFrequency", callback)
client.subscribe_to_all_attributes(callback)
while True:
    sleep(1)

```
{:.copy-code}

### 遥测包发送

为向ThingsBoard发送数据，可使用类似以下代码：

```python
from time import time
from tb_device_mqtt import TBDeviceMqttClient, TBPublishInfo


telemetry_with_ts = {"ts": int(round(time() * 1000)), "values": {"temperature": 42.1, "humidity": 70}}
client = TBDeviceMqttClient("127.0.0.1", username="A1_TEST_TOKEN")
# we set maximum amount of messages sent to send them at the same time. it may stress memory but increases performance
client.max_inflight_messages_set(100)
client.connect()
results = []
result = True
for i in range(0, 100):
    results.append(client.send_telemetry(telemetry_with_ts))
for tmp_result in results:
    result &= tmp_result.get() == TBPublishInfo.TB_ERR_SUCCESS
print("Result", str(result))
client.disconnect()

```
{:.copy-code}

### 从服务器请求属性

为从ThingsBoard请求共享属性值，可使用以下示例：

```python
from time import sleep
from tb_device_mqtt import TBDeviceMqttClient


def on_attributes_change(result, exception):
    if exception is not None:
        print("Exception:", str(exception))
    else:
        print(result)

client = TBDeviceMqttClient("127.0.0.1", username="A1_TEST_TOKEN")
client.connect()
client.request_attributes(["configuration","targetFirmwareVersion"], callback=on_attributes_change)


while True:
    sleep(1)

```
{:.copy-code}

### 响应服务器RPC调用

若需对某RPC请求发送响应，可使用如下代码中的逻辑。
以下示例连接至ThingsBoard本地实例并等待RPC请求。
收到RPC请求时，客户端将向ThingsBoard发送包含来自运行客户端的机器数据的响应，设备名称为**Test Device A1**。  

```python
from psutil import cpu_percent, virtual_memory
from time import sleep
from tb_device_mqtt import TBDeviceMqttClient


# dependently of request method we send different data back
def on_server_side_rpc_request(client, request_id, request_body):
    print(request_id, request_body)
    if request_body["method"] == "getCPULoad":
        client.send_rpc_reply(request_id, {"CPU percent": cpu_percent()})
    elif request_body["method"] == "getMemoryUsage":
        client.send_rpc_reply(request_id, {"Memory": virtual_memory().percent})

client = TBDeviceMqttClient("127.0.0.1", username="A1_TEST_TOKEN")
client.set_server_side_rpc_request_handler(on_server_side_rpc_request)
client.connect()


while True:
    sleep(1)

```
{:.copy-code}

## 使用Gateway APIs

**TBGatewayMqttClient**继承**TBDeviceMqttClient**，因此可像普通设备一样访问其全部API。
此外，网关可代表与其连接的多个设备。例如，代表其他受限设备发送遥测或属性。更多网关信息见[**此处**](/docs/iot-gateway/)。  

### 遥测和属性发送 

为向ThingsBoard发送设备**Test Device A1**的数据，可使用类似以下代码：

```python
from time import time
from tb_gateway_mqtt import TBGatewayMqttClient


gateway = TBGatewayMqttClient("127.0.0.1", username="TEST_GATEWAY_TOKEN")
gateway.connect()
gateway.gw_connect_device("Test Device A1")

gateway.gw_send_telemetry("Test Device A1", {"ts": int(round(time() * 1000)), "values": {"temperature": 42.2}})
gateway.gw_send_attributes("Test Device A1", {"firmwareVersion": "2.3.1"})

gateway.gw_disconnect_device("Test Device A1")
gateway.disconnect()

```
{:.copy-code}

### 从服务器请求属性

为从ThingsBoard请求设备**Test Device A1**的共享属性值，可使用以下示例：

```python
from time import sleep
from tb_gateway_mqtt import TBGatewayMqttClient


def callback(result, exception):
    if exception is not None:
        print("Exception: " + str(exception))
    else:
        print(result)

gateway = TBGatewayMqttClient("127.0.0.1", username="TEST_GATEWAY_TOKEN")
gateway.connect()
gateway.gw_request_shared_attributes("Test Device A1", ["temperature"], callback)

while True:
    sleep(1)

```
{:.copy-code}

### 响应服务器RPC调用

若需对某RPC请求发送响应，可使用如下代码中的逻辑。
以下示例将连接至ThingsBoard本地实例并等待RPC请求。
收到RPC请求时，客户端将向ThingsBoard发送设备**Test Device A1**的响应数据。  

```python
from time import sleep
from psutil import cpu_percent, virtual_memory
from tb_gateway_mqtt import TBGatewayMqttClient


def rpc_request_response(client, request_id, request_body):
    # request body contains id, method and other parameters
    print(request_body)
    method = request_body["data"]["method"]
    device = request_body["device"]
    req_id = request_body["data"]["id"]
    # dependently of request method we send different data back
    if method == 'getCPULoad':
        gateway.gw_send_rpc_reply(device, req_id, {"CPU load": cpu_percent()})
    elif method == 'getMemoryLoad':
        gateway.gw_send_rpc_reply(device, req_id, {"Memory": virtual_memory().percent})
    else:
        print('Unknown method: ' + method)

gateway = TBGatewayMqttClient("127.0.0.1", username="TEST_GATEWAY_TOKEN")
gateway.connect()
# now rpc_request_response will process rpc requests from servers
gateway.gw_set_server_side_rpc_request_handler(rpc_request_response)
# without device connection it is impossible to get any messages
gateway.gw_connect_device("Test Device A1")

while True:
    sleep(1)

```
{:.copy-code}

## 其他示例

[device](https://github.com/thingsboard/thingsboard-python-client-sdk/tree/master/examples/device)和[gateway](https://github.com/thingsboard/thingsboard-python-client-sdk/tree/master/examples/gateway)在对应[文件夹](https://github.com/thingsboard/thingsboard-python-client-sdk/tree/master/examples)中有更多示例。
