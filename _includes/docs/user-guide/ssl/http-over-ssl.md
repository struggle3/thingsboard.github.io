* TOC
{:toc}

{% capture use-haproxy-instead %}
为 Web UI 提供 HTTPS 保护的最佳做法是使用 [HAProxy](/docs/user-guide/install/pe/add-haproxy-ubuntu/)，它能高效处理 SSL/TLS 终结，同时保护用户流量。

但在某些情况下，您可能还需要 HTTP 传输的双向 SSL。若只需为 Web UI 提供 HTTPS，请使用 HAProxy。若需 HTTP 传输的双向 SSL，请按本指南操作。
{% endcapture %}
{% include templates/info-banner.md content=use-haproxy-instead %}

ThingsBoard 支持在 SSL 之上运行承载 Web UI 并提供 REST API 调用的 HTTP 服务器。

大多数 ThingsBoard 环境使用负载均衡器作为客户端与平台之间 SSL 连接的终结点。
换言之，用户浏览器与负载均衡器之间的互联网流量是加密的，而负载均衡器与平台服务之间则为明文。
{% include docs/user-guide/ssl/http-over-ssl-common.md %}
