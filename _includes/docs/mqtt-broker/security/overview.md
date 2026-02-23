* TOC
{:toc}

TBMQ 提供一系列安全特性，用于保护 MQTT 通信、控制客户端访问并实施主题级权限。
这些特性覆盖 MQTT 安全的关键方面——从连接级设置到细粒度授权规则——并为多种部署场景提供灵活配置选项。

概览页介绍 TBMQ 中 MQTT 安全的三个核心领域：连接级安全、认证和授权。
以下各节说明这些组件的作用、配置方式及其在 broker 安全模型中的交互。

## 连接级安全

连接级安全侧重于配置客户端如何连接 broker。
定义支持的传输协议、加密选项和网络级参数——在应用认证和授权之前建立安全通信通道所必需。
在 TBMQ 中，通过配置 [MQTT listeners](/docs/{{docsPrefix}}mqtt-broker/security/listeners/) 实现，支持加密和非加密协议（TCP、TLS、WebSockets）。
每个 listener 暴露可配置属性——如端口、主机地址和性能调优选项——可通过配置文件设置或使用环境变量覆盖。
对于 TLS 和 WebSocket Secure (WSS) 监听器，还可配置证书和支持的协议等加密参数。

## 认证

认证验证尝试连接的客户端的身份。即在授予 broker 访问权限之前验证客户端凭据的过程。
支持的认证方式包括：Basic（username/password）、X.509 Certificate Chain、JWT 和 SCRAM。


### 提供者管理

{% if docsPrefix != "pe/" %}
{% assign sinceVersion = "2.2" %}
{% include templates/mqtt-broker/since.md %}
{% endif %}

认证方式以可插拔认证提供者实现：

- [Basic](/docs/{{docsPrefix}}mqtt-broker/security/authentication/basic/) — 使用 `CONNECT` 包中的 clientId、username 和 password 认证客户端。
- [X.509 Certificate Chain](/docs/{{docsPrefix}}mqtt-broker/security/authentication/x509/) — 在 TLS 握手中使用客户端 X.509 证书链进行认证。
- [JWT (JSON Web Token)](/docs/{{docsPrefix}}mqtt-broker/security/authentication/jwt/) — 使用在 `CONNECT` 包 **password** 字段中传递的签名 JWT 认证客户端。
- [SCRAM](/docs/{{docsPrefix}}mqtt-broker/security/authentication/scram/) — 使用哈希凭据进行安全 challenge-response 认证，不传输实际密码（仅 MQTT 5.0）。

每个提供者可单独启用、禁用和配置，以满足不同部署用例的需求。

{% capture providerEditOnly %}
不允许添加或删除认证提供者。用户仅可编辑其配置。
{% endcapture %}
{% include templates/warn-banner.md content=providerEditOnly %}

{% include docs/mqtt-broker/user-guide/ui/authentication-provider-control.md %}

### 提供者执行顺序

{% if docsPrefix != "pe/" %}
{% assign sinceVersion = "2.2" %}
{% include templates/mqtt-broker/since.md %}
{% endif %}

TBMQ 按可配置的执行顺序处理认证提供者。
可从用于配置 MQTT 认证相关参数的 [MQTT Authentication Settings](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/settings/#mqtt-authentication) 页面配置。

{% include docs/mqtt-broker/user-guide/ui/authentication-settings.md %}

## 授权

授权根据已认证客户端的权限，对特定资源或操作授予或拒绝访问。
为此，通过应用可配置规则定义主题级访问控制，规则决定客户端是否可发布到或订阅特定主题。TBMQ 使用基于正则表达式的主题模式执行这些规则。
授权设置通常在 [client credentials](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/mqtt-client-credentials) 级别配置。仅 JWT 认证支持在提供者级别定义授权规则，从而实现动态、token 驱动的访问控制。

## 下一步

{% assign currentGuide = "SecurityGuide" %}{% include templates/mqtt-broker-guides-banner.md %}
