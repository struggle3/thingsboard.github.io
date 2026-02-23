向运行在 localhost（127.0.0.1）上的 UDP 服务器发送消息的命令如下：

```shell
echo -e 'SN-001,default,temperature,25.7,humidity,69' | nc -w5 -u 127.0.0.1 11560
```
{: .copy-code}

![image](/images/user-guide/integrations/udp/terminal-text.png)