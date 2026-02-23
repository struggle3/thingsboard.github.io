* TOC
{:toc}

### 概述

在 [proxy](https://en.wikipedia.org/wiki/Proxy_server){: target="_blank"} 后安装 **Edge** 意味着 **Edge** 实例无法直接访问互联网，与 **ThingsBoard Cloud** 或任何其他外部服务的所有通信均通过 **proxy server** 路由。

对比：
* **Without Proxy**（直接连接）：

![Without Proxy](/images/edge/config/edge-behind-proxy/without-proxy.webp){: style="max-width: 400px"}

* **With Proxy**（间接连接）：

![With Proxy](/images/edge/config/edge-behind-proxy/with-proxy.webp){: style="max-width: 575px"}

使用 proxy server 可通过过滤和监控互联网流量增强安全性。在受限环境中，直接互联网访问通常被故意阻止，使得 proxy 配置成为维持安全协议的必需品。

除安全性外，proxy 可缓存资源，可大幅降低总体网络消耗并提升 ThingsBoard Edge 等分布式系统的性能。

### 安装指南

{% capture contenttogglespecqueue %}
Debian-based installation%,%deb%,%templates/edge/user-guide/deb-edge-behind-proxy.md%br%
Docker-based installation%,%docker%,%templates/edge/user-guide/docker-edge-behind-proxy.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="edgeBehindProxy" toggle-spec=contenttogglespecqueue %}
