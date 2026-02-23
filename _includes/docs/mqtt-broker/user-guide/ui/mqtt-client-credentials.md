* TOC
{:toc}

TBMQ 支持通过 Web UI 和 [REST API](/docs/{{docsPrefix}}mqtt-broker/mqtt-client-credentials-management/) 管理 MQTT 客户端凭据的多种方式。

TBMQ 支持以下类型的客户端凭据以认证客户端连接：
- [Basic](/docs/{{docsPrefix}}mqtt-broker/security/#basic-authentication) - 基于 client ID、username 和 password 组合的基础安全措施。
  - **优点：** 简单易实现，应用和服务广泛支持，网络开销低。
  - **缺点：** 安全性有限。
- [X.509 Certificate Chain](/docs/{{docsPrefix}}mqtt-broker/security/#tls-authentication) - 基于 X509 证书链的高级安全措施，用于验证客户端身份。
  - **优点：** 相比基础凭据安全性更高。使用 SSL 客户端凭据时，客户端与 TBMQ 可相互认证。
  SSL 客户端凭据在访问控制上更灵活，可根据证书主题名等属性制定更细粒度的访问控制策略。
  - **缺点：** 配置和管理较复杂，成本更高。SSL 加密和解密需要更多计算资源。
- **SCRAM** - 使用 Salted Challenge Response Authentication Mechanism (SCRAM) 的高级安全措施，提供基于密码的安全认证（MQTT 5.0 增强认证特性）。
  - **优点：** 比 basic 认证安全性更高。采用 challenge-response 交换哈希凭据，确保密码不以明文传输。
  - **缺点：** 生成和验证加盐密码哈希需要额外计算资源。

使用上述任一客户端凭据类型前，请确保已[启用](/docs/{{docsPrefix}}mqtt-broker/security/authentication/basic/)相应的 _Authentication_。

更多安全相关说明，请参阅本[指南](/docs/{{docsPrefix}}mqtt-broker/security/overview/)。

## 添加 MQTT 客户端凭据

添加新客户端凭据，请按以下步骤操作：

1. 进入 _Authentication_ - _Credentials_ 页面，点击以加号图标表示的 Add _Client Credentials_ 按钮。
2. 填写 Name 字段（不必唯一）。
3. 选择适用的 _Client Type_：
   - **Device**。 适用于通常发布大量消息、仅订阅少量低频主题的客户端，即 IoT 设备。
   - **Application**。 适用于订阅高消息率主题且在离线时需消息持久化的客户端，如 **ThingsBoard、AWS IoT Core** 等应用。
   
   有关客户端类型的更多信息，请参阅[文档](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type/)。

4. 选择所需的 _Credentials Type_，并配置认证参数和授权规则。

{% include images-gallery.html imageCollection="add-client-credentials" %}

### MQTT Basic 凭据

#### 认证

MQTT Basic 认证基于 client ID、username 和/或 password 的不同组合：
- **Client ID** - 验证连接客户端是否具有指定 clientId。
- **Username** - 验证连接客户端是否具有指定 username。
- **Client ID and username** - 验证连接客户端是否同时具有指定 clientId 和 username。
- **Username and password** - 验证连接客户端是否同时具有指定 username 和 password。
- **Client ID and password** - 验证连接客户端是否同时具有指定 clientId 和 password。
- **Client ID, username and password** - 验证连接客户端是否具有指定 clientId、username 和 password。

{% include templates/mqtt-broker/authorization-rules.md %}

#### 修改 MQTT Basic 凭据密码

Broker 管理员可修改 MQTT Basic 客户端凭据的密码。操作步骤：
1. 进入 _Authentication_ - _Client Credentials_ 页面。
2. 点击对应 Credentials 行。
3. 点击 _Change password_ 按钮。
4. 输入当前密码、设置新密码并确认。

{% include images-gallery.html imageCollection="change-password-basic-credentials" %}

### X.509 证书链凭据

**X.509 Certificate chain** 是一种基于公钥证书链的 TLS 双向认证方式。

#### 认证

凭据中 "Use certificate CN regex" 参数支持两种认证选项。
根据该参数，TBMQ 可使用证书的 Common Name (CN) 精确匹配认证客户端，或使用特定正则匹配并授权客户端，
在客户端验证上提供灵活性。

* **Certificate common name (CN)** 应**完全**匹配客户端的证书 CN，若存在父证书则需匹配其中之一的 CN。
  若链中任一证书的 CN 都不相同，认证将失败。
* **Certificate common name (CN) regex** 应与客户端证书的 CN 或（若存在）父证书之一的 CN 匹配。
  若链中任一证书的 CN 都不与该正则匹配，认证将失败。

{% include images-gallery.html imageCollection="security-authentication-tls" %}

#### 授权规则

授权规则用于控制认证成功的客户端可发布/订阅的主题，基于以下条件的成功组合：

* **Client certificate CN matcher regex** - 应与客户端证书的 CN 匹配。
* **Publish/subscribe authorization rule patterns** - 控制匹配 Client certificate CN matcher regex 的客户端可发布/订阅的主题。

请参考以下示例：
* 若客户端证书的 CN 为 `cn_example_1` - 将 Client certificate CN matcher regex 设为 `cn_example_1`、`example_1` 或 `.*example.*`。
* 若 Publish authorization rule patterns 设为 `pub_topic/one/.*, pub_topic/two/.*` - 客户端只能发布到以 `pub_topic/one/` 或 `pub_topic/two/` 开头的主题。
* 若 Subscribe authorization rule patterns 使用默认值 `.*` - 客户端可订阅任意主题。
* 若 Publish/Subscribe authorization rules 为空 - 客户端将无法发布/订阅任何主题。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/ssl-credentials-authorization.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/ssl-credentials-authorization.png)
{% endif %}

### SCRAM

**SCRAM**（Salted Challenge Response Authentication Mechanism）是 MQTT 5 客户端的增强认证方式，基于 **username 和 password**。

#### 认证

* **Username** - 客户端的唯一标识符，与 password 配合用于认证。
* **Password** - 仅用户和服务器知晓的密钥。密码在存储和认证前会加盐并哈希。

{% include templates/mqtt-broker/authorization-rules.md %}

## 删除客户端凭据

Broker 管理员可通过 Web UI 或 [REST API](/docs/{{docsPrefix}}mqtt-broker/mqtt-client-credentials-management/) 从 TBMQ 系统中移除客户端凭据。

删除客户端凭据的方式：
1. **单条删除**。
   - 点击凭据对应行的 _Delete_ 图标并确认。
   - 点击凭据行后点击 _Delete Client Credentials_ 按钮。
2. **批量删除**。
   * 勾选复选框选择多条，再点击右上角 _Delete_ 图标并确认。

{% include images-gallery.html imageCollection="delete-client-credentials" %}

## 检查连接

“Check Connectivity” 工具可自动生成用于**订阅主题**和**发布消息**的命令。
该功能使用用户配置的 host、port 和客户端凭据生成所需命令。 

仅支持 [Basic](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/mqtt-client-credentials/#mqtt-basic-credentials) 凭据。

打开包含命令的窗口步骤：
1. 点击 "Check connectivity" 按钮打开对应窗口。
2. 在窗口中选择操作系统。
3. 按指南中的命令安装所需客户端工具。
4. 复制并执行命令。

{% include images-gallery.html imageCollection="check-connectivity" %}

若客户端凭据包含密码，请确保将 "$YOUR_PASSWORD" 替换为实际密码。
以下是带密码凭据的示例命令：

```bash
mosquitto_sub -d -q 1 -h localhost -p 1883 -t tbmq/demo/+ -i "tbmq_eJzCIh6r" -u "tbmq_un_VxUVPaF8" -P "$YOUR_PASSWORD" -v
mosquitto_pub -d -q 1 -h localhost -p 1883 -t tbmq/demo/topic -i "tbmq_eJzCIh6r" -u "tbmq_un_VxUVPaF8" -P "$YOUR_PASSWORD" -m 'Hello World'
```

若客户端配置的 subscribe/publish **Authorization rule patterns** 与默认值 `.*`（允许任意主题）不同，表示客户端对发布或订阅有主题限制。
此时需将 "$YOUR_TOPIC" 替换为客户端被允许操作的主题。
