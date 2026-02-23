---
layout: docwithnav-paas-eu
assignees:
- ashvayka
title: REST API
description: 支持服务端集成的 REST API 参考

swagger-ui:
    0:
        image: /images/user-guide/security/api-keys/authentication-in-swagger-ui-1.png
        title: '可点击 Swagger 页面右侧的 <b>Authorize</b> 按钮，以另一用户身份手动认证或授权。'
    1:
        image: /images/user-guide/security/api-keys/authentication-in-swagger-ui-2.png
        title: '输入用户名和密码，或将 API 密钥粘贴到 API 密钥表单（apiKey）中。<br>然后点击 <b>Authorize</b>。'

---

{% assign docsPrefix = "paas/eu/" %}
{% include get-hosts-name.html docsTag="paas-eu" %}
{% include docs/reference/rest-api.md %}
