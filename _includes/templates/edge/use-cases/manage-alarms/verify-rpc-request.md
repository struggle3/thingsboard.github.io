打开运行 **mqtt-js.sh** 脚本的终端。
您应看到类似以下输出：

```shell
pc@pc-XPS-15-9550:~/alarm-tutorial$ bash mqtt-js.sh
Connecting to: localhost:1883 using access token: sFqoF18PTyViO8L0qo7c
Cooler is connected!
Received RPC command from edge!
Method: enabled_air_conditioner
Speed params: 1
```

恭喜！RPC 请求已基于 **DHT22** 传感器的温度读数成功发送至 **空调** 设备。
