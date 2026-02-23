<br>
{% capture grpc_ssl_note %}
**保护 ThingsBoard Edge 与 ThingsBoard Professional/Community Edition 服务器之间通信的重要说明**
 - ThingsBoard Edge 与 ThingsBoard Professional/Community Edition 服务器实例通过 gRPC 协议通信
 - 默认情况下 gRPC 通道未使用 TLS/SSL 机制加固，ThingsBoard Edge 与 ThingsBoard Professional/Community Edition 服务器实例之间传输的二进制消息可能被未授权人员窃取
 - gRPC 消息包含用户密码、设备凭证等敏感数据，此类数据被盗可能导致严重后果
 - ThingsBoard 团队强烈建议在生产环境及包含敏感数据的环境中为 gRPC 配置 TLS/SSL 安全通信
 - 请按此 [指南](/docs/edge/user-guide/grpc-over-ssl/) 配置 gRPC over TLS/SSL
{% endcapture %}
{% include templates/info-banner.md content=grpc_ssl_note %}
