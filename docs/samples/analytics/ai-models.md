---
layout: docwithnav
assignees:
- stitenko
title: AI 模型
description: 在 ThingsBoard 中使用 AI 模型

adding-ai-model:
    0:
        image: /images/samples/analytics/ai-models/adding-ai-model-1-ce.png
        title: '进入「<b>设置</b>」的「<b>AI 模型</b>」选项卡，点击右上角的「<b>添加模型</b>」按钮。'
    1:
        image: /images/samples/analytics/ai-models/adding-ai-model-2-ce.png
        title: '打开表单后可配置 AI 模型：<br>- <b>名称</b> - 为 AI 模型指定有意义的名称。<br>- <b>Provider</b> - 选择 AI 提供商并指定其认证凭据。<br>- <b>Model ID</b> - 选择要使用的模型（Azure OpenAI 则为部署名称）。<br>- 如提供商支持，可配置可选参数。<br>- 点击「<b>保存</b>」完成新 AI 模型的添加。'
    2:
        image: /images/samples/analytics/ai-models/adding-ai-model-3-ce.png
        title: '保存后，模型将在规则引擎的 AI 请求节点中可用。'

ai-provider-configuration:
    0:
        image: /images/samples/analytics/ai-models/ai-provider-configuration-1-ce.png
        title: '在「<b>Provider</b>」部分需选择要使用的 <b>AI 提供商</b>及其认证方式（如 API key、key file 等）。'

ai-model-id:
    0:
        image: /images/samples/analytics/ai-models/ai-model-id-1-ce.png
        title: '选择并认证 AI 提供商后，需指定要使用的具体 AI 模型。'

advanced-model-settings:
    0:
        image: /images/samples/analytics/ai-models/advanced-model-settings-1-ce.png
        title: '部分模型支持高级配置参数。'

check-connectivity-1:
    0:
        image: /images/samples/analytics/ai-models/ai-model-check-connectivity-1-ce.png
        title: '点击 <b>Check connectivity</b> 按钮验证配置，将使用提供的凭据和模型设置向提供商 API 发送测试请求。'
    1:
        image: /images/samples/analytics/ai-models/ai-model-check-connectivity-2-ce.png
        title: '响应成功时，将显示 ✅ <b>绿色勾选标记</b>。'

check-connectivity-2:
    0:
        image: /images/samples/analytics/ai-models/ai-model-check-connectivity-3-ce.png
        title: '若出现错误（如无效 API key、不存在的模型），将显示带详细信息的错误提示 ❌。'

---

{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include /docs/samples/analytics/ai-models.md %}