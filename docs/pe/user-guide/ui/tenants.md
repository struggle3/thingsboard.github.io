---
layout: docwithnav-pe
assignees:
- ashvayka
title: 租户
description: ThingsBoard 租户管理

tenants-pe:
    0:
        image: /images/user-guide/tenant-profile/PE/create-tenant-1-pe.png
        title: '以系统管理员身份登录ThingsBoard实例WEB UI；'
    1:
        image: /images/user-guide/tenant-profile/PE/create-tenant-2-pe.png
        title: '导航至Tenants页面。然后点击屏幕右上角的"plus"图标；'
    2:
        image: /images/user-guide/tenant-profile/PE/create-tenant-3-pe.png
        title: '为租户指定名称。保留默认租户配置；'
    3:
        image: /images/user-guide/tenant-profile/PE/create-tenant-4-pe.png
        title: '填写您认为重要的字段。然后点击"Add"；'
    4:
        image: /images/user-guide/tenant-profile/PE/create-tenant-5-pe.png
        title: '新租户已创建。'

tenant-new-pe:
    0:
        image: /images/user-guide/tenant-profile/PE/create-user-in-tenant-1-pe.png
        title: '点击租户行的"Manage tenant admins"图标。或者：选择租户并点击，然后点击"Manage tenant admins"按钮；'
    1:
        image: /images/user-guide/tenant-profile/PE/create-user-in-tenant-2-pe.png
        title: '点击右上角的"plus"图标。在"Add User"窗口中指定用户邮箱、输入新用户信息，并从下拉菜单中选择"Show activation link"或"Send activation email"；'
    2:
        image: /images/user-guide/tenant-profile/PE/create-user-in-tenant-3-pe.png
        title: '若选择了"Show activation link"选项，请复制链接地址并发送给用户。点击"OK"；'
    3:
        image: /images/user-guide/tenant-profile/PE/create-user-in-tenant-4-pe.png
        title: '具有租户管理员角色的新用户已创建。'

multiple-users-pe:
    0:
        image: /images/user-guide/tenant-profile/PE/create-user-in-tenant-5-pe.png
        title: '租户可拥有多名用户。'

tenant-edit-pe:
    0:
        image: /images/user-guide/tenant-profile/PE/edit-tenant-1-pe.png
        title: '点击租户名称打开其详情。点击"pencil"图标进入编辑模式；'
    1:
        image: /images/user-guide/tenant-profile/PE/edit-tenant-2-pe.png
        title: '编辑字段。例如，可为该租户的所有用户设置主仪表板。完成后保存所有更改；'
    2:
        image: /images/user-guide/tenant-profile/PE/edit-tenant-3-pe.png
        title: '租户信息已更新。'
    
user-edit-pe:
    0:
        image: /images/user-guide/tenant-profile/PE/edit-user-1-pe.png
        title: '点击用户名称打开其详情。点击"pencil"图标进入编辑模式；'
    1:
        image: /images/user-guide/tenant-profile/PE/edit-user-2-pe.png
        title: '编辑字段。例如，可为该用户设置主仪表板。编辑后保存所有更改；'
    2:
        image: /images/user-guide/tenant-profile/PE/edit-user-3-pe.png
        title: '用户信息已更新。'

user-delete-pe:
    0:
        image: /images/user-guide/tenant-profile/PE/delete-user-2-pe.png
        title: '进入租户。找到要删除的用户。点击"delete"图标并在提示中点击"Yes"确认删除。'
tenant-delete-pe:
    0:
        image: /images/user-guide/tenant-profile/PE/delete-tenant-2-pe.png
        title: '找到要删除的租户。点击"delete"图标并在提示中点击"Yes"确认删除。'

tenant-login-pe:
    0:
        image: /images/user-guide/tenant-profile/PE/login-as-a-tenant-administrator-1-pe.png
        title: '打开租户组。点击用户账户旁的"login"图标以租户管理员身份登录。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ui/tenants-pe.md %}