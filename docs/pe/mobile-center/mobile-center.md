---
layout: docwithnav-pe
assignees:
- stitenko
title: 移动中心
description: 移动中心

add-bundle:
    0:
        image: /images/mobile-center/add-new-bundle-1-pe.png
        title: '要添加新bundle，请导航至"移动中心"页面，并点击窗口右上角的"+ 添加bundle"按钮。'

basic-settings-1:
    0:
        image: /images/mobile-center/basic-settings-1-pe.png
        title: '输入bundle名称并指定现有的Android/iOS移动应用，或创建新应用。然后，点击"下一步"。'

add-application:
    0:
        image: /images/mobile-center/add-application-1-pe.png
        title: '在相应部分（Android Application或iOS Application）点击"创建新"；'
    1:
        image: /images/mobile-center/android-application-2-pe.png
        title: 'Android Application。输入应用包名。记住自动生成的"应用密钥"或输入您自己的。指定应用状态。可选：为每个应用指定最低和最新版本及发布说明。指定应用商店信息：Google Play Store中ThingsBoard PE移动应用的链接，以及SHA256证书指纹。点击"添加"。'
    2:
        image: /images/mobile-center/ios-application-2-pe.png
        title: 'iOS Application。输入应用包名。记住自动生成的"应用密钥"或输入您自己的。指定应用状态。可选：为每个应用指定最低和最新版本及发布说明。指定应用商店信息：App Store中ThingsBoard PE移动应用的链接，以及App ID。点击"添加"。'

specify-oauth-clients:
    0:
        image: /images/mobile-center/specify-oauth-clients-1-pe.png
        title: '指定已配置的OAuth 2.0客户端或配置新客户端；'
    1:
        image: /images/mobile-center/specify-oauth-clients-2-pe.png
        title: '完成OAuth 2.0配置后，点击"下一步"。'

layout-1:
    0:
        image: /images/mobile-center/mobile-layout-1-pe.png
        title: ''
    1:
        image: /images/mobile-center/mobile-layout-2-pe.png
        title: ''
        
layout-2:
    0:
        image: /images/mobile-center/mobile-layout-3-pe.png
        title: '移动应用导航菜单中显示的菜单项数量取决于您移动设备的屏幕尺寸。底部导航菜单中放不下的项将在"更多"页面下可用。'
    1:
        image: /images/mobile-center/mobile-layout-4-pe.png
        title: ''

custom-page-type:
    0:
        image: /images/mobile-center/custom-page-type-1-pe.png
        title: '点击页面底部的"+ 添加特定页面"按钮或现有菜单项之间；'
    1:
        image: /images/mobile-center/custom-page-type-2-pe.png
        title: '输入新菜单页面的名称，并选择页面类型。根据所选的页面类型，指定仪表板、路径或外部URL。点击"添加"。'
    2:
        image: /images/mobile-center/custom-page-type-3-pe.png
        title: '配置布局后，点击"下一步"。'

self-registration-1:
    0:
        image: /images/mobile-center/self-registration-1-pe.png
        title: '输入将显示在注册页面顶部的页面标题。它作为标题向用户表明表单的用途。指定将接收新用户注册通知的接收人。指定重定向设置：应用URL Scheme和应用URL主机名；'

self-registration-2:
    0:
        image: /images/mobile-center/self-registration-2-pe.png
        title: '完成注册表单的必填字段为email、password和repeat password。如需，可指定其他字段；'

captcha:
    0:
        image: /images/mobile-center/captcha-1.png
        title: '导航至Google ReCaptcha管理控制台；'
    1:
        image: /images/mobile-center/captcha-2.png
        title: '指定ThingsBoard实例的域名。选择reCAPTCHA类型；'
    2:
        image: /images/mobile-center/captcha-3.png
        title: '复制并安全存储site key和secret key。'

self-registration-3:
    0:
        image: /images/mobile-center/self-registration-3-pe.png
        title: '选择要使用的Captcha版本，并指定"Captcha site key"和"Captcha secret key"；'

self-registration-4:
    0:
        image: /images/mobile-center/self-registration-4-pe.png
        title: '显示/隐藏隐私政策和使用条款。指定用户成功注册后将分配的角色。'

self-registration-5:
    0:
        image: /images/mobile-center/self-registration-5-pe.png
        title: '填写"高级设置"中的必填字段。指定用户首次登录时看到的仪表板；'

self-registration-6:
    0:
        image: /images/mobile-center/self-registration-6-pe.png
        title: '指定用户导航至"主页"菜单项时将显示的主仪表板。点击"添加"完成bundle创建。'

configuration-dialog:
    0:
        image: /images/mobile-center/add-new-bundle-2-pe.png
        title: '接下来将打开配置对话框，其中包含ThingsBoard PE移动应用的基本配置设置。'

bundle-added:
    0:
        image: /images/mobile-center/add-new-bundle-3-pe.png
        title: 'bundle已添加。bundle中指定的应用现在使用已定义的设置。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/mobile-center/mobile-center.md %}