---
layout: docwithnav-pe
assignees:
- stitenko
title: 移动应用二维码
description: 移动应用二维码指南

download-app-with-qr-code:
    0:
        image: /images/user-guide/ui/qr-code/qr-code-thingsboard-home-page-1-pe.png
        title: '登录您的ThingsBoard账户并导航至"Home"页面。右下角可找到连接移动应用的二维码；'
    1:
        image: /images/user-guide/ui/qr-code/qr-code-scan-and-install-app-pe.png
        title: '在手机或平板设备上打开相机并对准二维码。手机会自动扫描并显示链接按钮。点击该按钮打开下载<b>ThingsBoard移动应用</b>的链接；'
    2:
        image: /images/user-guide/ui/qr-code/qr-code-mobile-install-app-pe.png
        title: '安装ThingsBoard移动应用；'
    3:
        image: /images/user-guide/ui/qr-code/qr-code-mobile-open-app-1-pe.png
        title: '启动ThingsBoard移动应用开始使用。'

clicking-button:
    0:
        image: /images/user-guide/ui/qr-code/qr-code-thingsboard-home-page-2-pe.png
        title: '点击"Connect mobile app"部件中的"App Store"或"Google Play"按钮，将跳转至相应应用商店的ThingsBoard应用页面以便下载到设备。'
    1:
        image: /images/user-guide/ui/qr-code/qr-code-button-2-pe.png
        title: 'App Store。'
    2:
        image: /images/user-guide/ui/qr-code/qr-code-button-1-pe.png
        title: 'Google Play。'

authorize-with-qr-code:
    0:
        image: /images/user-guide/ui/qr-code/qr-code-mobile-login-with-qr-1-pe.png
        title: '在设备上启动ThingsBoard移动应用并使用二维码扫描功能。请确保已安装最新版本；'
    2:
        image: /images/user-guide/ui/qr-code/qr-code-scan-and-open-app-pe.png
        title: '使用移动应用扫描ThingsBoard实例"Home"页面上的二维码。右下角可找到连接移动应用的二维码；'
    3:
        image: /images/user-guide/ui/qr-code/qr-code-mobile-dashboard-1-pe.png
        title: '您已成功使用账户登录ThingsBoard移动应用。'

mobile-app-qr-code-widget-settings:
    0:
        image: /images/user-guide/ui/qr-code/mobile-app-qr-code-widget-settings-1-pe.png
        title: '导航至"Mobile center"页面的"QR code widget"选项卡，关闭"Use system settings"开关；'

application-settings-default:
    0:
        image: /images/user-guide/ui/qr-code/mobile-app-qr-code-widget-settings-2-pe.png
        title: '保留"Default"应用设置以使用<b>ThingsBoard Cloud</b>移动应用。'

application-settings-custom:
    0:
        image: /images/user-guide/ui/qr-code/mobile-app-qr-code-widget-settings-3-pe.png
        title: '若需使用自定义应用，请切换到自定义设置并在"Bundle"选项卡中指定预配置的bundle。然后保存更改。'

disable-platforms:
    0:
        image: /images/user-guide/ui/qr-code/mobile-app-qr-code-widget-settings-4-pe.png
        title: '如需要，可禁用未使用的平台。'

appearance-on-home-page:
    0:
        image: /images/user-guide/ui/qr-code/mobile-app-qr-code-widget-settings-5-pe.png
        title: '可在"Home"页面上禁用二维码部件、调整徽章位置并更新二维码标签。'

add-qr-code-widget:
    0:
        image: /images/user-guide/ui/qr-code/add-qr-code-widget-1-pe.png
        title: '打开仪表板并切换到编辑模式。点击屏幕顶部的"+ Add widget"图标；'
    1:
        image: /images/user-guide/ui/qr-code/add-qr-code-widget-2-pe.png
        title: '导航至"Cards"部件包；'
    2:
        image: /images/user-guide/ui/qr-code/add-qr-code-widget-3-pe.png
        title: '选择"Mobile app QR code"部件；'
    3:
        image: /images/user-guide/ui/qr-code/add-qr-code-widget-4-pe.png
        title: '可使用系统设置或自定义配置。如需要，可配置徽章（或完全关闭）并更新二维码标签。点击"Add"。'
    4:
        image: /images/user-guide/ui/qr-code/add-qr-code-widget-5-pe.png
        title: '调整部件大小以满足需求。调整完成后点击"Save"保存仪表板；'
    5:
        image: /images/user-guide/ui/qr-code/add-qr-code-widget-6-pe.png
        title: '移动应用二维码部件已添加。用手机扫描二维码并确认已跳转至指定应用。'
  

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ui/mobile-qr-code.md %}