---
layout: docwithnav-paas
assignees:
- ashvayka
title: 管理域名
description: 通过 ThingsBoard Cloud 管理域名
registerDomain:
    0:
        image: /images/user-guide/domain/domain-register-step-1.png
        title: '进入「设置」页面，然后导航至「域名」选项卡。在「域名」选项卡上点击「注册域名」按钮；'
    1:
        image: /images/user-guide/domain/domain-register-step-2.png
        title: '在输入框中输入有效域名，然后点击「注册」按钮；'
    2:
        image: /images/user-guide/domain/domain-register-step-3.png
        title: '您将看到有关 CNAME 的提示；'
    3:
        image: /images/user-guide/domain/domain-register-step-4.png
        title: '点击「我已添加 CNAME 记录」按钮。确认规范名称生效后，域名验证和证书配置将开始。请耐心等待，此过程可能需要一段时间；'
    4:
        image: /images/user-guide/domain/domain-register-step-5.png
        title: '成功后，您将在「域名」选项卡上看到您的域名。'

white-labeling:
    0:
        image: /images/user-guide/domain/domain-white-labeling-1.png
        title: '进入「白标」页面，然后导航至「登录」选项卡。在相应字段中输入域名和基础 URL。请勿忘记勾选「禁止使用客户端请求头中的主机名」复选框。然后保存所有更改；'
    1:
        image: /images/user-guide/domain/domain-login-1.png
        title: '现在您可以使用您的域名访问 ThingsBoard Cloud Web UI 和服务。尝试在浏览器地址栏中输入所选域名进行登录。'

domainDetails:
    0:
        image: /images/user-guide/domain/domain-details-step-1.png
        title: '要查看已注册域名详情，请点击「域名」选项卡上的「域名详情」按钮；'
    1:
        image: /images/user-guide/domain/domain-details-step-2.png
        title: 'ThingsBoard Cloud 会在证书到期前 30 天自动续期，除非您更改或删除域名 CNAME 记录，否则无需您执行任何操作。'

deleteDomain:
    0:
        image: /images/user-guide/domain/domain-delete-step-1.png
        title: '要删除已注册域名，请点击「域名」选项卡上的「删除」按钮；'
    1:
        image: /images/user-guide/domain/domain-delete-step-2.png
        title: '在确认对话框中，如确定要删除域名，请点击「是」。'

---
