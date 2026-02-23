---
layout: docwithnav-pe
assignees:
- ashvayka
title: 用户
description: ThingsBoard 用户管理

users-intro-pe:
    0:
        image: /images/user-guide/ui/users/pe/users-intro-pe.png
        title: '两个自动生成的用户组：具有全部权限的Tenant Administrators组和具有只读权限的Tenant Users组。'

create-user-pe:
    0:
        image: /images/user-guide/ui/users/pe/create-user-1-pe.png
        title: '以<b>Tenant Administrator</b>或<b>Customer Administrator</b>身份登录。从左侧菜单导航至"<b>Users</b>"部分。点击右上角的"<b>Add user</b>"按钮。'
    1:
        image: /images/user-guide/ui/users/pe/create-user-2-pe.png
        title: '填写用户表单：提供用户邮箱地址（用作登录用户名）；<b>可选字段</b>：输入<b>first name</b>、<b>last name</b>和<b>phone number</b>等附加信息。（可选）配置<b>activation method</b>：选择<b>Display activation link</b>或<b>Send activation email</b>。<br>（可选）更改所有权并分配权限。'
    2:
        image: /images/user-guide/ui/users/pe/create-user-3-pe.png
        title: '<b>Assign ownership</b>并将用户加入具有相应权限的<b>specific user group</b>。点击"<b>Add</b>"创建用户。'
    3:
        image: /images/user-guide/ui/users/pe/create-user-4-pe.png
        title: '若选择了"<b>Display activation link</b>"选项，需要<b>复制激活链接</b>。'
    4:
        image: /images/user-guide/ui/users/pe/create-user-5-pe.png
        title: '用户已创建。<b>将激活链接发送</b>给用户以便其激活账户。'

log-in-as-user:
    0:
        image: /images/user-guide/ui/users/pe/log-in-as-user-1-pe.png
        title: '进入用户列表，点击目标用户姓名旁的<b>"login"图标</b>。'
    1:
        image: /images/user-guide/ui/users/pe/log-in-as-user-2-pe.png
        title: '这使您可以该用户身份临时访问平台，便于测试权限或排查访问问题。'
    2:
        image: /images/user-guide/ui/users/pe/log-in-as-user-3-pe.png
        title: '本例中用户具有只读权限。他们可查看仪表板或设备等资源，但不能添加、编辑或删除任何对象。'

user-activation:
    0:
        image: /images/user-guide/ui/users/pe/user-activation-1-pe.png
        title: '<b>点击激活链接</b>，或复制并粘贴到浏览器地址栏后按<b>Enter</b>。系统将提示<b>创建密码</b>。输入两次所需密码以确认。点击"<b>Create Password</b>"。'
    1:
        image: /images/user-guide/ui/users/pe/user-activation-2-pe.png
        title: '完成此步骤后，用户将登录其实例，并根据所分配的权限访问资源。'

user-manage-owner-and-groups:
    0:
        image: /images/user-guide/ui/users/pe/user-manage-owner-and-groups-1-pe.png
        title: '点击用户打开其<b>details</b>视图，点击"<b>Manage owner and groups</b>"按钮。'
    1:
        image: /images/user-guide/ui/users/pe/user-manage-owner-and-groups-2-pe.png
        title: '执行所需操作：从下拉列表选择<b>new owner</b>或用户；将用户添加到一个或多个<b>existing user groups</b>，或<b>create a new group</b>。点击"<b>Update</b>"确认并应用更改。'
    2:
        image: /images/user-guide/ui/users/pe/user-manage-owner-and-groups-3-pe.png
        title: '在<b>"Groups"列</b>中可查看用户已加入的组名。'

delete-user:
    0:
        image: /images/user-guide/ui/users/pe/delete-user-1-pe.png
        title: '从<b>Users</b>屏幕导航至"<b>Groups</b>"选项卡，点击要删除组行末的<b>"trash bin"图标</b>(🗑)️。'
    1:
        image: /images/user-guide/ui/users/pe/delete-user-2-pe.png
        title: '在对话框提示中确认删除。'

add-user-group:
    0:
        image: /images/user-guide/ui/users/pe/add-user-group-1-pe.png
        title: '从<b>Users</b>屏幕导航至"<b>Groups</b>"选项卡。点击右上角的"<b>+</b>"(<b>Add entity group</b>)图标。'
    1:
        image: /images/user-guide/ui/users/pe/add-user-group-2-pe.png
        title: '输入新用户组的<b>name</b>并点击"<b>Add</b>"创建组。'
    2:
        image: /images/user-guide/ui/users/pe/add-user-group-3-pe.png
        title: '创建后，可将用户添加到此组并配置组级权限以控制对特定实体、仪表板或功能的访问。'
      
assigning-permissions-to-user-group:
    0:
        image: /images/user-guide/ui/users/pe/add-user-group-4-pe.png
        title: '在Users部分的"<b>Groups</b>"选项卡中，点击目标用户组旁的<b>"pencil"(✏️)图标</b>。'
    1:
        image: /images/user-guide/ui/users/pe/add-user-group-5-pe.png
        title: '在组详情视图中，导航至"<b>Roles</b>"选项卡。点击<b>"+"(Add)</b>为组分配角色。'
    2:
        image: /images/user-guide/ui/users/pe/add-user-group-6-pe.png
        title: '在对话框中：选择<b>role type</b>、选择此前创建的<b>specific role</b>，点击"<b>Add</b>"将角色应用于组。'
    3:
        image: /images/user-guide/ui/users/pe/add-user-group-7-pe.png
        title: '完成后，该组中的所有用户将继承<b>所选角色定义的权限</b>。'

delete-user-group:
    0:
        image: /images/user-guide/ui/users/pe/delete-user-group-1-pe.png
        title: '从<b>Users</b>屏幕导航至"<b>Groups</b>"选项卡，点击要删除组行末的<b>"trash bin"图标</b>(🗑)️。'
    1:
        image: /images/user-guide/ui/users/pe/delete-user-group-2-pe.png
        title: '在对话框提示中确认删除。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ui/users-pe.md %}
