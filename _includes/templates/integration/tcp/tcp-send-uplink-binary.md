向运行在 localhost（127.0.0.1）上的 TCP 服务器发送消息的命令如下：

```shell
echo -e -n '\x30\x30\x30\x30\x11\x53\x4e\x2d\x30\x30\x32\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x00\x00\x00' | nc -q1 -w1 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-binary-uplink-message-1.png)

{% unless page.docsPrefix == "pe/edge/" %}

若要通过 **Downlink** 向设备回发消息，命令如下：

```shell
echo -e -n '\x30\x30\x30\x30\x11\x53\x4e\x2d\x30\x30\x32\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x00\x00\x00' | nc -w60 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-binary-downlink-message-1.png)

{% endunless %}