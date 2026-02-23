向运行在 localhost（127.0.0.1）上的 TCP 服务器发送消息的命令如下：

```shell
echo -e -n '{"deviceName": "SN-002", "deviceType": "default", "temperature": 25.7, "humidity": 69}' | nc -q1 -w1 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-json-uplink-message-1.png)

{% unless page.docsPrefix == "pe/edge/" %}

若要通过 **Downlink** 向设备回发消息，命令如下：

```shell
echo -e -n '{"deviceName": "SN-002", "deviceType": "default", "temperature": 25.7, "humidity": 69}' | nc -w60 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-json-downlink-message-1.png)

{% endunless %}