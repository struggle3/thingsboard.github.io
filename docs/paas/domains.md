---
layout: docwithnav-paas
assignees:
- ashvayka
title: 域名管理
description: 通过 ThingsBoard Cloud 管理域名
redirect_from: "/products/paas/domains/"

register-domain:
    0:
        image: /images/user-guide/domain/adding-new-domain-1-paas.png
        title: '进入「安全」部分的「OAuth 2.0」页面，在「Domains」标签页点击「+」图标；'
    1:
        image: /images/user-guide/domain/adding-new-domain-2-paas.png
        title: '在「Domain name」字段输入有效域名，点击「Add」按钮；'
    2:
        image: /images/user-guide/domain/adding-new-domain-3-paas.png
        title: 'Here you will find a reminder to add CNAME records to the DNS configuration of your domain. Click the "I&#39;ve added CNAME records" button. The domain verification and certificate provisioning will start;'
    3:
        image: /images/user-guide/domain/adding-new-domain-4-paas.png
        title: 'If succeeded, you will see your domain name on the "Domains" tab.'
    
login-with-domain:
    0:
        image: /images/user-guide/domain/domain-login-1-paas.png
        title: 'Now you can use your domain name to access ThingsBoard Cloud web interface and services. Try to login by entering the chosen domain name in the browser address line.'
    
domain-details:
    0:
        image: /images/user-guide/domain/domain-details-1-paas.png
        title: 'To view details about a registered domain, simply click on it to open the domain details dialog;'
    1:
        image: /images/user-guide/domain/domain-details-2-paas.png
        title: 'This dialog provides information about registered domain CNAME record and issued "SSL certificate" details including current validity period (Not before and Not after).'
    
delete-domain:
    0:
        image: /images/user-guide/domain/delete-domain-1-paas.png
        title: 'To delete the registered domain click "trash" icon in the domai&#39;s row you want to delete.'
    1:
        image: /images/user-guide/domain/delete-domain-2-paas.png
        title: 'In the confirmation dialog, click "Yes" if you are sure you want to delete the domain.'

---

{% assign docsPrefix = "paas/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/pe/user-guide/domains.md %}