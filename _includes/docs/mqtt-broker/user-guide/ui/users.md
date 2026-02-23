{% if docsPrefix == null %}
TBMQ 提供单一用户角色：**Administrator**。管理员拥有创建、更新和删除用户账户的完整权限。
{% endif %}

{% if docsPrefix == "pe/" %}
TBMQ PE 包含两个预定义角色：**Administrator** 和 **Viewer**。有关基于角色的访问控制说明，请参阅 [RBAC](/docs/pe/mqtt-broker/security/rbac/)。
{% endif %}

用户管理可通过 TBMQ Web UI 或 [REST API](/docs/{{docsPrefix}}mqtt-broker/user-management/) 进行。

* TOC
{:toc}

## Add user

添加新用户，请按以下步骤操作：

1. 在左侧菜单点击 "Users"，然后点击 _加号图标_ 创建新用户。
2. 填写用户邮箱（系统内必须唯一），名、姓和描述为可选。点击 _Add_ 创建用户。

{% include images-gallery.html imageCollection="add-user-broker" %}

请注意，所有新用户初始默认密码为 `sysadmin`。登录后系统会提示用户修改默认密码。

## Edit user

编辑已有管理员信息，请按以下步骤操作：

1. 在 _Users_ 表中找到目标用户，点击对应行。
2. 点击 _Toggle edit mode_ 按钮，修改名、姓或描述。
3. 点击 _Apply changes_ 按钮保存修改。

{% include images-gallery.html imageCollection="edit-user-broker" %}

## Delete user

已登录用户可删除其他用户，但无法删除自己。删除用户步骤：

1. 在 _Users_ 表中找到用户，点击对应行。
2. 点击 _Delete user_ 按钮，并选择 _Yes_ 确认。

{% include images-gallery.html imageCollection="delete-user-broker" %}

## Login as another user

TBMQ 允许管理员用户在不使用他人凭据或手动认证的情况下，安全地以其他用户身份自动登录。

1. 在 _Users_ 表中找到用户（仅能以其他用户身份登录）。
2. 点击对应行的 _Login_ 按钮。

{% include images-gallery.html imageCollection="login-as-user" %}

{% if docsPrefix == "pe/" %}
## User created via OAuth 2.0

{% include templates/mqtt-broker/security/user-password.md %}

{% endif %}
