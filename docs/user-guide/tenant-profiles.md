---
layout: docwithnav
assignees:
- ashvayka
title: Tenant Profiles
description: IoT tenant 配置
redirect_from: "/docs/user-guide/ui/tenant-profiles"
entityLimits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-ce-tenant-profiles-entity-limits.png

api-limits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-ce-api-limits.png

apiLimitsDashboard:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-ce-tenant-profiles-api-limits-dashboard.png  

rateLimits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-ce-rate-limits.png  

files-limits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-ce-files.png

isolatedQueueConfiguration:
    0:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-1-ce.png
        title: '步骤 1。打开 tenant profile 菜单并添加新 tenant profile。勾选 "isolated ThingsBoard RuleEngine"，Main queue 默认添加且不可重命名或删除。'
    1:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-2-ce.png
        title: '步骤 2。若需添加新的自定义 queue，点击 "Add Queue"。'
    2:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-3-ce.png
        title: '步骤 3。配置 submit 和 processing 设置。'
    3:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-4-ce.png
        title: '步骤 4。此时 tenant profile 已可分配给特定 tenant。'
---

{% include get-hosts-name.html %}
{% include docs/user-guide/tenant-profiles.md %}
