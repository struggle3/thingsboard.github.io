* TOC
{:toc}

通过将 Slack 与 ThingsBoard 集成，用户可按照所设通知规则在 Slack 中接收 ThingsBoard 系统内发生的事件通知。例如，接收设备状态或检测到问题的通知。

{% capture difference %}
**注意：**
<br>
仅可向工作区内用户发送 Slack 通知
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Tenant administrator 可配置 [**rule engine**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 产生的告警分发。

## Create an application in Slack. Get Slack API token

在 ThingsBoard 中配置 Slack 之前，需先在 Slack API 中注册应用。打开 [get Slack API token](https://api.slack.com/tutorials/tracks/getting-a-token) 页面，并按下列步骤操作：

{% include images-gallery.html imageCollection="slackProviderSettings" showListImageTitles="true" %}

{% unless docsPrefix contains 'paas/' %}
## Slack settings configuration as System administrator

以系统管理员身份登录 ThingsBoard UI。进入“Settings”页面的“Notification”选项卡。在“Slack settings”窗口中，将复制的 Slack API token 粘贴到“Slack api token”栏并点击“Save”。

{% include images-gallery.html imageCollection="thingsboardSystemAdminSettings" %}
{% endunless %}

## Slack settings configuration as Tenant administrator

以 tenant administrator 身份登录 ThingsBoard UI。进入“Settings”页面的“Notification”选项卡。在“Slack settings”窗口中，将复制的 Slack API token 粘贴到“Slack api token”栏并点击“Save”。

{% include images-gallery.html imageCollection="thingsboardTenantAdminSettings" %}

<br>
配置完成后，当 ThingsBoard 实例中发生的事件符合所设通知规则时，将开始在 Slack 频道中收到通知。还可向任意用户发送消息。
