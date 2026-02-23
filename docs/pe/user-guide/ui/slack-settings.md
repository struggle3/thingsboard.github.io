---
layout: docwithnav-pe
assignees:
- ashvayka
title: Slack 设置
description: ThingsBoard IoT 平台 Slack 设置
slackProviderSettings:
    0:
        image: /images/user-guide/ui/slack/create-slack-api-token-1.png
        title: '在"How to quickly get and use a Slack API token"页面向下滚动，找到"Create a pre-configured app"；'
    1:
        image: /images/user-guide/ui/slack/create-slack-api-token-2.png
        title: '点击"Create app"按钮；'
    2:
        image: /images/user-guide/ui/slack/create-slack-api-token-3.png
        title: '在新窗口中从下拉菜单中选择您的工作区，然后点击"Next"；'
    3:
        image: /images/user-guide/ui/slack/create-slack-api-token-4.png
        title: '查看摘要并点击"Create"按钮创建应用；'
    4:
        image: /images/user-guide/ui/slack/create-slack-api-token-5.png
        title: '欢迎使用应用配置。点击"Go it"；'
    5:
        image: /images/user-guide/ui/slack/create-slack-api-token-6.png
        title: '下一步——将应用安装到Slack工作区。点击"Install to Workspace"按钮；'
    6:
        image: /images/user-guide/ui/slack/create-slack-api-token-7.png
        title: '应用正在请求访问Slack工作区的权限。点击"Allow"；'
    7:
        image: /images/user-guide/ui/slack/create-slack-api-token-8.png
        title: '成功！您的应用已创建。现在导航至"OAuth & Permissions"页面；'
    8:
        image: /images/user-guide/ui/slack/create-slack-api-token-9.png
        title: '复制"Bot User OAuth Token"。这就是我们需要的"Slack API token"。'

thingsboardSystemAdminSettings:
    0:
        image: /images/user-guide/ui/slack/add-slack-api-token-sysadmin-1-pe.png
        title: '以系统管理员身份登录ThingsBoard UI。导航至"Settings"页面、"Notification"选项卡。在"Slack settings"窗口中将复制的Slack API token粘贴到"Slack api token"行并点击"Save"。'

thingsboardTenantAdminSettings:
    0:
        image: /images/user-guide/ui/slack/add-slack-api-token-tenant-admin-1-pe.png
        title: '以租户管理员身份登录ThingsBoard UI。导航至"Settings"页面、"Notification"选项卡。在"Slack settings"窗口中将复制的Slack API token粘贴到"Slack api token"行并点击"Save"。'



---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ui/slack-settings.md %}