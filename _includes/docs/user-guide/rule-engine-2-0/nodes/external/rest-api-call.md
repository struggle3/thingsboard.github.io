向外部端点发送 HTTP 请求，支持可配置的请求方法、请求头、认证和代理设置。支持 GET、POST、PUT、PATCH 和 DELETE 操作，及包括 TLS/SSL 加密在内的多种认证方式。

## 配置

### 端点 URL 模式

指定请求将发送到的端点 URL。支持[模板](/docs/{{docsPrefix}}user-guide/templatization/)。

### 请求方法

请求使用的 HTTP 方法。可用选项：**GET**、**POST**、**PUT**、**PATCH**、**DELETE**。

### 请求头

要包含在请求中的 HTTP 头键值对。键和值均支持[模板](/docs/{{docsPrefix}}user-guide/templatization/)。

### 消息设置

#### 解析为纯文本

控制在发送前如何处理消息 data：

- **Disabled**（默认）— 消息 data 原样发送
- **Enabled** — 若消息 data 为 JSON 编码的字符串（用双引号包裹），则移除外层 JSON 编码

**示例**：

消息 data：`"\"Temperature is 25.5°C\""`

- Parse to plain text **OFF**：发送 `"\"Temperature is 25.5°C\""`（带 JSON 编码）
- Parse to plain text **ON**：发送 `"Temperature is 25.5°C"`（无外层引号）

{% capture parse_note %}
**注意**：此设置仅影响 JSON 编码的字符串（用双引号包裹的字符串）。普通 JSON 对象如 `{"temperature":25.5}` 无论如何设置均原样发送。
{% endcapture %}
{% include templates/info-banner.md content=parse_note %}

#### 不包含请求体

- **Disabled**（默认）— POST、PUT、PATCH、DELETE 的请求体包含消息 data
- **Enabled** — 不发送请求体，即使对于通常包含请求体的方法

{% capture attachment_note %}
**注意**：启用请求体时，若消息 metadata 包含 blob 实体 ID 的 `attachments` 字段，将使用第一个 blob 实体的内容作为请求体，而非消息 data。
{% endcapture %}
{% include templates/info-banner.md content=attachment_note %}

### 连接设置

#### 读取超时（毫秒）

等待服务器响应的最大时间（毫秒）。

- **0**（默认）— 无限超时（永久等待）
- **> 0** — 在指定毫秒后超时

#### 最大并行请求数

限制节点可发送的并发请求数。

- **0**（默认）— 并行处理无限制
- **> 0** — 可同时进行中的最大请求数

达到限制时，新消息需等待有请求完成。若等待时间超过读取超时，消息将因超时错误失败。

#### 最大响应大小（KB）

可在内存中缓冲的 HTTP 响应体最大大小。超过此限制的响应将失败并报错。默认：256 KB

系统通过 `tb.http.maxInMemoryBufferSizeInKb` 系统属性（默认：25000 KB）强制执行最大限制。若配置值超过该限制，节点将无法初始化。

### 代理设置

#### 启用代理

- **Disabled**（默认）— 直接连接端点
- **Enabled** — 通过代理服务器路由请求

启用后，可选择手动配置代理或使用系统代理属性。

#### Use system proxy properties

当**Enable proxy**已启用时，此选项决定代理配置来源：

- **Disabled**（默认）— 在下方手动配置代理
- **Enabled** — 使用系统代理属性

**系统属性**（至少需配置一组）：

HTTP 代理：

- `http.proxyHost` — HTTP 代理主机名
- `http.proxyPort` — HTTP 代理端口

HTTPS 代理：

- `https.proxyHost` — HTTPS 代理主机名
- `https.proxyPort` — HTTPS 代理端口

SOCKS 代理：

- `socksProxyHost` — SOCKS 代理主机名
- `socksProxyPort` — SOCKS 代理端口
- `socksProxyVersion` — SOCKS 版本（4 或 5，默认 5）

**认证属性**（用于所有代理类型）：

- `tb.proxy.user` — 代理用户名
- `tb.proxy.password` — 代理密码

{% capture proxy_note %}
**注意**：若启用系统代理属性但未配置，节点将无法初始化。
{% endcapture %}
{% include templates/info-banner.md content=proxy_note %}

#### Manual proxy configuration

当**Use system proxy properties**为禁用时，手动配置代理：

- **Proxy host** — 代理服务器的主机名或 IP 地址
- **Proxy port** — 代理服务器的端口号（1-65535）
- **Proxy user** — 代理认证用户名
- **Proxy password** — 代理认证密码

### Credentials

连接端点的认证凭据。可用凭据类型：

#### Anonymous

不提供认证。当端点允许匿名访问或通过请求头处理认证时使用。

#### Basic

使用用户名和密码的 HTTP Basic 认证。

**配置**：

- **Username** — 认证用户名
- **Password** — 认证密码

凭据会自动编码并以 `Basic <base64-encoded-credentials>` 格式在 `Authorization` 头中发送。

#### PEM Certificate

使用 PEM 编码文件的基于证书认证。提供双向 TLS 认证。

**配置**：

- **Server CA certificate file** — 签署服务器证书的证书颁发机构（CA）证书。用于验证服务器身份。
- **Client certificate file** — 客户端的公钥证书。发送给服务器用于客户端认证。
- **Client private key file** — 与客户端证书对应的客户端私钥。
- **Private key password** — 私钥文件加密时的密码。

{% capture cert_requirement_note %}
**注意**：使用 PEM 凭据时，需提供 Server CA 证书文件，或同时提供 Client 证书与 Client 私钥文件。
{% endcapture %}
{% include templates/info-banner.md content=cert_requirement_note %}

{% capture credentials_note %}
**注意**：证书和密钥文件可直接上传，或从[Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"}引用以增强安全性。
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

### Advanced settings

#### Force acknowledgement

强制确认机制由 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 环境变量控制。当该变量设为 `true` 时，适用于包括本 REST API 调用节点在内的所有外部节点。

**启用强制确认时的行为**：

- 入站消息立即被确认
- 执行 HTTP 请求
- 请求完成后，响应放入新消息
- 新消息加入队列供下一节点处理
- 可避免慢速端点导致的消息处理超时

**禁用强制确认时**（默认）：

- 原始入站消息在 HTTP 请求完成前保持占用
- 原始消息用响应数据转换
- 转换后的消息传递至下一节点

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbRestApiCallNodeConfiguration",
  "type": "object",
  "properties": {
    "restEndpointUrlPattern": {
      "type": "string",
      "minLength": 1,
      "description": "Endpoint URL (supports templatization)."
    },
    "requestMethod": {
      "type": "string",
      "enum": [
        "GET",
        "POST",
        "PUT",
        "PATCH",
        "DELETE"
      ],
      "description": "HTTP request method."
    },
    "headers": {
      "type": "object",
      "additionalProperties": {
        "type": "string"
      },
      "description": "HTTP headers as key-value pairs (supports templatization)."
    },
    "readTimeoutMs": {
      "type": "integer",
      "minimum": 0,
      "description": "Read timeout in milliseconds (0 = infinite)."
    },
    "maxParallelRequestsCount": {
      "type": "integer",
      "minimum": 0,
      "description": "Maximum concurrent requests (0 = unlimited)."
    },
    "parseToPlainText": {
      "type": "boolean",
      "description": "Whether to convert JSON message data to plain text."
    },
    "enableProxy": {
      "type": "boolean",
      "description": "Whether to use proxy server."
    },
    "useSystemProxyProperties": {
      "type": "boolean",
      "description": "Whether to use system proxy properties."
    },
    "proxyHost": {
      "type": "string",
      "description": "Proxy server hostname (when not using system properties)."
    },
    "proxyPort": {
      "type": "integer",
      "minimum": 1,
      "maximum": 65535,
      "description": "Proxy server port (when not using system properties)."
    },
    "proxyUser": {
      "type": "string",
      "description": "Proxy authentication username."
    },
    "proxyPassword": {
      "type": "string",
      "description": "Proxy authentication password."
    },
    "credentials": {
      "type": "object",
      "description": "Authentication credentials for the endpoint."
    },
    "ignoreRequestBody": {
      "type": "boolean",
      "description": "Whether to exclude request body for POST/PUT/PATCH/DELETE."
    },
    "maxInMemoryBufferSizeInKb": {
      "type": "integer",
      "minimum": 1,
      "description": "Maximum in-memory buffer size in KB."
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-4 }

## 规则节点初始化

规则节点初始化时，会创建具有已配置设置的 HTTP 客户端。客户端使用连接池，最大连接数可通过 `TB_RE_HTTP_CLIENT_POOL_MAX_CONNECTIONS` 环境变量配置（默认由 Reactor Netty 库决定）。

初始化完成后，客户端即可处理消息。

## 消息处理

对每条入站消息，节点执行以下步骤：

1. 若**Force acknowledgement**已启用，入站消息立即被确认。
2. 若配置了**Max number of parallel requests**，节点等待可用槽位。若在读取超时时间内无可用槽位，消息将因超时错误失败。
3. 节点处理**Endpoint URL pattern**，用入站消息 data 和 metadata 中的值替换模板以构建最终 URL。
4. 准备 HTTP 头：
    - 添加已配置的头并经模板处理
    - 对于 Basic 凭据，添加带 base64 编码凭据的 `Authorization` 头
5. 准备请求体：
    - 若**Without request body**已启用，不发送请求体
    - 否则，对于 POST、PUT、PATCH、DELETE 方法：
        - 若消息 metadata 包含 blob 实体 ID 的 `attachments` 字段，使用第一个 blob 实体的内容作为请求体
        - 否则使用消息 data 作为请求体
        - 若**Parse to plain text**已启用，解除 JSON 编码字符串的外层包装
6. 将 HTTP 请求发送至端点。
7. 收到响应后：
    - 成功（2xx 状态码）：将响应信息添加到消息，并经 `Success` 连接转发
    - 失败（非 2xx 状态码或异常）：将错误信息添加到消息，并经 `Failure` 连接转发
    - 响应/错误信息的结构详见「Outgoing message format」部分
8. 若配置了**Max number of parallel requests**，释放请求槽位供下一条消息使用。

## 出站消息格式

**成功**（2xx 响应）：

消息 metadata 中添加以下键：

- `status` — HTTP 状态名称（如 "OK"、"CREATED"）
- `statusCode` — HTTP 状态码（如 "200"、"201"）
- `statusReason` — HTTP 状态原因短语
- 响应头 — 每个响应头作为 metadata 键值对添加
    - 单值头：作为字符串值添加
    - 多值头：作为 JSON 数组字符串添加

消息 data 替换为响应体。若无响应体，data 设为 `{}`。

**失败**（非 2xx 响应或异常）：

消息 metadata 中添加以下键：

- `error` — 格式为 `ExceptionClass: error message` 的错误描述
- `status` — HTTP 状态名称（若有）
- `statusCode` — HTTP 状态码（若有）
- `statusReason` — HTTP 状态原因短语（若有）
- `error_body` — 失败请求的响应体（若有）
- 响应头（若有）

消息 data 保持与原始消息相同。

**强制确认行为**：

当**Force acknowledgement**禁用时，原始入站消息用上述响应信息转换。

当**Force acknowledgement**启用时，创建包含上述响应信息的新消息。

## 输出连接

- **Success**
    - HTTP 请求成功完成且状态码为 2xx
- **Failure**
    - HTTP 请求返回非 2xx 状态码
    - 因网络问题、超时或连接错误导致请求失败
    - 处理过程中发生意外错误
    - 等待可用请求槽位时超时

## 示例

### 示例 1

智能设备需向外部设备管理系统发送控制命令并接收执行结果。端点需要 Basic 认证，期望请求体为 JSON 命令。强制确认已禁用。

**入站消息**

Originator: `DEVICE`（Smart Lock）

Data:

```json
{
  "command": "unlock",
  "duration": 30,
  "reason": "owner_request"
}
```

Metadata:

```json
{
  "deviceId": "lock-bedroom-01",
  "deviceType": "smartLock"
}
```

**节点配置**

```json
{
  "restEndpointUrlPattern": "https://api.smart-home.com/v1/devices/${deviceId}/commands",
  "requestMethod": "POST",
  "headers": {
    "Content-Type": "application/json"
  },
  "readTimeoutMs": 5000,
  "maxParallelRequestsCount": 10,
  "parseToPlainText": false,
  "enableProxy": false,
  "credentials": {
    "type": "basic",
    "username": "api-client",
    "password": "secure-password"
  },
  "ignoreRequestBody": false,
  "maxInMemoryBufferSizeInKb": 256
}
```

**出站消息**（假设成功响应，状态码 200）

Data:

```json
{
  "commandId": "cmd-98765",
  "status": "executed",
  "executedAt": "2023-01-01T10:30:00Z",
  "result": {
    "success": true,
    "lockState": "unlocked",
    "autoLockIn": 30
  }
}
```

Metadata:

```json
{
  "deviceId": "lock-bedroom-01",
  "deviceType": "smartLock",
  "status": "OK",
  "statusCode": "200",
  "statusReason": "OK",
  "Content-Type": "application/json",
  "X-Request-Id": "req-789xyz"
}
```

**结果**

节点构建端点 URL 为 `https://api.smart-home.com/v1/devices/lock-bedroom-01/commands`，准备以下请求头：

- `Content-Type: application/json`
- `Authorization: Basic YXBpLWNsaWVudDpzZWN1cmUtcGFzc3dvcmQ=`

请求体包含命令：`{"command":"unlock","duration":30,"reason":"owner_request"}`，发送 POST 请求。

命令已成功发送至外部端点。响应确认命令执行并返回当前锁状态。消息经 `Success` 连接路由，执行结果可供下游节点进一步处理。
