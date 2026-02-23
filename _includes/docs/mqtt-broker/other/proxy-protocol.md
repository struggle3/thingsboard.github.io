
* TOC
{:toc}


[PROXY Protocol](https://www.haproxy.org/download/1.8/doc/proxy-protocol.txt) 是一种简单协议，用于在多层代理或负载均衡器之间安全传输连接信息（如客户端 IP 地址）。

TBMQ 同时支持 **PROXY Protocol v1** 和 **v2**，可接收并处理真实的客户端 IP 和端口，
这对于准确审计、限流、访问控制及理解客户端连接的实际来源至关重要。

- **PROXY Protocol v1**：人可读的基于 ASCII 的格式，在 TCP 流前添加连接元数据（如 IP 地址和端口）。
- **PROXY Protocol v2**：更高效的二进制格式，提供与 v1 相同的信息，但支持更多协议且在高吞吐量环境下性能更好。

使用 PROXY Protocol，TBMQ 可根据客户端真实 IP 地址记录、过滤并应用策略，否则该地址会被代理或负载均衡器遮蔽。

## PROXY Protocol 工作原理

PROXY Protocol 在 TCP 流的开头追加有关原始客户端连接的 **元信息**。
此元数据由代理或负载均衡器在任意协议特定数据（如 MQTT CONNECT 包或 TLS 握手）**之前** 发送。

![image](/images/mqtt-broker/other/proxy-protocol.png)

当客户端通过支持 PROXY Protocol 的代理连接 TBMQ 时，连接流程如下：

1. 代理接受客户端的 TCP 连接。
2. 代理立即发送包含以下内容的 **PROXY Protocol 头**：
    - 客户端的 **源 IP** 和 **端口**。
    - 代理的 **目标 IP** 和 **端口**。
    - **协议类型**（TCP over IPv4 或 IPv6）。
3. 启用 PROXY Protocol 的 TBMQ 首先读取此头，提取真实客户端信息，然后继续处理应用数据：
    - 对于明文 MQTT/WS 连接：TBMQ 随后处理 MQTT CONNECT 包。
    - 对于 TLS 加密的 MQTT/WS 连接：TBMQ 解析头后继续进行 **TLS 握手**。

- 在 **PROXY Protocol v1** 中，此头以 **ASCII** 格式发送，例如：
  ```
  PROXY TCP4 192.0.2.1 198.51.100.1 12345 1883\r\n
  ```
- 在 **PROXY Protocol v2** 中，头为 **二进制** 格式，更紧凑，适合高性能系统。

这意味着 TBMQ 将每条传入连接的前几个字节视为 PROXY Protocol 数据，然后才解释为 MQTT 连接。

## 何时使用该协议？

在以下情况下应在 TBMQ 中启用 PROXY Protocol：

- TBMQ 部署在支持 PROXY Protocol 的 **负载均衡器** 或 **反向代理**（如 HAProxy、AWS NLB、NGINX）**之后**。
- 需要捕获客户端的 **真实 IP 地址**，用于：
    - 准确 **记录** 客户端连接详情。
    - 应用 **基于 IP 的安全策略** 和 **限流**。
    - 基于真实客户端来源的详细 **审计** 和 **分析**。

TBMQ 将客户端 IP 地址作为 **客户端会话信息** 的一部分存储。
此 IP 地址也用于 **Unauthorized Clients** 功能，TBMQ 在其中跟踪认证失败的客户端的连接尝试。
拥有正确的 IP 地址有助于识别未授权访问尝试的来源并改进安全监控。

若不使用 PROXY Protocol，TBMQ 只能看到代理或负载均衡器的 IP，无法区分代理后的各客户端。
启用 PROXY Protocol 可确保 TBMQ 在连接时收到实际客户端 IP 和端口。

> **重要**：除非代理已正确配置为发送 PROXY Protocol 头，否则 **不要** 启用 PROXY Protocol。启用后，TBMQ 期望每条 TCP 连接开头都有 PROXY Protocol 头。

## 如何启用该协议？

要在 TBMQ 中启用 PROXY Protocol 支持，需更新 MQTT 监听器配置。

- **TBMQ v2.3 之前**：PROXY Protocol 设置 **全局** 应用于 TBMQ 中所有 MQTT 监听器，**无法** 为每个监听器单独配置。

```yaml
# MQTT listeners parameters
listener:
  # Enable proxy protocol support. Disabled by default. If enabled, supports both v1 and v2.
  # Useful to get the real IP address of the client in the logs, for session details info and unauthorized clients feature
  proxy_enabled: "${MQTT_PROXY_PROTOCOL_ENABLED:false}"
```

将环境变量 `MQTT_PROXY_PROTOCOL_ENABLED` 设为 "**true**"。

- **TBMQ v2.3 起**：除全局设置外，还可 **按 MQTT 监听器** 配置 PROXY Protocol。
  按监听器设置默认为未设置，继承全局值。
  若显式设置，按监听器值将覆盖全局值。

```yaml
# MQTT listeners parameters
listener:
  # Enable proxy protocol support as a global setting for all listeners. Disabled by default. If enabled, supports both v1 and v2.
  # Useful to get the real IP address of the client in the logs, for session details info and unauthorized clients feature
  proxy_enabled: "${MQTT_PROXY_PROTOCOL_ENABLED:false}"

# Per-listener overrides (inherit global if unset)
  tcp:
    # Enable proxy protocol support for the MQTT TCP listener. Unset by default – in this case it inherits the global MQTT_PROXY_PROTOCOL_ENABLED value.
    # If explicitly set, supports both v1 and v2 and takes precedence over the global setting.
    # Useful to get the real IP address of the client in the logs, for session details info and unauthorized clients feature
    proxy_enabled: "${MQTT_TCP_PROXY_PROTOCOL_ENABLED:}"
  ssl:
    # Enable proxy protocol support for the MQTT TLS listener. Unset by default – in this case it inherits the global MQTT_PROXY_PROTOCOL_ENABLED value.
    # If explicitly set, supports both v1 and v2 and takes precedence over the global setting.
    # Useful to get the real IP address of the client in the logs, for session details info and unauthorized clients feature
    proxy_enabled: "${MQTT_SSL_PROXY_PROTOCOL_ENABLED:}"
  ws:
    # Enable proxy protocol support for the MQTT WS listener. Unset by default – in this case it inherits the global MQTT_PROXY_PROTOCOL_ENABLED value.
    # If explicitly set, supports both v1 and v2 and takes precedence over the global setting.
    # Useful to get the real IP address of the client in the logs, for session details info and unauthorized clients feature
    proxy_enabled: "${MQTT_WS_PROXY_PROTOCOL_ENABLED:}"
  wss:
    # Enable proxy protocol support for the MQTT WSS listener. Unset by default – in this case it inherits the global MQTT_PROXY_PROTOCOL_ENABLED value.
    # If explicitly set, supports both v1 and v2 and takes precedence over the global setting.
    # Useful to get the real IP address of the client in the logs, for session details info and unauthorized clients feature
    proxy_enabled: "${MQTT_WSS_PROXY_PROTOCOL_ENABLED:}"
```

**示例**

```yaml
MQTT_PROXY_PROTOCOL_ENABLED=true        # PROXY protocol 全局启用
MQTT_TCP_PROXY_PROTOCOL_ENABLED=false   # MQTT TCP 监听器显式禁用 PROXY protocol -> 禁用
MQTT_SSL_PROXY_PROTOCOL_ENABLED=        # TLS 监听器 PROXY protocol 设置未设置，继承全局设置 -> 启用
```

**重要说明：**

- 当 `proxy_enabled` 设为 `true` 时，TBMQ 自动支持 **PROXY Protocol v1 和 v2**。
- 此设置确保 TBMQ 正确解析每条 TCP 连接开头发送的 PROXY Protocol 头，在任意 MQTT 或 TLS 特定数据 **之前**。

### HAProxy

要使用 PROXY Protocol 将真实客户端 IP 转发给 TBMQ，按如下配置 **HAProxy**：

```text
server tbmq1 192.168.1.100:1883 send-proxy
```

- `send-proxy`：指示 HAProxy 向 TBMQ 发送 PROXY Protocol v1 头。
- 将 `192.168.1.100:1883` 替换为您的 TBMQ broker 的 IP 和端口。

要使用 PROXY Protocol v2，改为：

```text
server tbmq1 192.168.1.100:1883 send-proxy-v2
```

- `send-proxy-v2`：向 TBMQ 发送 PROXY Protocol v2 头。

可在此处查找启用 PROXY Protocol 的完整 HAProxy 配置指南 [here](https://www.haproxy.com/documentation/haproxy-configuration-tutorials/proxying-essentials/client-ip-preservation/enable-proxy-protocol/)。

### AWS Network Load Balancer (NLB)

要配合 **AWS NLB** 使用 PROXY Protocol，需启用 **PROXY Protocol v2**：

1. 确保 NLB 为 **TCP** 或 **TLS** 类型。
2. 使用 AWS CLI 启用 PROXY Protocol v2：

```bash
aws elbv2 modify-target-group-attributes \
 --target-group-arn <your-target-group-arn> \
 --attributes Key=proxy_protocol_v2.enabled,Value=true
```
{: .copy-code}

> **注意**：AWS NLB 仅支持 **PROXY Protocol v2**。

或者，在 Kubernetes 环境中配合 AWS NLB 启用 **PROXY Protocol v2**，在 Service 定义中添加以下 annotation：

```yaml
service.beta.kubernetes.io/aws-load-balancer-proxy-protocol: "*"
```
{: .copy-code}

- `*` 为所有源 IP 启用 **PROXY Protocol v2**。

详见官方 [AWS 文档](https://kubernetes-sigs.github.io/aws-load-balancer-controller/latest/guide/service/nlb/#protocols)。

### 其他负载均衡器

不仅限于 HAProxy 或 AWS NLB——任何支持 PROXY Protocol 的负载均衡器均可与 TBMQ 配合使用。
例如 **Google Cloud Load Balancer**、**Azure Load Balancer**、**NGINX** 或其他反向代理。

配置步骤简单：

1. 根据所选负载均衡器的 **官方文档** 在其上启用 PROXY Protocol。
2. 在 TBMQ 端启用 PROXY Protocol（全局或按监听器，取决于您的版本）。

双方正确配置后，TBMQ 将正确解析 PROXY Protocol 头并捕获真实客户端 IP 和端口，无论使用哪种负载均衡器。

## 注意事项

* 若 TBMQ 启用了 PROXY Protocol 但代理/负载均衡器未使用，TBMQ 将无法解析初始字节，可能拒绝连接。
* 若 TBMQ 禁用了 PROXY Protocol 但代理/负载均衡器启用，TBMQ 会将 PROXY Protocol 头误解为 MQTT 或 TLS 数据的一部分，导致连接错误或协议解析失败。
* 启用 PROXY Protocol 支持时，确保所有到 TBMQ 的连接均通过正确配置的代理。
* 仅当 TBMQ 部署在受信任代理之后时才应启用 PROXY Protocol，因协议允许代理定义客户端 IP。

> **注意**：TBMQ 对 PROXY Protocol 支持并非协议无关。
> 启用 PROXY Protocol 时，所有连接必须包含 PROXY 头。
> 不支持在同一监听器上混用带和不带 PROXY 头的连接。
> 未来版本可能引入更灵活的处理以支持混合连接类型。
