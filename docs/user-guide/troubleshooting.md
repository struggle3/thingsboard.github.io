---
layout: docwithnav
title: 故障排查
description: ThingsBoardIoT平台故障排查

metrics-dashboards:
    0:
        image: /images/user-guide/troubleshooting/attributes-cache-grafana.webp
        title: 'Attributes 缓存效率统计。'
    1:
        image: /images/user-guide/troubleshooting/core-and-js-metrics-grafana.webp
        title: 'TB Core 与 JS 处理器的请求统计。'
    2:
        image: /images/user-guide/troubleshooting/db-metrics-grafana.webp
        title: '`attributes` 与 `timeseries` 持久化到 PostgreSQL 的统计。'
    3:
        image: /images/user-guide/troubleshooting/rule-engine-latency-grafana.webp
        title: 'Rule Engine 内消息处理耗时统计。'
    4:
        image: /images/user-guide/troubleshooting/rule-engine-metrics-grafana.webp
        title: 'Rule Engine 内消息处理统计。'
    5:
        image: /images/user-guide/troubleshooting/single-service-metrics-grafana.webp
        title: '各服务独立统计。可在左上角选择服务。'
    6:
        image: /images/user-guide/troubleshooting/transport-metrics-grafana.webp
        title: 'Transport 服务消息统计。'
  

---

{% include get-hosts-name.html %}
{% include docs/user-guide/troubleshooting.md %}
