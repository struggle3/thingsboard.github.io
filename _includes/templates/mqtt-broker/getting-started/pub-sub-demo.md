##### 订阅 topic

要订阅 **sensors/temperature** topic 并开始接收消息，请使用以下命令：

```bash
mosquitto_sub -d -h demo.tbmq.io -p 1883 -t sensors/temperature -q 1 -u demo
```
{: .copy-code}

连接成功后，可通过进入 _Sessions_ 页面在 UI 中查看会话信息。

如已注册演示账户，请登录 [demo.tbmq.io](https://demo.tbmq.io){:target="_blank"} 并进入 _Sessions_ 页面查看所有活动会话，包括您新创建的会话。

##### 发布消息

要向 **sensors/temperature** topic 发布消息，请使用以下命令：

```bash
mosquitto_pub -d -h demo.tbmq.io -p 1883 -t sensors/temperature -m 32 -q 1 -u demo
```
{: .copy-code}
