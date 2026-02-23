* TOC
{:toc}

Basic 认证因其简单且 MQTT 协议原生支持，仍是最常用的 MQTT 客户端认证方式之一。
常用于客户端预置凭证的场景，例如连接私有网络的 IoT 设备、内部系统集成或访问控制要求简单的部署。
结合安全传输（TLS）使用时，可为多种 MQTT 场景提供可靠且广泛采用的认证选项。

### Basic 认证概述

Basic 认证允许 MQTT 客户端使用 `CONNECT` 包中的凭证（如 clientId、username、password）进行认证。
TBMQ 使用这些凭证生成唯一的 `credentialsId`，并通过灵活匹配策略与存储的 [MQTT 客户端凭证](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/mqtt-client-credentials/)记录匹配。
为优化认证性能，TBMQ 在 Redis 中维护凭证以便快速查找，PostgreSQL 负责可靠持久化。
以下各节说明 provider 配置、凭证匹配、`credentialsId` 生成以及认证成功后的授权应用。

### 配置 provider

{% include docs/mqtt-broker/user-guide/ui/authentication-provider-control.md %}

### 凭证匹配

以下是 `Basic` 凭证匹配器的**可选组合**：
- **clientId** - 检查连接客户端是否指定了 clientId；
- **username** - 检查连接客户端是否指定了 username；
- **clientId 和 username** - 检查连接客户端是否同时指定 clientId 和 username；
- **username 和 password** - 检查连接客户端是否同时指定 username 和 password；
- **clientId 和 password** - 检查连接客户端是否同时指定 clientId 和 password；
- **clientId、username 和 password** - 检查连接客户端是否同时指定 clientId、username 和 password。

### Credentials ID

客户端连接时，`CONNECT` 包中的 username、password 和 clientId 组合与持久化凭证匹配以进行认证。
匹配基于 MQTT 客户端凭证中自动生成的 `credentialsId` 字段。

`credentialsId` 生成规则如下：

- 仅存在 username 时：credentialsId = `username|$CLIENT_USERNAME`；
- 仅存在 client ID 时：credentialsId = `client_id|$CLIENT_ID`；
- 同时存在 username 和 client ID 时：credentialsId = `mixed|$CLIENT_USERNAME|$CLIENT_ID`。

其中 `$CLIENT_USERNAME` 指指定 username，`$CLIENT_ID` 指 `CONNECT` 包中的 client ID。

{% include images-gallery.html imageCollection="security-authentication-basic" %}

### 授权

用户认证成功后，可限制客户端对可发布或订阅主题的访问。

TBMQ 使用正则表达式提供灵活的授权规则控制。

例如，要**允许客户端发布或订阅**以 **city/** 开头的所有主题，应创建值为 **city/.*** 的授权规则。

对于 Basic 类型，授权通过对应 MQTT 客户端凭证的 **pubAuthRulePatterns** 和 **subAuthRulePatterns** 配置。
因此，可为每个 Basic MQTT 客户端凭证配置这些客户端可访问主题的授权规则。

**pubAuthRulePatterns** 和 **subAuthRulePatterns** 基于正则表达式语法。例如：
```
{
    "pubAuthRulePatterns": ["country/.*"],
    "subAuthRulePatterns": ["city/.*"]
}
```
{: .copy-code}
以下配置允许客户端向以 **country/** 开头的主题发布消息，并订阅以 **city/** 开头的主题。

{% include images-gallery.html imageCollection="security-authorization-basic" %}

### 基于 Client ID、Username 和 Password 的 MQTT 示例

在此选项中，需在 MQTT 客户端凭证中填写 Client ID、Username 和 Password。MQTT 客户端若指定正确的 client ID、username 和 password 组合即可连接。

下面是一条使用 MQTT client ID、username 和 password 向 TBMQ 发布消息的简单命令。该命令使用纯 MQTT（无 TLS）：

```bash
mosquitto_pub -d -q 1 -h "YOUR_TBMQ_HOST" -p "1883" -t "sensors/temperature" -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}

其中：

* **YOUR_TBMQ_HOST** - TBMQ 实例的主机地址；
* **YOUR_CLIENT_ID** - 客户端 ID；
* **YOUR_CLIENT_USERNAME**、**YOUR_CLIENT_PASSWORD** - 客户端用户名和密码。

{% include images-gallery.html imageCollection="tbmq-client-id-username-and-password" %}

### 基于 Client ID、Username 和 Password 的 MQTTS 示例

单向 SSL 认证是标准认证模式，客户端通过服务器证书验证服务器身份。
请参阅 [MQTT over SSL](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/) 指南为 TBMQ 实例配置服务器证书。

下面是一条使用 MQTT client ID、username 和 password 通过 MQTTS 向 TBMQ 发布消息的简单命令：

```bash
mosquitto_pub -d -q 1 --cafile YOUR_PEM_FILE -h "YOUR_TBMQ_HOST" -p 8883 -t "sensors/temperature" -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}

其中：

* **YOUR_PEM_FILE** - CA 证书文件路径；
* **YOUR_TBMQ_HOST** - TBMQ 实例的主机地址；
* **YOUR_CLIENT_ID** - 客户端 ID；
* **YOUR_CLIENT_USERNAME**、**YOUR_CLIENT_PASSWORD** - 客户端用户名和密码。

{% include images-gallery.html imageCollection="tbmq-tls-client-id-username-and-password" %}

## 下一步

{% assign currentGuide = "SecurityGuide" %}{% include templates/mqtt-broker-guides-banner.md %}
