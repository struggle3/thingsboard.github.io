在**Ubuntu**上安装MQTT客户端：

```bash
sudo apt-get install mosquitto-clients
```
{: .copy-code}

在**macOS**上安装：

```bash
brew install mosquitto-clients
```
{: .copy-code}


请将$HOST_NAME、$MQTT_PORT和$ACCESS_TOKEN替换为对应值。

```bash
mosquitto_pub -d -q 1 -h "$HOST_NAME" -p "$MQTT_PORT" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}


例如，$HOST_NAME指向您本地的ThingsBoard Edge安装，MQTT端口为**1883**，访问令牌为**ABC123**：

```bash
mosquitto_pub -d -q 1 -h "localhost" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

成功输出应类似以下内容：

```text
Client mosqpub|xxx sending CONNECT
Client mosqpub|xxx received CONNACK
Client mosqpub|xxx sending PUBLISH (d0, q1, r0, m1, 'v1/devices/me/telemetry', ... (16 bytes))
Client mosqpub|xxx received PUBACK (Mid: 1)
Client mosqpub|xxx sending DISCONNECT
```

**注意：** 自ThingsBoard 3.2起，您可以使用基本MQTT凭据（client id、user name和password组合），并通过Device Profile自定义**主题名称**和**载荷类型**。更多信息请参阅 [此处](/docs/user-guide/device-profiles/#mqtt-transport-type)。

<br>
