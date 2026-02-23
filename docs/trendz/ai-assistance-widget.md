---
layout: docwithnav-trendz
title: 高级分析聊天助手部件
description: 与高级分析聊天助手部件交互的分步指南

trendz-assistance-chat-example:
  0: 
    image: /images/trendz/ai/chat-widget/chat-widget-example-1.png
    title:
  1: 
    image: /images/trendz/ai/chat-widget/chat-widget-example-2.png
    title:

trendz-assistance-create-dashboard:
  0:
    image: /images/trendz/ai/chat-widget/create-dashboard.png
    title: 

trendz-assistance-set-up-alias:
  0:
    image: /images/trendz/ai/chat-widget/set-up-alias-1.png
    title: 进入 Aliases -> Add Alias
  1:
    image: /images/trendz/ai/chat-widget/set-up-alias-2.png
    title: 输入 Alias Name，选择 Filter Type 为 "Asset type"，选择所需资产类型，点击 Add
  2:
    image: /images/trendz/ai/chat-widget/set-up-alias-3.png
    title: 添加第二个别名——输入 Alias Name，选择 Filter Type 为 "Entity from dashboard state"，在 State entity parameter name 中输入 "default"，点击 Add
  3:
    image: /images/trendz/ai/chat-widget/set-up-alias-4.png
    title: 确认有两个别名后点击 Save

trendz-assistance-add-table:
  0:
    image: /images/trendz/ai/chat-widget/add-table-1.png
    title: 点击 Add Widget，选择 "Tables"
  1:
    image: /images/trendz/ai/chat-widget/add-table-2.png
    title: 选择 "Entities table"
  2:
    image: /images/trendz/ai/chat-widget/add-table-3.png
    title: 选择第一个别名作为 entity alias，点击 Add action
  3:
    image: /images/trendz/ai/chat-widget/add-table-4.png
    title: 添加新操作
  4:
    image: /images/trendz/ai/chat-widget/add-table-5.png
    title: 将 Action source 设为 "On row click"，设置任意名称，将 State entity parameter name 设为 "default"，点击 Save
  5:
    image: /images/trendz/ai/chat-widget/add-table-6.png
    title: 点击 Save 并确认已添加一个操作
  6:
    image: /images/trendz/ai/chat-widget/add-table-7.png
    title: 点击 Add 完成

trendz-assistance-add-chat-widget:
  0:
    image: /images/trendz/ai/chat-widget/add-chat-widget-1.png
    title: 点击 + Add widget
  1:
    image: /images/trendz/ai/chat-widget/add-chat-widget-2.png
    title: 选择 Advanced analytics Bundle
  2:
    image: /images/trendz/ai/chat-widget/add-chat-widget-3.png
    title: 选择 Advanced analytics Chat Assistant
  3:
    image: /images/trendz/ai/chat-widget/add-chat-widget-4.png
    title: 选择第二个别名作为 Entity alias。添加 Name 作为 Data key
  4:
    image: /images/trendz/ai/chat-widget/add-chat-widget-5.png
    title: 进入 Appearance 部分，输入 Filter name 字段，然后点击 Add

trendz-assistance-ai-chat-interaction:
  0:
    image: /images/trendz/ai/chat-widget/ai-chat-interaction-1.png
    title: 点击所需资产，然后点击 "START AI CHAT"
  1:
    image: /images/trendz/ai/chat-widget/ai-chat-interaction-2.png
    title: 在弹出窗口中，对所选资产提问
  2:
    image: /images/trendz/ai/chat-widget/ai-chat-interaction-3.png
    title: 查看结果
  3:
    image: /images/trendz/ai/chat-widget/ai-chat-interaction-4.png
    title: 当前版本的 AI 助手支持记忆和持续对话，可进行追问或提供更多说明
  4:
    image: /images/trendz/ai/chat-widget/ai-chat-interaction-5.png
    title: 要开始新对话，点击 "New Conversation" 按钮
  5:
    image: /images/trendz/ai/chat-widget/ai-chat-interaction-6.png
    title: 可通过 "Current Chat" 标签下的下拉菜单随时返回之前的对话
  6:
    image: /images/trendz/ai/chat-widget/ai-chat-interaction-7.png
    title: 可在 "Chats" 选项卡中查看消息或保存生成的视图，选择带有 "Dashboard Origin" 的聊天

---

* TOC
{:toc}

AI 助手部件是一种交互工具，允许用户通过聊天会话快速检索和分析数据。它可添加到 ThingsBoard 的仪表板中，便于提问并获得即时回复。

{% include images-gallery.html imageCollection="trendz-assistance-chat-example" %}

## 主要功能

* **基于聊天的交互：** 用户可输入问题、编辑并请求新数据。回复即时显示在聊天窗口右侧。
* **历史追踪：** 部件存储以往的问题和答案，用户可回顾历史查询并以最新数据查看更新后的回复。
* **灵活使用（可带或不带别名）：**
  * 默认情况下，助手基于用户可访问的所有数据提供回答。
  * 用户可配置部件，使用 ThingsBoard 中的别名聚焦于特定实体（设备、资产或组）。
  * 若链接了别名，回复将针对所选实体定制。
  * 若不使用别名，助手仍可正常工作，基于一般可用数据提供回复。
* **动态实体切换：**
  * 用户可选择不同实体，助手将自动调整回复以反映新选择，无需重复提问。
* **仪表板专属历史：**
  * 聊天历史与每个部件实例和仪表板绑定。
  * 不同仪表板上的独立部件将维护独立的历史记录。
  * 用户和客户只能看到各自的聊天历史。

## 使用建议

  * 将部件放在仪表板上方便但不突兀的位置。
  * 使用别名细化特定实体的回复，或使用默认模式获得更广泛的洞察。
  * 利用保存的历史简化研究，避免重复查询。

下面将详细介绍如何结合别名使用助手。

## 带别名的高级分析聊天助手

### 步骤 1：创建仪表板
  * 进入 Dashboards -> Add Dashboard -> Create New Dashboard
  * 输入仪表板标题并点击 **Add**
  * 更多详情请参阅 [ThingsBoard 仪表板指南](/docs/pe/user-guide/dashboards/)

{% include images-gallery.html imageCollection="trendz-assistance-create-dashboard" %}

### 步骤 2：设置别名
  * 进入 Aliases -> Add Alias
  * 输入 **Alias Name**，选择 **Filter Type** 为 *Asset type*，选择所需资产类型，点击 **Add**
  * 添加第二个别名：输入 **Alias Name**，选择 **Filter Type** 为 *Entity from dashboard state*，在 **State entity parameter name** 中输入 *default*，点击 **Add**
  * 确认有两个别名后点击 **Save**
  * 更多详情请参阅 [别名指南](/docs/pe/user-guide/ui/aliases/)

{% include images-gallery.html imageCollection="trendz-assistance-set-up-alias" %}

### 步骤 3：添加实体表部件
  * 点击 **Add Widget**，选择 "Tables" → "Entities table"
  * 选择第一个别名作为 entity alias，点击 Add action
  * 配置操作：
    * 将 **Action source** 设为 *On row click*
    * 设置任意 **Name**
    * 将 **State entity parameter name** 设为 *default*
    * 点击 **Save** 并确认已添加一个操作
  * 点击 **Add** 完成
  * 确认看到包含资产的表格

{% include images-gallery.html imageCollection="trendz-assistance-add-table" %}

### 步骤 4：添加高级分析聊天助手部件

  * 点击 **+ Add widget**
  * 选择 **Advanced analytics Bundle**
  * 选择 **Advanced analytics Chat Assistant**
  * 选择第二个别名作为 **Entity alias**
  * 添加 *Name* 作为 **Data key**
  * 进入 Appearance 部分，输入 **Filter name** 字段，然后点击 **Add**
  * 确认高级分析聊天助手部件已添加。点击 **Save**

{% include images-gallery.html imageCollection="trendz-assistance-add-chat-widget" %}

### 步骤 5：与 AI 聊天交互
* 点击所需资产，然后点击 **START AI CHAT**
* 在弹出窗口中，对所选资产提问
* 当前版本的 AI 助手支持记忆和持续对话，可进行追问或提供更多说明
* 要开始新对话，点击 **New Conversation** 按钮
* 可通过 **Current Chat** 标签下的下拉菜单随时返回之前的对话
* 可在 **Chats** 选项卡中查看消息或保存生成的视图，选择带有 **Dashboard Origin** 的聊天

{% include images-gallery.html imageCollection="trendz-assistance-ai-chat-interaction" %}

更多关于 AI 助手聊天的信息请见[此处](/docs/trendz/ai-assistance-overview/)。

## Next Steps

{% assign currentGuide = "AiAssistant" %}{% include templates/trndz-guides-banner.md %}
