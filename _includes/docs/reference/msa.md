
* TOC
{:toc}

自 ThingsBoard v2.2 起，平台支持微服务部署模式。
本文包括高层架构图、各服务间数据流说明及部分架构选型。

## 架构图

 <object width="80%" data="/images/reference/msa-architecture.svg"></object> 
  
## 传输微服务

ThingsBoard 提供基于 MQTT、HTTP 和 CoAP 的 API，供设备应用或固件使用。
各协议 API 由独立的服务器组件提供，属于 ThingsBoard“传输层”。
完整组件列表及对应文档页如下：

* HTTP 传输微服务提供设备 API，见[此处](/docs/{{docsPrefix}}reference/http-api/)； 
* MQTT 传输微服务提供设备 API，见[此处](/docs/{{docsPrefix}}reference/mqtt-api/)，
  并启用网关 API，见[此处](/docs/{{docsPrefix}}reference/gateway-mqtt-api/)；
* CoAP 传输微服务提供设备 API，见[此处](/docs/{{docsPrefix}}reference/coap-api/)；
* LwM2M 传输微服务提供设备 API，见[此处](/docs/{{docsPrefix}}reference/lwm2m-api/)。

上述各传输服务器通过 Kafka 与主 ThingsBoard Node 微服务通信。
[Apache Kafka](https://kafka.apache.org) 是分布式、可靠、可扩展的持久消息队列与流处理平台。

发送至 Kafka 的消息使用 [protocol buffers](https://developers.google.com/protocol-buffers/) 序列化，
消息定义见[此处](https://github.com/thingsboard/thingsboard/blob/master/common/proto/src/main/proto/transport.proto)。

**注意**：自 v2.5 起，ThingsBoard PE 将支持替代队列实现：Amazon DynamoDB。详见 [roadmap](/docs/{{docsPrefix}}reference/roadmap)。
 
传输层微服务使用两个主要 topic。

第一个 topic "tb.transport.api.requests" 用于执行短生命周期 API 请求，以校验设备凭据或代表网关创建设备。
对此类请求的响应发送到各传输微服务专用的 topic。默认下，这类“回调”topic 前缀为 "tb.transport.api.responses"。

第二个 topic "tb.rule-engine" 用于存储来自设备的所有遥测消息，直至被 Rule Engine 处理。
若 Rule Engine 节点宕机，消息将持久化，供后续处理。

配置示例片段如下：   

```yaml
transport:
  type: "${TRANSPORT_TYPE:local}" # local or remote
  remote:
    transport_api:
      requests_topic: "${TB_TRANSPORT_API_REQUEST_TOPIC:tb.transport.api.requests}"
      responses_topic: "${TB_TRANSPORT_API_RESPONSE_TOPIC:tb.transport.api.responses}"
    rule_engine:
      topic: "${TB_RULE_ENGINE_TOPIC:tb.rule-engine}"
```    

由于 ThingsBoard 在传输与核心服务间使用非常简单的通信协议，
实现自定义传输协议支持（如纯 TCP 上的 CSV、UDP 上的二进制负载等）较为容易。
建议查看现有传输 [实现](https://github.com/thingsboard/thingsboard/tree/master/common/transport/mqtt) 入手，或 [联系我们](/docs/contact-us/) 获取帮助。

## Web UI 微服务

ThingsBoard 提供基于 Express.js 的轻量组件托管静态 Web UI 内容。这些组件完全无状态，配置项较少。

## JavaScript Executor 微服务

ThingsBoard Rule Engine 允许用户指定自定义 JavaScript 函数来解析、过滤和转换消息。
由于这些函数由用户定义，需在隔离上下文中执行，以避免影响主处理流程。
ThingsBoard 提供基于 Node.js 的轻量组件，远程执行用户定义的 JavaScript 函数，与核心 Rule Engine 组件隔离。

**注意**：ThingsBoard 单体应用在 Java 内嵌 JS 引擎中执行用户函数，无法隔离资源消耗。
 
建议启动 20 个以上的 JavaScript Executor 以支持一定并发和 JS 执行请求的负载均衡。
各微服务将作为单一 consumer group 的成员订阅 "js.eval.requests" Kafka topic，实现负载均衡。
相同脚本的请求通过 Kafka 的 key 分区（key 为 script/rule node id）转发至同一 JS executor。

可配置待处理 JS 执行请求的最大数量及最大超时，避免单个 JS 执行阻塞 JS executor 微服务。
各 ThingsBoard 核心服务对 JS 函数有独立黑名单，默认对已屏蔽函数最多调用 3 次。

## ThingsBoard Node

ThingsBoard Node 是以 Java 编写的核心服务，负责处理：
 
 * [REST API](/docs/{{docsPrefix}}reference/rest-api/) 调用；
 * 实体遥测与属性变更的 WebSocket [订阅](/docs/{{docsPrefix}}user-guide/telemetry/#websocket-api)；
 * 通过 [Rule Engine](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 处理消息；
 * 设备 [连接状态](/docs/{{docsPrefix}}user-guide/device-connectivity-status/)（活跃/非活跃）监控。
 
**注意**：将 Rule Engine 迁移为独立微服务计划于 ThingsBoard v2.5 完成。详见 [roadmap](/docs/{{docsPrefix}}reference/roadmap)。
 
ThingsBoard Node 使用 Actor System 实现租户、设备、Rule Chain 与 Rule Node Actor。
平台节点可加入集群，各节点地位平等。服务发现通过 Zookeeper 完成。
ThingsBoard 节点间使用基于实体 ID 的 consistent hashing 算法路由消息。
因此，同一实体的消息在同一 ThingsBoard 节点上处理。平台使用 [gRPC](https://grpc.io/) 在节点间发送消息。

**注意**：ThingsBoard 作者计划在未来版本中用 Kafka 替代 gRPC 进行节点间消息交换。
主要考虑是以小幅性能与延迟牺牲，换取 Kafka consumer groups 带来的持久可靠投递与自动负载均衡。

## 第三方组件  

### Kafka

[Apache Kafka](https://kafka.apache.org/) 是开源流处理软件平台。ThingsBoard 使用 Kafka 持久化来自 HTTP/MQTT/CoAP 传输的遥测数据，
直至被 Rule Engine 处理。ThingsBoard 还在部分微服务间 API 调用中使用 Kafka。

### 缓存数据库

ThingsBoard 缓存资产、实体视图、设备、设备凭据、设备会话与实体关系。

##### Redis
[Redis](https://redis.io/) 是源代码可用（遵循 [RSALv2](https://redis.io/legal/rsalv2-agreement/) 与 [SSPLv1](https://redis.io/legal/server-side-public-license-sspl/)）的内存数据结构存储，ThingsBoard 用于缓存。

##### Valkey
[Valkey](https://valkey.io/) 是开源（BSD 许可）内存数据结构存储，可作为 Redis 的替代使用。

### Zookeeper

[Zookeeper](https://zookeeper.apache.org/) 是支持高可靠分布式协调的开源服务器。
ThingsBoard 使用 Zookeeper 将来自单一实体（设备、资产、租户）的请求处理路由到特定 ThingsBoard 服务器，
并保证任意时刻仅有一台服务器处理特定设备的数据。

**注意**：Kafka 也使用 Zookeeper，因此几乎无需并行使用两种不同协调服务（Consul、etcd）。

### HAProxy（或其他负载均衡器）

建议使用 HAProxy 进行负载均衡。 
可参考与下述架构图对应的 [haproxy.cfg](https://github.com/thingsboard/thingsboard/blob/release-2.5/docker/haproxy/config/haproxy.cfg) 配置： 

{% highlight conf %}
#HA Proxy Config
global
 ulimit-n 500000
 maxconn 99999
 maxpipes 99999
 tune.maxaccept 500

 log 127.0.0.1 local0
 log 127.0.0.1 local1 notice

 ca-base /etc/ssl/certs
 crt-base /etc/ssl/private

 ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS
 ssl-default-bind-options no-sslv3

defaults

 log global

 mode http

 timeout connect 5000ms
 timeout client 50000ms
 timeout server 50000ms
 timeout tunnel  1h    # timeout to use with WebSocket and CONNECT

 default-server init-addr none

#enable resolving throught docker dns and avoid crashing if service is down while proxy is starting
resolvers docker_resolver
  nameserver dns 127.0.0.11:53

listen stats
 bind *:9999
 stats enable
 stats hide-version
 stats uri /stats
 stats auth admin:admin@123

listen mqtt-in
 bind *:${MQTT_PORT}
 mode tcp
 option clitcpka # For TCP keep-alive
 timeout client 3h
 timeout server 3h
 option tcplog
 balance leastconn
 server tbMqtt1 tb-mqtt-transport1:1883 check inter 5s resolvers docker_resolver resolve-prefer ipv4
 server tbMqtt2 tb-mqtt-transport2:1883 check inter 5s resolvers docker_resolver resolve-prefer ipv4

frontend http-in
 bind *:${HTTP_PORT}

 option forwardfor

 reqadd X-Forwarded-Proto:\ http

 acl acl_static path_beg /static/ /index.html
 acl acl_static path /
 acl acl_static_rulenode path_beg /static/rulenode/

 acl transport_http_acl path_beg /api/v1/
 acl letsencrypt_http_acl path_beg /.well-known/acme-challenge/

 redirect scheme https if !letsencrypt_http_acl !transport_http_acl { env(FORCE_HTTPS_REDIRECT) -m str true }

 use_backend letsencrypt_http if letsencrypt_http_acl
 use_backend tb-http-backend if transport_http_acl
 use_backend tb-web-backend if acl_static !acl_static_rulenode

 default_backend tb-api-backend

frontend https_in
  bind *:${HTTPS_PORT} ssl crt /usr/local/etc/haproxy/default.pem crt /usr/local/etc/haproxy/certs.d ciphers ECDHE-RSA-AES256-SHA:RC4-SHA:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM

  option forwardfor

  reqadd X-Forwarded-Proto:\ https

  acl transport_http_acl path_beg /api/v1/

  acl acl_static path_beg /static/ /index.html
  acl acl_static path /
  acl acl_static_rulenode path_beg /static/rulenode/

  use_backend tb-http-backend if transport_http_acl
  use_backend tb-web-backend if acl_static !acl_static_rulenode

  default_backend tb-api-backend

backend letsencrypt_http
  server letsencrypt_http_srv 127.0.0.1:8080

backend tb-web-backend
  balance leastconn
  option tcp-check
  option log-health-checks
  server tbWeb1 tb-web-ui1:8080 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  server tbWeb2 tb-web-ui2:8080 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  http-request set-header X-Forwarded-Port %[dst_port]

backend tb-http-backend
  balance leastconn
  option tcp-check
  option log-health-checks
  server tbHttp1 tb-http-transport1:8081 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  server tbHttp2 tb-http-transport2:8081 check inter 5s resolvers docker_resolver resolve-prefer ipv4

backend tb-api-backend
  balance leastconn
  option tcp-check
  option log-health-checks
  server tbApi1 tb1:8080 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  server tbApi2 tb2:8080 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  http-request set-header X-Forwarded-Port %[dst_port]
{% endhighlight %}

### 数据库

详见 "[SQL vs NoSQL vs Hybrid?](/docs/{{docsPrefix}}reference/#sql-vs-nosql-vs-hybrid-database-approach)"。

## 部署

可参考 [docker-compose.yml]({{ page.reference_compose_yml }})
及对应 [文档]({{ page.reference_compose_readme }})，以集群模式运行 ThingsBoard 容器
（可在单台主机上运行）
