---
layout: docwithnav-pe
assignees:
- stitenko
title: API 密钥
description: 管理 API 密钥
redirect_from: "docs/pe/user-guide/ui/api-keys"

creating-api-key-for-our-account:
    0:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-1-pe.png
        title: '点击右上角 <b>三点</b> 菜单，选择 <b>账户</b>。'
    1:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-2-pe.png
        title: '进入 <b>安全</b> 选项卡。在 <b>API 密钥</b> 部分点击 <b>管理</b> 按钮。'
    2:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-3-pe.png
        title: '点击 <b>+ 生成</b> 按钮。'
    3:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-4-pe.png
        title: '输入 API 密钥的 <b>描述</b>，选择过期时间，点击 <b>生成</b>。'
    4:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-5-pe.png
        title: '<b>复制并保存</b> 生成的 API 密钥 — 将不会再次显示。'
    5:
        image: /images/user-guide/security/api-keys/creating-api-key-for-our-account-6-pe.png
        title: ''

creating-api-key-for-another-user:
    0:
        image: /images/user-guide/security/api-keys/creating-api-key-for-another-user-1-pe.png
        title: '进入 <b>客户</b>/<b>用户</b> 部分。<br>点击目标用户打开其 <b>详情</b>。<br>进入 <b>API 密钥</b> 选项卡并点击 <b>+ 生成</b> 按钮。'
    1:
        image: /images/user-guide/security/api-keys/creating-api-key-for-another-user-2-pe.png
        title: '输入 API 密钥的 <b>描述</b>，选择过期时间，点击 <b>生成</b>。'
    2:
        image: /images/user-guide/security/api-keys/creating-api-key-for-another-user-3-pe.png
        title: '<b>复制并保存</b> 生成的 API 密钥 — 将不会再次显示。'
    3:
        image: /images/user-guide/security/api-keys/creating-api-key-for-another-user-4-pe.png
        title: ''

authentication-in-swagger-ui:
    0:
        image: /images/user-guide/security/api-keys/authentication-in-swagger-ui-1.png
        title: '可在 Swagger 页面右侧点击 <b>Authorize</b> 按钮，以其他用户身份进行认证或授权。'
    1:
        image: /images/user-guide/security/api-keys/swagger-ui-2.png
        title: '在 API 密钥表单（apiKey）部分粘贴您的 API 密钥。<br>然后点击「Authorize」。'

managing-api-keys-1:
    0:
        image: /images/user-guide/security/api-keys/managing-api-keys-1-pe.png
        title: '在 API 密钥表中，每个密钥显示其创建时间、描述、状态和过期日期。'

managing-api-keys-2:
    0:
        image: /images/user-guide/security/api-keys/managing-api-keys-2-pe.png
        title: '对每个 API 密钥可执行：启用或禁用、删除、编辑描述。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/security/api-keys.md %}