### 监控ThingsBoard Java应用

我们将使用[Visual VM](https://visualvm.github.io/)监控ThingsBoard应用。
`docker-compose.yml`中已通过以下配置启用JMX：

```bash
JAVA_OPTS: " -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.rmi.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1"
```

将JMX端口从ThingsBoard实例**转发**到本地机器：

```bash
ssh -L 9999:127.0.0.1:9999 thingsboard 
```

现在可使用VisualVM连接ThingsBoard应用并查看内部状态

![Thingsboard JMX overview with VisualVM](/images/reference/performance-aws-instances/method/chart-examples/performance_test_thingsboard_jmx_visual_vm_overview.png "Thingsboard JMX overview with VisualVM")

