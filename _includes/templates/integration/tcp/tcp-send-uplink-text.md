向运行在 localhost（127.0.0.1）上的 TCP 服务器发送消息的命令如下：

```shell
echo -e 'SN-002,default,temperature,25.7' | nc -q0 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-text-add-attribute-1.png)

也可在一行内发送多条消息，使用 **Message Separator**（**System Line Delimiter**）分隔。
换行符（**\n**）将用于将 payload 拆分为多条消息。

此情况下，命令如下：

```shell
echo -e 'SN-002,default,temperature,25.7\nSN-002,default,humidity,69' | nc -q1 -w1 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-text-add-attribute-2.png)

{% unless page.docsPrefix == "pe/edge/" %}

若要通过 **Downlink** 向设备回发消息，命令如下：

```shell
echo -e 'SN-002,default,temperature,25.7' | nc 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-text-downlink-message-1.png)

多消息同行的命令：

```shell
echo -e 'SN-002,default,temperature,25.7\nSN-002,default,humidity,69' | nc -w60 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-text-downlink-message-2.png)

{% endunless %}