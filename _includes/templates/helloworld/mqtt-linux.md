在 **Ubuntu** 上安装 MQTT 客户端：

```bash
sudo apt-get install mosquitto-clients
```
{: .copy-code}

在 **macOS** 上安装 MQTT 客户端：

```bash
brew install mosquitto-clients
```
{: .copy-code}


Replace$THINGSBOARD_HOST_NAMEand$ACCESS_TOKENwith corresponding values.

```bash
mosquitto_pub -d -q 1 -h "$THINGSBOARD_HOST_NAME" -p "1883" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 为 ThingsBoard Cloud（北美），$ACCESS_TOKEN 为 ABC123：

```bash
mosquitto_pub -d -q 1 -h "mqtt.thingsboard.cloud" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 为 ThingsBoard Cloud（欧洲），$ACCESS_TOKEN 为 ABC123：

```bash
mosquitto_pub -d -q 1 -h "mqtt.eu.thingsboard.cloud" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}


例如，$THINGSBOARD_HOST_NAME 为本地部署，$ACCESS_TOKEN 为 ABC123：

```bash
mosquitto_pub -d -q 1 -h "localhost" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

Successful output should look similar to this one:

```text
Client mosqpub|xxx sending CONNECT
Client mosqpub|xxx received CONNACK
Client mosqpub|xxx sending PUBLISH (d0, q1, r0, m1, 'v1/devices/me/telemetry', ... (16 bytes))
Client mosqpub|xxx received PUBACK (Mid: 1)
Client mosqpub|xxx sending DISCONNECT
```

{% capture difference %}
**注意：** 自 ThingsBoard 3.2 起，可使用基本 MQTT 凭据（client id、username 和 password 组合），并通过设备配置集自定义 **topic 名称**和 **payload 类型**。详见[此处](/docs/user-guide/device-profiles/#mqtt-transport-type)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}