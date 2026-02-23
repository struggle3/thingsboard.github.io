通过 SMTP 服务器发送邮件，支持可配置的认证和传输安全选项。
该节点期望接收由 [「to email」](/docs/user-guide/rule-engine-2-0/nodes/transformation/to-email/){:target="_blank"} 转换节点创建的 `SEND_EMAIL` 类型消息。

## 配置

### Use system SMTP settings

控制使用平台级 SMTP 设置还是节点专用配置：

- **Enabled**（默认）— 节点使用系统管理员配置的 SMTP 设置。启用后，其余 SMTP 配置字段隐藏且忽略。
- **Disabled** — 节点使用节点配置中指定的自定义 SMTP 设置。允许不同邮件节点使用不同 SMTP 服务器或凭据。

### SMTP settings

- **Protocol** — 指定使用的邮件传输协议。可用选项：
    - **SMTP**（默认）— 标准 SMTP 协议
    - **SMTPS** — 基于 SSL/TLS 的 SMTP
- **SMTP host** — SMTP 邮件服务器的主机名或 IP 地址。
- **SMTP port** — SMTP 服务器端口号。
- **Timeout (ms)** — 套接字读取超时时间（毫秒）。**默认**：`10000`（10 秒）。若套接字读取超过此超时，节点失败并经 `Failure` 连接路由消息。

### Security settings

- **Enable TLS** — 控制是否为 SMTP 连接使用 TLS 加密。
    - **Disabled**（默认）— 连接使用明文 SMTP，无加密。
    - **Enabled** — 连接在初始握手后使用 STARTTLS 升级为 TLS 加密。
- **TLS version** — 当 **Enable TLS** 已启用时指定使用的 TLS 协议版本。**默认**：`TLSv1.2`。
- **Username** — SMTP 服务器认证的用户名。若 SMTP 服务器允许匿名访问则留空（生产环境不推荐）。
- **Password** — SMTP 服务器认证的密码。若 SMTP 服务器允许匿名访问则留空。

{% capture credentials_note %}
**注意**：SMTP 凭据可存储在 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 以增强安全性。
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

### Proxy settings

- **Enable proxy** — 控制是否通过代理服务器路由 SMTP 流量。
    - **Disabled**（默认）— 直接连接 SMTP 服务器。
    - **Enabled** — 通过指定的代理服务器路由流量。启用后必须配置代理主机和端口。代理认证凭据可选。
- **Proxy host** — 代理服务器的主机名或 IP 地址。
- **Proxy port** — 代理服务器端口号。
- **Proxy user** — 代理认证的可选用户名。若代理服务器无需认证则留空。
- **Proxy password** — 代理认证的可选密码。若代理服务器无需认证则留空。

{% capture proxy_note %}
**注意**：代理凭据可存储在 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 以增强安全性。
{% endcapture %}
{% include templates/info-banner.md content=proxy_note %}

### Advanced settings

#### Force acknowledgement

强制确认机制由 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 环境变量控制。当该变量设为 `true` 时，适用于包括本邮件节点在内的所有外部节点。

**启用强制确认时的行为**：

- 入站消息立即被确认并创建副本
- 邮件发送操作异步执行
- 发送操作完成后，消息副本加入队列供下一节点处理
- 可避免慢速 SMTP 服务器或大附件导致的消息处理超时

**禁用强制确认时**（默认）：

- 原始入站消息在邮件发送操作完成前保持占用
- 随后将消息传递至下一节点

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSendEmailNodeConfiguration",
  "type": "object",
  "properties": {
    "useSystemSmtpSettings": {
      "type": "boolean",
      "description": "Whether to use platform-wide SMTP settings."
    },
    "smtpHost": {
      "type": "string",
      "description": "Hostname or IP address of the SMTP server."
    },
    "smtpPort": {
      "type": "integer",
      "minimum": 1,
      "maximum": 65535,
      "description": "Port number of the SMTP server."
    },
    "smtpProtocol": {
      "type": "string",
      "enum": ["smtp", "smtps"],
      "description": "Email transport protocol."
    },
    "timeout": {
      "type": "integer",
      "minimum": 1,
      "description": "Maximum time to wait for SMTP operations (milliseconds)."
    },
    "enableTls": {
      "type": "boolean",
      "description": "Whether to use STARTTLS encryption."
    },
    "tlsVersion": {
      "type": "string",
      "description": "TLS protocol version to use."
    },
    "enableProxy": {
      "type": "boolean",
      "description": "Whether to route traffic through a proxy server."
    },
    "proxyHost": {
      "type": "string",
      "description": "Hostname or IP address of the proxy server."
    },
    "proxyPort": {
      "type": "string",
      "description": "Port number of the proxy server."
    },
    "proxyUser": {
      "type": "string",
      "description": "Optional username for proxy authentication."
    },
    "proxyPassword": {
      "type": "string",
      "description": "Optional password for proxy authentication."
    },
    "username": {
      "type": "string",
      "description": "Username for SMTP server authentication."
    },
    "password": {
      "type": "string",
      "description": "Password for SMTP server authentication."
    }
  },
  "required": [
    "useSystemSmtpSettings"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

该节点仅处理类型为 `SEND_EMAIL` 的消息。消息必须由「to email」转换节点创建，该节点将消息 data 转换为正确的邮件格式。

对每条入站消息，节点执行以下步骤：

1. **消息类型验证** — 验证消息类型为 `SEND_EMAIL`。若不是，节点立即失败并附带错误信息，经 `Failure` 连接路由。

2. **确认** — 若**Force acknowledgement**已启用，入站消息立即被确认并创建副本供后续处理。

3. **异步发送邮件** — 异步发送邮件：
    - 若**Use system SMTP settings**已启用，由平台邮件服务使用系统配置发送邮件
    - 若**Use system SMTP settings**已禁用，使用节点专用配置发送邮件

4. **结果路由**：
    - 成功时，原始消息（或启用强制确认时的消息副本）经 `Success` 连接转发
    - 失败时，在 `error` 键下将错误详情添加到消息 metadata，消息经 `Failure` 连接转发

{% capture message_type_note %}
**重要**：该节点期望接收由「to email」转换节点创建的消息。使用 `Success` 连接将「to email」节点连接至本节点。未正确邮件格式的直接消息将无法通过验证。
{% endcapture %}
{% include templates/warn-banner.md content=message_type_note %}

## 输出连接

- **Success**
    - 邮件已通过 SMTP 服务器成功发送。
- **Failure**
    - 消息类型不是 `SEND_EMAIL`。
    - SMTP 配置错误。
    - 邮件发送操作超时。
    - 处理过程中发生意外错误。

## 示例

### 示例 1 — 使用系统 SMTP 设置发送告警邮件

温度监控系统在温度超过阈值时发送告警邮件。平台配置了 Gmail 账户的系统级 SMTP 设置。强制确认已禁用。

**入站消息**

Type: `SEND_EMAIL`

Data（由「to Email」转换节点准备）：

```json
{
  "to": "alerts@company.com",
  "subject": "High Temperature Alert",
  "body": "<html><body><h2>Temperature Alert</h2><p>Warehouse temperature has exceeded 30°C.</p><p>Current reading: 32.5°C</p></body></html>"
}
```

**节点配置**

```json
{
  "useSystemSmtpSettings": true,
  "smtpHost": "localhost",
  "smtpPort": 25,
  "smtpProtocol": "smtp",
  "timeout": 10000,
  "enableTls": false,
  "tlsVersion": "TLSv1.2",
  "enableProxy": false
}
```

**出站消息**

出站消息与入站消息相同。因强制确认已禁用，邮件成功发送后原始入站消息传递至下一节点。

**结果**

使用平台的系统 SMTP 配置将邮件发送至 `alerts@company.com`。HTML 正文在收件人邮件客户端中正确渲染。随后消息经 `Success` 连接路由。
