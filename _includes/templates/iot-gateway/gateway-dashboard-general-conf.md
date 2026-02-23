General（常规）- 本标签页包含主要设置：
- Remote Configuration（远程配置）- 启用网关的远程配置和管理。
- Remote Shell（远程 Shell）- 从 Remote Shell 部件启用对网关所在操作系统的远程控制。
- Platform host（平台主机）- 平台服务器的主机名或 IP 地址。
- Platform port（平台端口）- 平台服务器上 MQTT 服务的端口。
- Security type（安全类型）（更多说明请参见[此处](/docs/iot-gateway/configuration/#subsection-security)）- 远程配置目前支持 3 种安全类型：
  - Access Token。
  - TLS + Access Token。
  - Username and Password。
  - TLS + Private Key（**暂不支持**）。
- Report strategy（上报策略）（更多说明请参见[此处](/docs/iot-gateway/features-overview/report-strategy/)）- 向 ThingsBoard 发送网关状态时的策略：
  - On report period（按上报周期）- 在上报周期后发送网关状态。
  - On value change（按值变化）- 值变化时发送网关状态。
  - On value change or report period（按值变化或上报周期）- 值变化或到达上报周期时发送网关状态。
  - On received（按接收）- 从设备接收数据后发送网关状态（默认策略）。

![](/images/gateway/dashboard/gateway-dashboard-general-conf.png)
