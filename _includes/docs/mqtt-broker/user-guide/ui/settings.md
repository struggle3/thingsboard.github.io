
* TOC
{:toc}

{% if docsPrefix != "pe/" %}
{% assign sinceVersion = "2.0" %}
{% include templates/mqtt-broker/since.md %}
{% endif %}

TBMQ 提供专用的 Settings 页面，允许管理员直接在用户界面中管理关键系统配置。
Settings 页面分为三个选项卡，分别对应不同类别的系统配置。

## 安全设置

配置 MQTT 认证提供者的执行顺序，控制客户端凭据验证的优先级。
定义 broker 用户密码策略，包括密码强度要求、过期设置和复用限制，以加强账户安全。

### MQTT 认证

{% include docs/mqtt-broker/user-guide/ui/authentication-settings.md %}

### 密码策略

登录 TBMQ 时，[用户](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/users/)使用邮箱和密码。
您可通过更新安全设置（包括**密码策略**）来提高账户安全性。

例如，可提高最小密码长度、要求大小写混合、指定数字和特殊字符的最少数量。
此外，可设置密码过期周期，确保定期更换密码。

这些措施有助于使用户使用更强、更安全的密码，从而提升整体账户安全。

密码策略规定 TBMQ 用户密码必须满足的规则。可配置以下选项以加强安全：
- **Minimum password length** - 该参数规定密码的最小字符数。最小长度应在 6 到 50 之间，为必填项。
- **Maximum password length** - 该参数规定密码的最大字符数。最大长度应大于最小长度。
- **Minimum number of uppercase letters** - 设置密码中大写字母的最少数量。
- **Minimum number of lowercase letters** - 设置密码中小写字母的最少数量。
- **Minimum number of digits** - 指定密码中数字的最少数量。
- **Minimum number of special characters** - 指定密码中特殊字符的最少数量。
- **Password expiration period in days** - 强制密码过期。过期后 TBMQ 将要求用户修改密码，确保用户定期更新。
- **Password reuse frequency in days** - 禁止在指定天数内重复使用同一密码。例如，若设为 90 天，用户在修改密码后 90 天内无法使用之前的任一密码。
- **Allow whitespace** - 勾选该复选框时，密码中允许包含空格。
- **Force to reset password if not valid** - 密码不符合策略的用户需通过邮件重置密码。**启用此功能时请注意**：将要求密码无效的用户通过[邮件](#mail-server-settings)重置密码。

配置完成后，点击 "Save" 按钮应用更改。 

密码策略更新后，新用户将遵循新规则。
请注意，若已启用 **Force to reset password if not valid**，所有不符合新要求的用户（不仅限于新用户）都将被迫更新密码。

{% capture securityDocumentation %}
其他安全相关设置，请参阅 [Security 文档](/docs/{{docsPrefix}}mqtt-broker/security/overview/)。
{% endcapture %}
{% include templates/info-banner.md content=securityDocumentation %}

#### 修改密码

若需将账户密码修改为符合新要求，请按以下步骤操作：

1. 点击右上角菜单图标，选择 "Account" 打开账户设置。
2. 点击 "Security" 选项卡。
3. 按新规则修改密码。
4. 点击 "Change password"。

{% include images-gallery.html imageCollection="settings-password-policy" %}

## 常规设置

定义 TBMQ UI 中使用的全局 MQTT 连接设置（如默认主机和端口），并配置 WebSocket 客户端行为，
包括活动日志选项和浏览器内消息表的消息保留限制。

### Connectivity

{% include docs/mqtt-broker/user-guide/ui/connectivity-settings.md %}

### WebSocket client

本节可配置与 [WebSocket Client](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/websocket-client/) 相关的额外设置——该浏览器端工具用于管理 MQTT 客户端、订阅主题、接收和发布消息。

* **Log MQTT client activity** 功能可在调试连接问题和监控消息流时提供实时客户端活动日志。
设为 true 时，将在浏览器开发者控制台中看到以下 [MQTT.js](https://github.com/mqttjs/MQTT.js) 事件日志：
  1. **Connect**。 客户端成功连接 broker 时触发。
  2. **Disconnect**。 客户端与 broker 断开时触发。
  3. **Reconnect**。 客户端断开后尝试重连时触发。
  4. **Message**。 客户端收到消息时触发。
  5. **Error**。 通信期间发生错误时触发。
  6. **End**。 客户端正常结束连接时触发。
  7. **Close**。 由客户端或 broker 关闭连接时触发。
  8. **Packet receive**。 从 broker 收到数据包时触发。
  9. **Packet send**。 向 broker 发送数据包时触发。
  10. **Offline**。 客户端离线时触发。
  11. **Outgoing empty**。 所有出站消息已发送时触发。

* **Maximum messages in WebSocket Client table** 设置用于控制 WebSocket 连接在浏览器内存中保留的消息数量上限。

## Mail server settings

{% include docs/mqtt-broker/user-guide/ui/mail-server.md %}
