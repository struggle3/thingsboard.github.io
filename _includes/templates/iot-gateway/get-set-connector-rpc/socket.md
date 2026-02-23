### SET 方法

使用 SET 方法可向 socket 发送数据。

```bash
set address=<address>;port=<port>;value=<value>;
```

其中：
- `<address>` - socket 地址；
- `<port>` - socket 端口；
- `<value>` - 要发送的值。

例如，本示例中可向使用 TCP 连接并在 50003 端口监听的传感器发送房间光照度。
要向传感器发送房间光照度值，请运行以下查询：

```bash
set address=192.168.0.200;port=50003;value=80;
```

**响应：**

```json
{"result":  "ok"}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/socket-get-set-rpc-1.png)
{: refdef}

下面查看传感器端的结果：

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/socket-get-set-rpc-2.jpeg)
{: refdef}
