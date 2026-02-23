向运行在 localhost（127.0.0.1）上的 UDP 服务器发送消息的命令如下：

```shell
echo -e -n '534e2d30303164656661756c7432352e373639' | xxd -r -p | nc -w5 -u 127.0.0.1 11560
```
{: .copy-code}

![image](/images/user-guide/integrations/udp/terminal-hex.png)