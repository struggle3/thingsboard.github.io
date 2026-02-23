---
layout: docwithnav-pe
assignees:
- ashvayka
title: 租户档案
description: IoT 租户档案
redirect_from: "/docs/pe/user-guide/ui/tenant-profiles"
entityLimits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-pe-tenant-profiles-entity-limits.png  

api-limits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-pe-api-limits.png

apiLimitsDashboard:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-pe-tenant-profiles-api-limits-dashboard.png  

rateLimits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-pe-rate-limits.png
        
files-limits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-pe-files.png

isolatedQueueConfiguration:
    0:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-1-pe.png
        title: '步骤 1：打开租户档案菜单并添加新租户档案。勾选「isolated ThingsBoard RuleEngine」框，主队列默认添加且不可重命名或删除。'
    1:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-2-pe.png
        title: '步骤 2：如需添加新的自定义队列，请点击「添加队列」。'
    2:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-3-pe.png
        title: '步骤 3：配置提交和处理设置。'
    3:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-4-pe.png
        title: '步骤 4：租户档案现已可分配给特定租户。'
---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/tenant-profiles.md %}
