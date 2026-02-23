---
layout: docwithnav-pe
assignees:
- stitenko
title: 密钥存储
description: 密钥存储指南

creating-secret:
    0:
        image: /images/user-guide/security/secrets-storage/creating-secret-1-pe.png
        title: '进入「安全」部分的「密钥存储」页面。点击右上角的「plus」（添加密钥）图标。'
    1:
        image: /images/user-guide/security/secrets-storage/creating-secret-2-pe.png
        title: '选择密钥类型：文本或文件。然后输入密钥名称及其文本值（「文本」类型）或上传证书文件（「文件」类型）。点击「添加」。'
    2:
        image: /images/user-guide/security/secrets-storage/creating-secret-3-pe.png
        title: 'ThingsBoard 使用 AES-256 加密算法自动加密密钥值。'

update-secret-value:
    0:
        image: /images/user-guide/security/secrets-storage/update-secret-value-1-pe.png
        title: '点击要更新的密钥旁的「更改值」图标。'
    1:
        image: /images/user-guide/security/secrets-storage/update-secret-value-2-pe.png
        title: '输入新值并点击「保存」。'

delete-secret:
    0:
        image: /images/user-guide/security/secrets-storage/delete-secret-1-pe.png
        title: '点击该行末的「垃圾桶」图标。'
    1:
        image: /images/user-guide/security/secrets-storage/delete-secret-2-pe.png
        title: '确认删除。'

use-secret:
    0:
        image: /images/user-guide/security/secrets-storage/use-secret-in-thingsboard-1-pe.png
        title: '在「密码」字段中点击「密钥」图标以选择并使用密钥。'
    1:
        image: /images/user-guide/security/secrets-storage/use-secret-in-thingsboard-2-pe.png
        title: '若密钥已创建，请选择「使用存储」，从下拉菜单中选取所需密钥，点击「使用」。'
    2:
        image: /images/user-guide/security/secrets-storage/use-secret-in-thingsboard-3-pe.png
        title: '「密码」字段将使用密钥中的值。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/pe/user-guide/secrets-storage.md %}
