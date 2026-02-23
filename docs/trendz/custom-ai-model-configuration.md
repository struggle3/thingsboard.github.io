---
layout: docwithnav-trendz
title: 启用 AI 功能
description: 在 Trendz 中设置 AI 配置的分步指南

ai-settings:
  0:
    image: /images/trendz/ai/settings/ai-settings-1.png
    title: "导航至 <b>设置 → AI 助手</b> 选项卡。"
  1:
    image: /images/trendz/ai/settings/ai-settings-2.png
    title: "<b>AI 功能</b> 部分。"
  2:
    image: /images/trendz/ai/settings/ai-settings-3.png
    title: "<b>AI 模型</b> 部分。"

ai-models:
  0:
    image: /images/trendz/ai/settings/ai-models-1.png
    title: "点击 <b>新建 AI 模型</b> 按钮。"
  1:
    image: /images/trendz/ai/settings/ai-models-2.png
    title: "输入 <b>名称</b>（用于在列表中识别模型的任意标签）。"
  2:
    image: /images/trendz/ai/settings/ai-models-3.png
    title: "选择 <b>提供商</b>（当前支持：`OPEN_AI`、`GOOGLE`、`AMAZON_BEDROCK`、`CUSTOM`）。"
  3:
    image: /images/trendz/ai/settings/ai-models-4.png
    title: "输入 <b>模型名称</b>（特定于提供商）。"
  4:
    image: /images/trendz/ai/settings/ai-models-5.png
    title: "根据提供商提供额外参数（如 Base URL 或 API Key）。"
  5:
    image: /images/trendz/ai/settings/ai-models-6.png
    title: "设置 <b>Temperature</b> 和 <b>Top P</b> 参数。"
  6:
    image: /images/trendz/ai/settings/ai-models-7.png
    title: "点击 <b>保存</b>。"
  7:
    image: /images/trendz/ai/settings/ai-models-8.png
    title: "如果一切配置正确，您将看到成功消息。"

model-delete:
  0:
    image: /images/trendz/ai/settings/model-delete-1.png
    title: "操作 → 删除。"
  1:
    image: /images/trendz/ai/settings/model-delete-2.png
    title: "确认。"

model-edit:
  0:
    image: /images/trendz/ai/settings/model-edit-1.png
    title: "操作 → 编辑。"
  1:
    image: /images/trendz/ai/settings/model-edit-2.png
    title: "修改属性 → 保存。"

ai-features:
  0:
    image: /images/trendz/ai/settings/ai-features-1.png
    title: "要启用 AI 功能，请打开 <b>启用 AI 功能</b> 开关。"
  1:
    image: /images/trendz/ai/settings/ai-features-2.png
    title: "<b>使用单一模型：</b> 为所有功能应用单个 AI 模型。"
  2:
    image: /images/trendz/ai/settings/ai-features-3.png
    title: "<b>按功能自定义配置：</b> 为特定功能分配不同的 AI 模型。"
  3:
    image: /images/trendz/ai/settings/ai-features-4.png
    title: "要切换选项，请启用或禁用 <b>使用单一模型</b> 复选框。"
  4:
    image: /images/trendz/ai/settings/ai-features-5.png
    title: "如果某功能被禁用，您或其他用户将无法访问其相关 AI 能力。"
  5:
    image: /images/trendz/ai/settings/ai-features-6.png
    title: "完成所有配置后，点击 <b>保存</b> 应用更改。"

providers:
  0:
    image: /images/trendz/ai/settings/providers-1.png
    title: "Open AI。"
  1:
    image: /images/trendz/ai/settings/providers-2.png
    title: "Google（推荐）。"
  2:
    image: /images/trendz/ai/settings/providers-3.png
    title: "Amazon Bedrock。"
  3:
    image: /images/trendz/ai/settings/providers-4.png
    title: "其他模型（自定义）。"

---
* TOC
{:toc}

Trendz 提供多种依赖大语言模型（AI 模型）的功能。

对于云安装，Trendz 提供默认 AI 模型，请求次数有限。要扩展此请求限制或启用更多 AI 功能，您需要配置 **AI 设置** 部分。

## AI 设置

导航至 **设置 → AI 助手** 选项卡。

此部分包含两部分：**AI 功能** 和 **AI 模型** 部分。在配置 AI 功能之前，您必须先添加至少一个 AI 模型。

{% include images-gallery.html imageCollection="ai-settings" %}

### AI 模型

添加新 AI 模型：

1. 点击 **新建 AI 模型** 按钮。
2. 输入 **名称**（用于在列表中识别模型的任意标签）。
3. 选择 **提供商**（当前支持：`OPEN_AI`、`GOOGLE`、`AMAZON_BEDROCK`、`CUSTOM`）。
4. 输入 **模型名称**（特定于提供商）。
5. 根据提供商提供额外参数（如 Base URL 或 API Key）。
6. 设置 **Temperature** 和 **Top P** 参数。
7. 点击 **保存**。

如果一切配置正确，您将看到成功消息。

{% include images-gallery.html imageCollection="ai-models" %}

* **Temperature** 决定模型的创意性或确定性。较低值（如 0）产生更重复、可预测的响应，较高值增加创意性和多样性。
* **Top P**（核采样）控制生成响应时使用的概率分布。较低值限制模型输出更可能的结果；较高值允许更多多样性。

创建模型后，您可以根据需要添加多个——例如，来自不同提供商的不同模型用于不同功能。

删除模型：点击 **操作 → 删除 → 确认**。

**重要：** 如果您删除已在 AI 功能中使用的模型，使用该模型的功能将被禁用。

{% include images-gallery.html imageCollection="model-delete" %}

编辑模型：点击 **操作 → 编辑 → 修改属性 → 保存**。

{% include images-gallery.html imageCollection="model-edit" %}

### AI 功能

要启用 AI 功能，请打开 **启用 AI 功能** 开关。

启用后，您将看到两个配置选项：

* **使用单一模型：** 为所有功能应用单个 AI 模型。
* **按功能自定义配置：** 为特定功能分配不同的 AI 模型。

要切换选项，请启用或禁用 **使用单一模型** 复选框。

如果选择单一模型选项，所有 AI 功能将使用同一模型。为获得更大灵活性，您可为以下功能分配不同模型：

1. **Prompts** - 用于 AI 视图摘要（更多信息请参阅[此处](/docs/trendz/ai-widget-summary/#trendz-widgets)）。
2. **视图助手** - 用于视图助手功能（更多信息请参阅[此处](/docs/trendz/ai-assistance-overview/)）。
3. **指标代码助手** - 用于指标浏览器功能（更多信息请参阅[此处](/docs/trendz/metric/overview/)）。

不同功能可能需要不同的模型配置：

* **快速模型** - 用于快速响应（如视图助手）
* **经济型模型** - 用于轻量任务（如 Prompts）
* **高级模型** - 用于复杂推理（如指标代码助手）

如果某功能被禁用，您或其他用户将无法访问其相关 AI 能力。

完成所有配置后，点击 **保存** 应用更改。

{% include images-gallery.html imageCollection="ai-features" %}

## AI 模型提供商概览

目前，Trendz 可与以下提供商集成：

* OPEN_AI
* GOOGLE
* AMAZON_BEDROCK
* CUSTOM（OpenAI API）

{% include images-gallery.html imageCollection="providers" %}

### Open AI

请参阅 [Open AI API 密钥文档](https://platform.openai.com/api-keys) 了解如何为 Open AI 模型创建 API 密钥。

支持的模型：
* Gpt-4o（推荐 - 高性能）
  * 输入（100万）token 价格：2.5$
  * 输出（100万）token 价格：10$
* Gpt-4o-mini（推荐 - 成本效益）
  * 输入（100万）token 价格：0.15$
  * 输出（100万）token 价格：0.6$
* o3-mini（推荐 - 成本效益、高性能但速度较慢）
  * 输入（100万）token 价格：1.1$
  * 输出（100万）token 价格：4.4$
* o4-mini（推荐 - 成本效益、高性能但速度较慢）
  * 输入（100万）token 价格：1.1$
  * 输出（100万）token 价格：4.4$

### Google（推荐）

请参阅 [Google API 密钥文档](https://ai.google.dev/gemini-api/docs/api-key) 了解如何为 Google 模型创建 API 密钥。

支持的模型：
* Gemini-1.5-pro
  * 输入（100万）token 价格：1.25$
  * 输出（100万）token 价格：5$
* Gemini-1.5-flash
  * 输入（100万）token 价格：0.075$
  * 输出（100万）token 价格：0.3$
* Gemini-2.0-flash（推荐 - 成本效益、中等性能）
  * 输入（100万）token 价格：0.1$
  * 输出（100万）token 价格：0.4$
* Gemini-2.0-flash-lite
  * 输入（100万）token 价格：0.075$
  * 输出（100万）token 价格：0.3$
* Gemini-2.5-flash（推荐 - 高性能）
  * 输入（100万）token 价格：0.3$
  * 输出（100万）token 价格：2.5$

### Amazon Bedrock

请参阅 [AWS API 密钥文档](https://docs.aws.amazon.com/bedrock/latest/userguide/getting-started-api.html) 了解如何创建访问密钥 ID 和秘密访问密钥。

支持的模型：
* Amazon（推荐）
  * Amazon Nova Lite（推荐 - 成本效益）
    * 输入（100万）token 价格：0.06$
    * 输出（100万）token 价格：0.24$
  * Amazon Nova Pro
    * 输入（100万）token 价格：0.8$
    * 输出（100万）token 价格：3.2$
* Anthropic
  * Claude 3.5 haiku
    * 输入（100万）token 价格：0.8$
    * 输出（100万）token 价格：4$
  * Claude 3.5 sonnet（推荐）
    * 输入（100万）token 价格：3$
    * 输出（100万）token 价格：15$
  * Claude 3.7 sonnet
    * 输入（100万）token 价格：3$
    * 输出（100万）token 价格：15$
* Meta Llama
  * Llama 3.1 Instruct (70b)
    * 输入（100万）token 价格：0.72$
    * 输出（100万）token 价格：0.72$
  * Llama 3.2 Instruct (90b)
    * 输入（100万）token 价格：0.72$
    * 输出（100万）token 价格：0.72$
  * Llama 3.3 Instruct (70b)（推荐）
    * 输入（100万）token 价格：0.72$
    * 输出（100万）token 价格：0.72$
* Mistral AI
  * Mistral Large (24.02)
    * 输入（100万）token 价格：3$
    * 输出（100万）token 价格：12$

### 其他模型（自定义）

可以连接支持 OpenAI API 标准的任何模型。为此，选择 *Custom* 提供商，输入模型 URL、模型名称和 API 密钥。

## 下一步

{% assign currentGuide = "AiAssistant" %}{% include templates/trndz-guides-banner.md %}
