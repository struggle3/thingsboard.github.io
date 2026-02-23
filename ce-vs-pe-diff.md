# ThingsBoard社区版与专业版：有何不同

## 用ThingsBoard释放IoT潜能

ThingsBoard最初旨在帮助全球组织充分释放IoT潜力。我们以简化并加快IoT应用为愿景，致力于让各规模组织都能便捷、可扩展、灵活地使用这一技术。我们帮助企业借助先进工具优化运营、降低成本、发现新机遇。

为此，我们提供两个强大的平台版本：社区版（CE）与专业版（PE）。无论您从CE入门还是直接使用PE的进阶功能，ThingsBoard都为您提供清晰路径，助力您构建、发布并扩展IoT解决方案。


## ThingsBoard社区版（CE）：开源首选

ThingsBoard CE是全球功能最丰富的开源IoT平台，我们致力于保持这一地位。它是功能完整、可扩展、高可用的解决方案，支持集群部署并可用于商业项目。CE为构建从小型概念验证到大规模IoT解决方案提供坚实基础。


:gear: **CE功能：**

- *标准协议支持*：通过MQTT、CoAP、HTTP、SNMP和LWM2M连接设备。
- *IoT Gateway*：通过内置连接器（Modbus、OPC-UA、BACnet等）集成工业系统。
- *设备与资产管理*：使用数字孪生建模物理环境。
- *数据处理与告警*：通过规则引擎与计算字段处理数据、创建告警并触发动作。
- *数据可视化*：使用实时、交互式仪表板展示遥测数据。
- *高可扩展性*：支持数百万设备的高可用集群架构。

:pushpin: 了解更多：[Community Edition](https://thingsboard.io/docs/)

## ThingsBoard专业版（PE）：企业级功能与支持

ThingsBoard PE面向希望缩短上市时间、降低开发成本、开箱即用更多功能的企业和商业用户。PE包含社区版的全部强大功能，我们相信PE是市面上功能最丰富的商业IoT平台。我们的开发模式体现了对开源社区的支持，约80%的代码变更直接贡献给CE，而PE则额外获得面向企业的功能与专属支持。


:rocket: **PE功能：**

- *CE全部功能*。
- *高级访问控制（RBAC）*：为设备、资产和仪表板定义具有细粒度权限的自定义用户角色。
- *白标定制*：使用自有品牌定制平台。
- *平台集成*：无缝连接AWS IoT、Azure IoT Hub等云服务，以及Kafka和LoRaWAN网络服务器。
- *Device Library*：通过400+预置数据转换器简化LoRaWAN及其他设备的入网。
- *自动化报表*：自动生成并分发定时报表给客户。
- *Solution Templates*：借助预置、即用型IoT解决方案模板加速开发。
- *支持与SLA*：获得专属支持与可用性SLA保证，适用于托管云服务。


:pushpin: 了解更多：[Professional Edition](https://thingsboard.io/docs/pe/)

---

## 功能对比

| 功能类别                     | 功能                                                | 社区版 | 专业版 |
|--------------------------------------|--------------------------------------------------------|--------|--------|
| 平台核心                        | 多租户                                              | 是     | 是     |
|                                      | 可扩展性（集群）                               | 是     | 是     |
|                                      | 规则引擎与数据处理                          | 是     | 是     |
|                                      | AI Models与AI Rule节点                            | 是     | 是     |
|                                      | 终端用户实时仪表板                          | 是     | 是     |
|                                      | 移动应用                                     | 是     | 是     |
| 设备管理                    | 设备与资产建模                                | 是     | 是     |
|                                      | 设备认领与Provisioning API                     | 是     | 是     |
|                                      | 通过CSV批量配置设备与资产             | 是     | 是     |
|                                      | OTA更新                                            | 是     | 是     |
| 连接性                         | 标准IoT协议（MQTT/CoAP/HTTP/SNMP/LWM2M）     | 是     | 是     |
|                                      | 工业IoT Gateway（Modbus、OPC-UA、BACnet等）  | 是     | 是     |
|                                      | LPWAN集成（LoRaWAN、Sigfox）                   | 否     | 是     |
|                                      | 系统集成（AWS IoT、Azure IoT、PubSub、Kafka）| 否     | 是     |
| 安全与管理                     | 用户管理                                        | 是     | 是     |
|                                      | 审计日志                                          | 是     | 是     |
|                                      | 高级基于角色的访问控制（RBAC）              | 否     | 是     |
|                                      | 单点登录（SSO）/OAuth2                          | 否     | 是     |
|                                      | 密钥存储                                        | 否     | 是     |
| Go-to-Market                         | 白标定制                                         | 否     | 是     |
|                                      | 报表与排程                                 | 否     | 是     |
|                                      | 解决方案模板                                     | 否     | 是     |
|                                      | 设备载荷编解码库（400+）                    | 否     | 是     |
| 部署选项                   | 自主部署（本地/云）                        | 是     | 是     |
|                                      | 托管公有云                                   | 否     | 是     |
|                                      | 托管私有云                                  | 否     | 是     |
| 支持                              | 支持模式                                          | 社区   | 高级+SLA |


---

## 从CE迁移至PE

ThingsBoard生态最突出的优势之一，是**从CE到PE的无缝迁移路径**。
您可在CE上启动项目验证价值，当业务需要扩展时，可升级至PE而无需更换核心平台。

这既降低技术与商业风险，也缩短上市时间，并支持以**增长**为核心的IoT解决方案构建。

---

## 如何开始使用ThingsBoard CE和PE

选对版本只是第一步，选择**合适的模式**以匹配您的目标、资源和基础设施策略同样重要。

### :white_check_mark: 社区版快速入门

1. **自主部署（本地）**
   在自有或隔离数据中心，或离线/本地环境中完全掌控。
   :link: [Self-managed](https://thingsboard.io/docs/user-guide/install/installation-options/)

---

### :rocket: 专业版快速入门

根据您在控制权、责任和上市时间上的需求，ThingsBoard PE提供多种部署方式：

1. **ThingsBoard Cloud（欧洲与北美）**
   最快上手方式。由ThingsBoard团队托管，连接设备即可开始。
   :link: [ThingsBoard Cloud](https://thingsboard.io/installations/)

2. **ThingsBoard Private Cloud（欧盟、美国、亚太）**
   专属全托管集群，附带SLA保证。
   适合扩展至数十万或数百万设备规模。
   :link: [Private Cloud](https://thingsboard.io/pricing/?product=thingsboard-private-cloud)

3. **自主部署（本地PE）**
   在自有数据中心完全掌控。
   ThingsBoard为自主部署提供远程支持。
   :link: [Self-managed](https://thingsboard.io/pricing/?product=thingsboard-pe&solution=pe-pay-as-you-go)

---

