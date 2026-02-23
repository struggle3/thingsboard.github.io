---
layout: docwithnav-trendz
title: AI 部件摘要
description: 配置 AI 部件摘要的分步指南

trendz-js-summary-module-install:
  0:
    image: /images/trendz/ai/widget-ai-summary/install-trendz-js-module-1.png
    title: "在 Trendz App 中打开 Settings 页面，点击 Upload Module 按钮。"
  1:
    image: /images/trendz/ai/widget-ai-summary/install-trendz-js-module-2.png
    title: "确认模块已成功上传并显示在列表中。"

thingsboard-ai-widget-summary:
  0:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-1.png
    title: "打开包含部件的仪表板。切换到<b>Edit mode</b>。"
  1:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-2.png
    title: "在要添加自定义 AI 摘要操作的部件上点击<b>Edit Widget</b>。"
  2:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-3.png
    title: "进入<b>Actions</b>选项卡，点击<b>Add action</b>。"
  3:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-4.png
    title: "配置：<b>Action source</b>、<b>Name</b>、<b>Button icon</b>和<b>Action</b>。"

thingsboard-ai-widget-summary-v3.9:
  0:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-v3.9-1.png
    title: "点击<b>Modules</b>，然后点击<b>Add module</b>。将<b>Alias</b>设为<b>trendz</b>，<b>JS module resource</b>设为<b>Trendz AI Summary Module</b>。然后点击<b>Apply</b>。"
  1:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-v3.9-2.png
    title: "在自定义操作代码字段中添加<b>trendz.getAnalytics(widgetContext, true);</b>，然后点击<b>Add</b>。"
  2:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-common-1.png
    title: "点击<b>Apply</b>。"
  3:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-common-2.png
    title: "点击<b>Save</b>。"
  4:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-common-3.png
    title: "确认部件标题栏中出现了新按钮。"


thingsboard-ai-widget-summary-v3.6:
  0:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-v3.6.png
    title: "将<b>`custom-action-ai-summary.js`</b>中的完整 JavaScript 代码手动复制到自定义操作字段。在自定义操作代码字段末尾添加<b>trendz.getAnalytics(widgetContext, true);</b>。然后点击<b>Add</b>。"
  1:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-common-1.png
    title: "点击<b>Apply</b>。"
  2:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-common-2.png
    title: "点击<b>Save</b>。"
  3:
    image: /images/trendz/ai/widget-ai-summary/thingsboard-ai-widget-summary-common-3.png
    title: "确认部件标题栏中出现了新按钮。"


trendz-ai-summary-trendz-widget-example:
  0:
    image: /images/trendz/ai/widget-ai-summary/trendz-widget-example-1.png
    title: "1. 点击部件右上角的 'AI summary' 按钮。"
  1:
    image: /images/trendz/ai/widget-ai-summary/trendz-widget-example-2.png
    title: "2. 在 Trendz 部件顶部查看 AI 摘要。"

trendz-ai-summary-trendz-enable-button:
  0:
    image: /images/trendz/ai/widget-ai-summary/trendz-setting-common.png
    title: "打开所需视图。进入 'View Settings'。"
  1:
    image: /images/trendz/ai/widget-ai-summary/trendz-enable-button-1.png
    title: "进入 'View Mode Fields' 部分。选择显示或隐藏 AI Summary 按钮的首选模式。"
  2:
    image: /images/trendz/ai/widget-ai-summary/trendz-enable-button-2.png
    title: "保存更改。"

trendz-ai-summary-trendz-set-up-prompt:
  0:
    image: /images/trendz/ai/widget-ai-summary/trendz-setting-common.png
    title: "打开所需视图。进入 'View Settings'。"
  1:
    image: /images/trendz/ai/widget-ai-summary/trendz-set-up-prompt-1.png
    title: "进入 'AI Assistant' 部分。从下拉菜单中选择首选提示词。"
  2:
    image: /images/trendz/ai/widget-ai-summary/trendz-set-up-prompt-2.png
    title: "保存更改。"
---

* TOC 
{:toc}

AI 部件摘要是一种仪表板控件，可将 ThingsBoard 的实时遥测转换为即时可读的答案。点击后，它会收集您指定的遥测和属性，填充所选提示（来自内置库或自定义），并调用连接的 LLM 提供商。返回的输出显示在部件中，为操作员提供快速状态摘要、异常说明、建议的后续步骤或提示定义的任何其他洞察。

有多种方式可将 AI 摘要与不同类型的部件集成。

## ThingsBoard 部件与 Trendz AI 的集成

您可以轻松将 **Trendz AI 提示**集成到 ThingsBoard 部件中，以在部件标题栏内直接生成数据摘要。

> **自以下版本可用：** ThingsBoard PE v3.6+

### Trendz 摘要 JavaScript 模块

要在 ThingsBoard 部件标题栏中启用 Trendz AI 功能，需连接 **Trendz AI Summary Module**。根据 ThingsBoard 版本，配置过程略有不同。

#### ThingsBoard v3.9 及更高版本

从 v3.9 开始，ThingsBoard 在部件操作中直接支持 JS Modules，简化了配置。

**步骤：**

1. 在 Trendz 应用中打开 **Settings** 页面。
2. 点击 **Upload Module**。
3. 确认上传后模块显示在列表中。

{% include images-gallery.html imageCollection="trendz-js-summary-module-install" %}

上传后，您可以在部件的 **Actions** 配置中引用该模块。

#### ThingsBoard v3.6–v3.8

对于旧版本，无法直接使用 JS Modules。您需要手动将提供的 JavaScript 代码包含在部件操作中。

**下载自定义模块：**

```bash
http://<your-trendz-host:port>/apiTrendz/publicApi/download/custom-action-ai-summary.js
```

将 `<your-trendz-host:port>` 替换为您自己的 Trendz 实例 URL。

### 配置遥测摘要的自定义操作

1. 打开包含部件的仪表板。
2. 切换到 **Edit mode**。
3. 在要添加自定义 AI 摘要操作的部件上点击 **Edit Widget**。
4. 进入 **Actions** 选项卡。
5. 点击 **Add action** 并配置：
   - **Action source：** Widget header button
   - **Name：** 任意（如 `AI Summary`）
   - **Button icon：** 选择任意（默认：`⋯`）
   - **Action：** Custom action


{% include images-gallery.html imageCollection="thingsboard-ai-widget-summary" %}

#### ThingsBoard v3.9 及更高版本

您可以在自定义操作中直接使用 JS 模块：

1. 点击 **Modules** → **Add module**。
2. 设置如下：
   * **Alias：** `trendz`
   * **JS module resource：** `Trendz AI Summary Module` *（白标版本中名称可能不同。）*

3. 点击 **Apply**。
4. 在自定义操作代码字段中添加：
   ```js
   trendz.getAnalytics(widgetContext, true);
   ```

5. 点击 **Add**，然后 **Apply**，最后 **Save widget**。

{% include images-gallery.html imageCollection="thingsboard-ai-widget-summary-v3.9" %}

#### ThingsBoard v3.6–v3.8

1. 将 `custom-action-ai-summary.js` 中的完整 JavaScript 代码手动复制到自定义操作字段。
2. 在自定义操作代码字段末尾添加：

   ```js
   trendz.getAnalytics(widgetContext, true);
   ```
3. 点击 **Add**，然后 **Apply**，最后 **Save widget**。

{% include images-gallery.html imageCollection="thingsboard-ai-widget-summary-v3.6" %}

### 使用自定义操作

配置后，部件标题栏中会出现新按钮。点击后会打开对话框，显示 Trendz AI 根据部件数据和提示设置生成的摘要。

您可以通过 getAnalytics() 的高级参数添加自定义说明或关于数据的额外业务知识，以提升 AI 摘要功能生成的文本质量。

### `getAnalytics()` 的高级用法

`getAnalytics()` 方法支持三种使用模式：

#### 1. 使用 Trendz 默认提示

使用系统默认提示（Trendz System Default Summary Prompt）：

```js
getAnalytics(widgetContext, true);
```

#### 2. 自定义内联文本

仅使用 Trendz 作为 LLM 模型，提供您自己的文本提示：

```js
getAnalytics(widgetContext, false, 'Identify which tanks require additional attention and explain why.');
```

#### 3. 按 ID 使用已保存的提示

通过指定 ID 使用 Trendz 中已保存的提示：

```js
getAnalytics(widgetContext, false, 'ef348780-a034-4ea9-9225-8b6ad112c451');
```

> **建议：** 使用 Trendz 的 **Prompt ID** 便于管理和更新。

更多关于管理提示的信息请参阅 [Trendz AI 提示概述](/docs/trendz/ai-assistance-prompts)。

## Trendz 部件

AI 摘要已集成到 Trendz 部件中。要获取 Trendz 部件的 AI 摘要，请点击屏幕右上角的 **AI summary** 按钮。之后，您可以在 Trendz 部件顶部查看 AI 摘要。

{% include images-gallery.html imageCollection="trendz-ai-summary-trendz-widget-example" %}

### 启用 AI 摘要按钮

默认情况下，对于 Trendz 1.13.1 之前创建的视图，以及自托管用户在 **AI Assistant Use AI Model** 标志被禁用期间创建的视图，仪表板上的 AI 摘要按钮处于禁用状态（更多关于为自托管用户配置 AI Assistant 模块的信息请见[此处](/docs/trendz/custom-ai-model-configuration/)）。

要启用/禁用 AI 摘要按钮，请按以下步骤操作：

1. 打开所需视图。
2. 进入 **View Settings**。
3. 进入 **View Mode Fields** 部分。
4. 选择显示或隐藏 AI Summary 按钮的首选模式。
5. 在视图中保存更改。

注意：Trendz 应用中的按钮将始终显示（即使勾选复选框）

{% include images-gallery.html imageCollection="trendz-ai-summary-trendz-enable-button" %}

### 设置 AI 摘要提示

此外，可选择用于生成 AI 摘要的提示。

要设置 AI 摘要提示：

1. 打开所需视图。
2. 进入 **View Settings**。
3. 进入 **AI Assistant** 部分。
4. 从下拉菜单中选择首选提示。
5. 保存更改。

{% include images-gallery.html imageCollection="trendz-ai-summary-trendz-set-up-prompt" %}

更多关于创建完美契合您任务的提示的信息请见[此处](/docs/trendz/ai-assistance-prompts/)。

**⚠️ 注意：** 目前除 Anomaly View 外，AI Summary 可用于 Trendz 中的所有视图。

## Next Steps

{% assign currentGuide = "AiAssistant" %}{% include templates/trndz-guides-banner.md %}
