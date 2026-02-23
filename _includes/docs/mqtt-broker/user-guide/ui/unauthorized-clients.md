
* TOC
{:toc}

{% if docsPrefix != "pe/" %}
{% assign sinceVersion = "2.0" %}
{% include templates/mqtt-broker/since.md %}
{% endif %}

MQTT 中的**Unauthorized clients**（未授权客户端）是指因凭据错误、TLS 配置错误等原因尝试连接 MQTT broker 但失败的客户端。

定期查看和分析未授权客户端尝试有助于发现潜在安全威胁和配置错误的客户端。

{% capture unauthorizedClientEnableAuth %}
Unauthorized Clients 功能仅在相应认证方式已[启用](/docs/{{docsPrefix}}mqtt-broker/security/authentication/basic/)时生效。
{% endcapture %}
{% include templates/info-banner.md title="Check configuration" content=unauthorizedClientEnableAuth %}

## Unauthorized Clients 表

在 Authorization 页面的 Unauthorized Clients 选项卡中，可查看并筛选所有未授权客户端连接 broker 的尝试列表。
表包含每项未授权客户端的以下信息：
* **Last update time**。 最近一次连接尝试的时间戳。
* **Client ID**。 尝试连接的客户端唯一标识符。
* **Username**。 客户端提供的用户名。
* **Password**。 是否提供了密码（true/false）。
* **TLS**。 连接尝试是否使用 TLS（true/false）。
* **Client IP**。 尝试连接的客户端 IP 地址。
* **Reason**。 客户端无法连接的文本说明，如 incorrect client credentials。点击 "Show reason" 图标可查看完整说明。

{% include images-gallery.html imageCollection="unauthorized-clients" %}

## 原因说明

每次未授权客户端连接尝试都有 TBMQ 识别并通知用户的特定拒绝访问原因。
这些原因，无论与 Basic 认证、SSL/TLS 或 SCRAM 相关，均在表中清晰列出，便于参考。

### Basic 凭据

以下是与 TBMQ Basic Credentials 相关的客户端无法获得授权的原因，以及概括性示例和可能的解决方案：

1. **No Credentials Found**。 未找到与给定 client ID 和 username 匹配的凭据。
  * **示例**。 客户端提交的 client ID 和 username 与任一已存储凭据均不匹配。
  * **解决方案**。 验证并提供与已存储凭据匹配的正确 client ID 和 username。
2. **Password Does Not Match**。 提供的密码与按 client ID 和 username 找到的凭据不一致。
  * **示例**。 客户端为给定 client ID 和 username 提供了错误密码。
  * **解决方案**。 确保客户端提交正确密码。
3. **No Password Provided**。 未提供密码以匹配按 client ID 和 username 找到的凭据。
  * **示例**。 客户端提交了 client ID 和 username 但未提供密码。
  * **解决方案**。 确保客户端在认证请求中包含密码。
4. **Cannot Parse Basic Credentials**。
  * **示例**。 服务器因配置格式错误无法解析 Basic 凭据。
  * **解决方案**。 验证凭据格式正确且可解析。

### X.509 Certificate Chain 凭据

以下是与 SSL/TLS 相关的客户端无法获得授权的原因：

1. **Failed to Get Client Certificate CN**。
  * **示例**。 TLS 握手失败，因服务器无法提取客户端证书 CN。
  * **解决方案**。 确保客户端证书包含有效的 CN。
2. **X509 Authentication Failure**。 X509 认证过程中发生失败。
  * **示例**。 证书链不被信任，导致 X509 认证失败。
  * **解决方案**。 验证证书链正确且被服务器信任。
3. **Peer Identity Not Verified**。
  * **示例**。 因缺少或无效的证书，服务器无法验证客户端身份。
  * **解决方案**。 确保客户端证书有效且配置正确。
4. **No Certificates in Chain**。 链中无证书可验证客户端身份。
  * **示例**。 客户端证书链为空或不完整。
  * **解决方案**。 提供包含所有必要中间证书的完整证书链。
5. **Failed to Get Certificate CN**。 无法从证书获取 Common Name。
  * **示例**。 服务器尝试提取 CN 但发现缺失。
  * **解决方案**。 确保链中每张证书都包含有效 CN。
6. **No Authorization Rules for CN**。 凭据中未找到所提供 common name 的授权规则。
  * **示例**。 客户端 CN 与任何现有授权规则不匹配。
  * **解决方案**。 在服务器配置中为客户端 CN 添加合适的授权规则。
7. **SSL Handler Not Constructed**。 因 SSL handler 未构建，无法使用 X509 凭据认证客户端。
  * **示例**。 服务端 SSL handler 未正确构建或初始化。
  * **解决方案**。 检查服务器配置，确保 SSL handler 正确设置并初始化。
8. **No Matching X509 Credentials Found**。
  * **示例**。 服务器未找到任何与客户端证书链匹配的 X509 凭据。
  * **解决方案**。 验证服务器已正确配置 X509 凭据。
9. **Cannot Parse SSL Credentials**。
  * **示例**。 服务器因配置格式错误无法解析 X.509 Certificate Chain 凭据。
  * **解决方案**。 确保凭据格式正确且可解析。

## 管理 Unauthorized Clients

从 Unauthorized Clients 表中删除未通过认证的客户端，请按以下步骤操作：
1. 在 _Authentication_ - _Unauthorized Clients_ 表中找到客户端，点击删除图标。
2. 选择 _Yes_ 确认操作。

删除所有未授权客户端：
1. 点击 "Delete all unauthorized clients" 按钮。
2. 点击 _Yes_ 确认删除所有客户端。

{% include images-gallery.html imageCollection="delete-unauthorized-client" %}
