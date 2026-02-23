* TOC
{:toc}

{% assign sinceVersion = "4.1" %}
{% include templates/since.md %}

**Secrets 存储**用于安全存放和集中管理 API 密钥、令牌、密码、证书等敏感信息。
所有信息以 **Secrets** 形式存储，其值经加密且对最终用户不可见。
敏感数据可在不直接暴露内容的前提下共享或使用。

创建后，Secrets 可安全用于[集成](/docs/user-guide/integrations/){:target="_blank"}和[规则节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node){:target="_blank"}，无需在配置中直接填写敏感信息，从而提升系统安全性并降低未授权访问或数据泄露风险。

**使用 Secrets 存储可：**
- 集中存储和管理敏感数据。
- 通过灵活的 RBAC 管理访问。
- 在不暴露内容的前提下安全共享敏感信息给客户。
- 提高安全性，降低信息泄露风险。

**最佳实践**

- 始终使用 Secrets 存储，避免在代码中硬编码敏感信息。
- 定期更新 Secrets，并按最小权限原则管理访问。

## 创建 Secret

- 前往「**Security**」下的「**Secrets storage**」页面。
- 点击右上角「**plus**」图标（**Add secret**）。
- 选择 **secret 类型**：
  - **File** — 通过上传文件提供值，例如证书。
  - **Text** — 直接输入文本，如密码、令牌或 API 密钥。
- 输入 secret 的 **name** 及 **text value**（「Text」类型）或**上传证书文件**（「File」类型）。
- 点击「**Add**」。

ThingsBoard 使用 AES-256 加密算法自动加密 Secret 值。

{% include images-gallery.html imageCollection="creating-secret" %}

## 更新 Secret 的值

如需更新 Secret 的值和描述，可按以下步骤操作。 
> Secret 的 name 不可修改。

- 点击要更新的 Secret 旁的「**Change value**」图标。
- 输入新值并点击「**Save**」。

{% include images-gallery.html imageCollection="update-secret-value" %}

## 在 ThingsBoard 中使用 Secrets

Secrets 创建后，您及拥有相应权限的用户可将其用于：
- **Rule chains** —— 支持 secret 注入的节点。
- **Integrations** —— 例如填写外部服务和系统账户密码的字段。

支持使用 Secret 的字段会显示钥匙图标。

<object width="35%" data="/images/user-guide/security/secrets-storage/password.png"></object> 

<br>

以 [Loriot 集成](/docs/user-guide/integrations/loriot/){:target="_blank"}为例：无需手动输入 Loriot 账户密码，可使用已创建的 Secret 进行安全访问。

- 在「Password」字段中，点击「key」图标选择并使用 Secret。
- 若 Secret 已创建，选择「**Use storage**」，从下拉菜单中选取目标 **Secret**，点击「**Use**」。

{% include images-gallery.html imageCollection="use-secret" %}

## 管理 Secrets 存储的访问

ThingsBoard 通过 [RBAC](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"} 管理对 Secrets 存储的访问。
仅拥有相应权限的用户可创建、使用、编辑或删除 Secrets。

## 删除 Secret

删除 Secret 时：
- 点击该行末尾的垃圾桶图标。
- 在确认对话框中确认删除。

{% include images-gallery.html imageCollection="delete-secret" %}

> **注意：** 若平台中其他实体仍在使用该 Secret，则无法删除。   
需先在所列实体中移除所有对该 Secret 的引用，再尝试删除。

<object width="70%" data="/images/user-guide/security/secrets-storage/delete-secret-3-pe.png"></object>

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}