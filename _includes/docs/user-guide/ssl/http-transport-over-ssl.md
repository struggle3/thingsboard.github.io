* TOC
{:toc}

ThingsBoard 支持在 SSL 之上运行处理设备 API 调用的 HTTP 服务器。
本指南与 [Enable HTTPS](/docs/{{docsPrefix}}user-guide/ssl/http-over-ssl/) 指南基本相同。

大多数 ThingsBoard 环境使用负载均衡器作为设备与平台之间 SSL 连接的终结点。
换言之，设备与负载均衡器之间的互联网流量是加密的，而负载均衡器与平台服务之间则为明文。
{% include docs/user-guide/ssl/http-over-ssl-common.md %}

## Client Examples

参见 [Access Token 认证](/docs/{{docsPrefix}}user-guide/ssl/http-access-token/) 以了解 **单向 SSL** 连接示例。
