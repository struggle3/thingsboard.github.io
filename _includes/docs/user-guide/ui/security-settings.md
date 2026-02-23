* TOC
{:toc}

用户使用用户名和密码登录 ThingsBoard。为提升账户安全，可调整安全设置。配置这些设置需使用 **System Administrator** 账户登录 **ThingsBoard**。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/security-settings/security-settings-general-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/ui/security-settings/security-settings-general-pe.png)
{% endif %}

## 通用策略

本部分可配置用户账户的整体安全规则：

- **Maximum number of failed login attempts** – 设置账户锁定前允许的失败登录次数。

- **Notification on account lockout** – 指定在用户账户被锁定时接收通知的邮箱地址。

- **User activation link TTL** – 定义发送给新用户的激活链接有效期（单位：小时）。超过该时间后链接将失效。

- **Password reset link TTL** – 设置通过邮件发送的密码重置链接的有效期（单位：小时）。

- **Mobile secret key length** – 设定用于移动端认证的密钥长度。

{% capture ttl-limit %}
**注意**：
**User Activation** 和 **Password Reset** 链接的 **TTL** 可在 1 至 24 小时范围内配置。该范围为固定值，不可修改。
{% endcapture %}
{% include templates/info-banner.md content=ttl-limit %}

## 密码策略

密码策略规定 ThingsBoard 用户密码必须满足的规则。可配置以下选项：

- **Minimum password length** - 设置密码最少字符数。最小长度范围为 6 至 50；

- **Maximum password length** - 设置密码最多字符数。最大长度须大于最小长度；

- **Minimum number of uppercase letters** - 设置密码中最少大写字母数；

- **Minimum number of lowercase letters** - 设置密码中最少小写字母数；

- **Minimum number of digits** - 设置密码中最少数字数；

- **Minimum number of special characters** - 设置密码中最少特殊字符数；

- **Password expiration period in days** - 强制密码过期。密码过期后，ThingsBoard 将要求用户修改密码，以确保用户定期更新；

- **Password reuse frequency in days** - 禁止在指定天数内使用相同密码；

- **Allow whitespace** - 勾选后，密码中允许包含空格；

- **Force to reset password if not valid** - 密码不符合验证规则的用户需通过邮件重置密码。

配置完成后，点击 **Save** 按钮应用更改。

## JWT 安全设置

本部分可配置 **ThingsBoard** 用于认证和会话管理的 **JSON Web Token** (JWT) 参数。可控制 token 的生成、过期和签名。

- **Issuer name** – 指定 JWT token 的签发者名称。该值将包含在所有生成的 token 中，可用于验证其来源。

- **Signing key** – 输入 Base64 编码字符串，表示至少 512 位数据。该密钥用于签名 JWT token 并验证完整性。也可使用“Generate key”按钮生成新密钥。

- **Token expiration time** – 设置 JWT token 的有效期（秒）。过期后 token 失效，用户需重新认证。默认值为 9000 秒。最小值为 60 秒。

- **Refresh token expiration time** – 设置 refresh token 的有效期（秒）。Refresh token 允许用户在无需重新认证的情况下获取新的 JWT token。默认值为 604800 秒。最小值为 900 秒。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/security-settings/security-settings-JWT-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/ui/security-settings/security-settings-JWT-pe.png)
{% endif %}


配置完成后，点击 **Save** 按钮应用更改。

## 实用建议

- 配置系统以要求用户使用包含大小写字母、数字和特殊字符的强密码；
- 实施[双因素认证](/docs/{{docsPrefix}}user-guide/two-factor-authentication/){:target="_blank"}以增强安全性。
