---
layout: docwithnav
assignees:
- stitenko
title: API keys
description: 管理 API keys
redirect_from: "docs/user-guide/ui/api-keys"

creating-api-key-for-our-account:
    0:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-1-ce.png
        title: '点击右上角的 <b>three-dot</b> 菜单，选择 <b>Account</b>。'
    1:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-2-ce.png
        title: '进入 <b>Security</b> 标签。在 <b>API keys</b> 区域点击 <b>Manage</b> 按钮。'
    2:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-3-ce.png
        title: '点击 <b>+ Generate</b> 按钮。'
    3:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-4-ce.png
        title: 'Enter a <b>description</b> for the API key, select the expiration period, and click <b>Generate</b>.'
    4:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-5-ce.png
        title: '<b>复制并保存</b> 生成的 API key，之后将不再显示。'
    5:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-6-ce.png
        title: ''

creating-api-key-for-another-user:
    0:
        image: /images/user-guide/security/api-keys/creating-api-key-for-another-user-1-ce.png
        title: '进入 <b>Customers</b> 区域。<br>点击目标用户打开其 <b>details</b>。<br>进入 <b>API keys</b> 标签，点击 <b>+ Generate</b> 按钮。'
    1:
        image: /images/user-guide/security/api-keys/creating-api-key-for-another-user-2-ce.png
        title: 'Enter a <b>description</b> for the API key, select the expiration period, and click <b>Generate</b>.'
    2:
        image: /images/user-guide/security/api-keys/creating-api-key-for-another-user-3-ce.png
        title: '<b>复制并保存</b> 生成的 API key，之后将不再显示。'
    3:
        image: /images/user-guide/security/api-keys/creating-api-key-for-another-user-4-ce.png
        title: ''

authentication-in-swagger-ui:
    0:
        image: /images/user-guide/security/api-keys/authentication-in-swagger-ui-1.png
        title: '点击 Swagger 页面右侧的 <b>Authorize</b> 按钮，可手动以另一用户身份认证或授权。'
    1:
        image: /images/user-guide/security/api-keys/swagger-ui-2.png
        title: '在 API key 表单（apiKey）区域粘贴您的 API key。<br>然后点击 "Authorize"。'

managing-api-keys-1:
    0:
        image: /images/user-guide/security/api-keys/managing-api-keys-1-ce.png
        title: '在 API keys 表格中，每个 key 显示创建时间、description、状态和过期时间。'

managing-api-keys-2:
    0:
        image: /images/user-guide/security/api-keys/managing-api-keys-2-ce.png
        title: '对每个 API key，可执行以下操作：启用/禁用 key、删除 key 或编辑其 description。'


---

{% include get-hosts-name.html %}
{% include docs/user-guide/security/api-keys.md %}