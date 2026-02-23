ThingsBoard 提供跟踪用户操作以维护审计日志的能力。
可记录与主要实体相关的用户操作：资产、设备、仪表板、规则等。

## 用户界面

租户管理员可查看属于对应租户账户的审计日志。管理员可设置日期范围并对获取的实体执行全文搜索。

![image](/images/user-guide/ui/audit-log.png)

「details」按钮可查看已记录操作的低级详情。

![image](/images/user-guide/ui/audit-log-details.png)

## REST API

可通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 获取审计日志。
有多种 API 调用可用于获取与特定用户、实体、客户相关的实体，或使用页面链接获取所有记录。

{% unless docsPrefix contains "paas/" %}
## 通用配置

系统管理员可使用 [thingsboard.yml](/docs/user-guide/install/{{docsPrefix}}config/) 配置审计日志级别。示例配置如下：

```yaml
# 审计日志参数
audit_log:
  # 启用/禁用审计日志
  enabled: "${AUDIT_LOG_ENABLED:true}"
  # 按租户 ID 存储的分区粒度。可选：MINUTES、HOURS、DAYS、MONTHS
  by_tenant_partitioning: "${AUDIT_LOG_BY_TENANT_PARTITIONING:MONTHS}"
  # 未指定 startTime 和 endTime 时的默认历史天数
  default_query_period: "${AUDIT_LOG_DEFAULT_QUERY_PERIOD:30}"
  # 各实体类型的日志级别
  # 可选值：OFF（禁用）、W（记录写操作）、RW（记录读写操作）
  logging_level:
    mask:
      "device": "${AUDIT_LOG_MASK_DEVICE:W}"
      "asset": "${AUDIT_LOG_MASK_ASSET:W}"
      "dashboard": "${AUDIT_LOG_MASK_DASHBOARD:OFF}"
      "customer": "${AUDIT_LOG_MASK_CUSTOMER:W}"
      "user": "${AUDIT_LOG_MASK_USER:RW}"
      "rule": "${AUDIT_LOG_MASK_RULE:RW}"
      "plugin": "${AUDIT_LOG_MASK_PLUGIN:RW}"
```

此示例配置禁用与仪表板相关的任何操作的记录，并为用户和规则记录读取操作。
对于所有其他实体，ThingsBoard 仅记录写入级操作。

建议根据将记录的设备数量和用户操作修改「by_tenant_partitioning」参数。
计划记录的操作越多，分区粒度需越细。
每个分区的记录数建议不超过 500,000 条。

## 外部日志接收配置

系统管理员可配置与外部系统的连接。此连接将用于推送审计日志。
配置参数在行内有详细说明。

```yaml
  sink:
    # 外部接收器类型。可选：none、elasticsearch
    type: "${AUDIT_LOG_SINK_TYPE:none}"
    # 审计日志存储的索引名称
    # 索引名可含占位符（非必须）：
    # @{TENANT} - 替换为租户 ID
    # @{DATE} - 替换为 audit_log.sink.date_format 格式的当前日期
    index_pattern: "${AUDIT_LOG_SINK_INDEX_PATTERN:@{TENANT}_AUDIT_LOG_@{DATE}}"
    # 日期格式。格式说明见：
    # https://docs.oracle.com/javase/8/docs/{{docsPrefix}}api/java/time/format/DateTimeFormatter.html
    date_format: "${AUDIT_LOG_SINK_DATE_FORMAT:YYYY.MM.DD}"
    scheme_name: "${AUDIT_LOG_SINK_SCHEME_NAME:http}" # http 或 https
    host: "${AUDIT_LOG_SINK_HOST:localhost}"
    port: "${AUDIT_LOG_SINK_POST:9200}"
    user_name: "${AUDIT_LOG_SINK_USER_NAME:}"
    password: "${AUDIT_LOG_SINK_PASSWORD:}"
```
{% endunless %}

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
