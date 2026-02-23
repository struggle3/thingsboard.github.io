* TOC
{:toc}

要将 [Microsoft Teams](https://www.microsoft.com/en-us/microsoft-teams/group-chat-software/){:target="_blank"} 与 ThingsBoard 平台集成，需先为将用于 ThingsBoard 的频道配置 workflow。

按下列步骤操作：

{% assign microsoftTeamsSettings = '
    ===
        image: /images/user-guide/ui/microsoft-teams/microsoft-teams-settings-1.png,
        title: 登录 Microsoft Teams 并进入「Teams」选项卡，左键点击频道名称，在下拉菜单中点击「Workflows」；
    ===
        image: /images/user-guide/ui/microsoft-teams/microsoft-teams-settings-2.png,
        title: 找到「Post to a channel when a webhook request is received」workflow 并点击；
    ===
        image: /images/user-guide/ui/microsoft-teams/microsoft-teams-settings-3.png,
        title: 为 workflow 命名并点击「Next」按钮；
    ===
        image: /images/user-guide/ui/microsoft-teams/microsoft-teams-settings-4.png,
        title: 在「Details」中选择 team 和 channel，点击「Add workflow」按钮；
    ===
        image: /images/user-guide/ui/microsoft-teams/microsoft-teams-settings-5.png,
        title: Workflow 添加成功。请复制 workflow URL，将用于通知配置。最后点击「Done」按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=microsoftTeamsSettings %}

<br>
完成后，可通过 [Notification Center](/docs/{{docsPrefix}}user-guide/notifications/#microsoft-teams) 使用 Microsoft Teams。
