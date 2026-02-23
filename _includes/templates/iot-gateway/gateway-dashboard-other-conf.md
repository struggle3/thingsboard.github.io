Other（其他）- 在此标签页可配置附加网关参数：
- Checking device activity（检查设备活动）- 启用对各连接设备活动的监控：
  - Inactivity timeout（无活动超时，秒）- 设备无活动多久后网关将断开该设备。
  - Inactivity check period（无活动检查周期，秒）- 设备活动检查的周期。
- Advanced（高级）- 附加网关设置：
  - Min pack send delay（最小包发送延迟，毫秒）- 发送数据包之间的延迟（降低此值会增加 CPU 占用）。
  - QoS - MQTT 消息的服务质量（0 - 最多一次，1 - 至少一次）。
  - Check connectors' configuration（检查 Connector 配置，秒）- 检查 connector 配置是否有更改的周期。
  - Max payload size in bytes（最大 payload 大小，字节）- 定义网关一次可处理的最大消息，确保性能稳定并避免超大数据引发错误。
  - Min packet size to send（最小发送包大小）- 定义网关将传输的最小消息大小，避免发送过小或不完整的数据包。

![](/images/gateway/dashboard/gateway-dashboard-other-conf.png)
