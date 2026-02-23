---
layout: docwithnav-pe
title: 故障排除
description: ThingsBoard IoT 平台故障排除

metrics-dashboards:
    0:
        image: /images/user-guide/troubleshooting/attributes-cache-grafana.webp
        title: '属性缓存效率统计。'
    1:
        image: /images/user-guide/troubleshooting/core-and-js-metrics-grafana.webp
        title: 'TB Core 和 JS 处理器请求统计。'
    2:
        image: /images/user-guide/troubleshooting/db-metrics-grafana.webp
        title: '属性与时间序列持久化到 PostgreSQL 的统计。'
    3:
        image: /images/user-guide/troubleshooting/rule-engine-latency-grafana.webp
        title: '规则引擎内部处理消息所用时间的统计。'
    4:
        image: /images/user-guide/troubleshooting/rule-engine-metrics-grafana.webp
        title: '规则引擎内部消息处理的统计。'
    5:
        image: /images/user-guide/troubleshooting/single-service-metrics-grafana.webp
        title: '各服务独立统计。可在左上角选择服务。'
    6:
        image: /images/user-guide/troubleshooting/transport-metrics-grafana.webp
        title: '传输服务中的消息统计。'
  

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/troubleshooting.md %}