{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}


ThingPark 集成可将 Actility ThingPark 服务器的数据流式传输到 ThingsBoard，并将二进制设备 payload 转换为 ThingsBoard 格式。

<object width="100%" style="max-width: max-content;" data="/images/user-guide/integrations/thingpark-integration.svg"></object>

配置步骤：
- 查阅 ThingPark DX Dataflow API 官方参考文档：

[文档](https://www.actility.com/thingpark-documentation-portal/)。

- 在 ThingPark Wireless OSS intelligent logger (Actility) 上完成注册及设备注册流程。

[注册与设备注册流程](https://thingparkenterprise.eu.actility.com/tpe/#/login)。

- 检查设备与 ThingPark Wireless OSS intelligent logger (Actility) 的连接和运行状态。

[检查设备连接与运行](https://thingparkenterprise.eu.actility.com/thingpark/wlogger/gui/)。

- 要在 ThingsBoard 平台与 ThingPark Wireless OSS intelligent logger (Actility) 之间创建新 Integration，请点击链接。

[创建类型为 "ThingPark" 的新 Integration](/docs/samples/abeeway/tracker)

<br>

## 下一步

 {% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
