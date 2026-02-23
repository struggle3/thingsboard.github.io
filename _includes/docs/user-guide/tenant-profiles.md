
* TOC
{:toc}

{% assign sinceVersion = "3.2" %}
{% include templates/since.md %}

系统管理员可通过 Tenant Profiles 为多个 tenant 配置通用设置。
每个 Tenant 在同一时间点仅有一个 profile。

下面逐项说明 tenant profile 中的可用设置。

## Profile configuration

这些设置允许系统管理员配置 tenant 可创建的实体数量限制，设置每月最大消息数、API 调用数等限制，配置平台应为特定 device（device 级）或属于同一 tenant 的所有 device（tenant 级）处理的最大请求数等。

下面进一步说明这些设置。

### Entities limits

该组设置允许系统管理员配置每个 Tenant 可创建的最大实体数。

{% if docsPrefix == null %}
**[ThingsBoard社区版](/docs/user-guide/install/installation-options/)** 支持以下实体的限制：devices、dashboards、assets、users、customers、rule chains。

**[ThingsBoard专业版](/docs/user-guide/install/pe/installation-options/)** 支持上述全部及以下实体的限制：integrations、converters、scheduler events。
{% endif %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
**[ThingsBoard云平台](/docs/user-guide/install/pe/installation-options/)** 支持以下实体的限制：devices、dashboards、assets、users、integrations、scheduler events、customers、rule chains、converters。
{% endif %}

{% include images-gallery.html imageCollection="entityLimits" %}
 
### API Limits & Usage

该组设置允许系统管理员配置每个 Tenant 每月可执行的最大消息数、API 调用数等。
ThingsBoard 持续收集并分析 API 使用统计。统计的典型更新间隔为 1 分钟。

ThingsBoard 跟踪六个主要组件的 API 使用：Transport、Rule Engine、JS functions、Telemetry persistence、Email、SMS services。若任一相关 API Limit 达到阈值，平台将禁用该组件。
例如，若 Tenant 的 device 每月产生的消息超过 100M，平台将禁用属于该 Tenant 的所有 device 的连接。
当 API 使用被禁用或达到某阈值（通常为 80%）时，ThingsBoard 将通过邮件通知 Tenant 管理员。  

下面分别说明各项限制：

**Rule Engine executions** 表示属于当前 Tenant 的 rule node 的每次执行。处理单条 telemetry 消息可能触发多次 Rule Engine 执行。
平台还会统计 Generator node 等产生的周期消息。


**Transport Messages** 表示 device 发送到服务器的任何消息。可以是 telemetry、attribute 更新、RPC 调用等。

**Transport Data Points** 表示 telemetry 或 attribute 消息中包含的 Key-Value 对数量。
例如，以下消息包含 5 个 data point，因为 "jsonKey" 对应一个 data point。  

```json
{
 "stringKey":"value1", 
 "booleanKey":true, 
 "doubleKey":42.0, 
 "longKey":73, 
 "jsonKey": {
    "someNumber": 42,
    "someArray": [1,2,3],
    "someNestedObject": {"key": "value"}
 }
}
```

{% capture difference %}
**注意**：若 String 或 JSON key 的值超过 512 个字符，平台将按多个 data point 计费。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**JavaScript executions** 表示 Tenant 管理员定义的自定义函数的每次执行。例如，处理 "Script" filter 或 transformation node、调用 data converter 等。       

**Data points storage days** 针对数据库中存储的 time-series data point 计算。
平台将 data point 数量乘以这些 data point 的存储天数。TTL 参数用于提取存储天数。
例如，若存储 3 个 data point 30 天，则为 90 个 data point storage days。
系统管理员可在 tenant profile 的 "**Default Storage TTL Days**" 参数中配置默认 TTL。
Tenant 管理员可通过 "**Save Timeseries**" rule node 配置或在 post telemetry 请求的 "TTL" 参数中覆盖默认 TTL。

**Alarms TTL** 表示 alarm 在数据库中的存储天数。

**Alarms sent** 表示该周期（默认一个月）内创建的 alarm 总数。

**Emails sent** 表示使用系统 SMTP provider（settings）从 rule engine 发送的邮件数。
请注意，Tenant 管理员可在 Community 和 Professional 版本中定义自定义 SMTP 设置。
使用自定义 SMTP 设置发送的邮件不计入 API limits。  

**SMS sent** 表示使用系统 SMS provider 从 rule engine 发送的 SMS 数。
请注意，Tenant 管理员可在 Community 和 Professional 版本中定义自定义 SMS provider 设置。
使用自定义 SMTP 设置发送的 SMS 不计入 API limits。

{% include images-gallery.html imageCollection="api-limits" %}

#### API Usage dashboard

作为 Tenant 管理员，您可查看 API Usage dashboard。
下方 dashboard 允许 Tenant 管理员了解 hourly/daily/monthly API 使用情况，并实时查看 API limits 状态。 

{% include images-gallery.html imageCollection="apiLimitsDashboard" %}

### Files limits

系统管理员可配置单个文件的最大大小、"[Image gallery](/docs/{{docsPrefix}}user-guide/image-gallery/)" 中图片文件的最大总大小、"Resource Library" 中的资源文件最大总大小，以及平台可在数据库中存储的 [OTA package files](/docs/{{docsPrefix}}user-guide/ota-updates/) 最大总大小。

数值以 **bytes** 为单位。

{% include images-gallery.html imageCollection="files-limits" %}

### Rate Limits

该组设置允许系统管理员配置平台应为特定 device（device 级）或属于同一 tenant 的所有 device（tenant 级）处理的最大请求数。
Rate limit 基于 [token bucket](https://en.wikipedia.org/wiki/Token_bucket) 算法实现。

Rate limit 定义由数值与时间间隔组成。例如，"1000:60" 表示"60 秒内不超过 1000 条消息"。
可用 "," 定义多个间隔。例如，"100:1,1000:60" 表示"每秒 100 条突发，但 60 秒内不超过 1000 次"。

{% include images-gallery.html imageCollection="rateLimits" %}

## Processing in isolated ThingsBoard Rule Engine queues

ThingsBoard Rule Engine 是集群中的主要“工作单元”，负责处理入站消息。

默认情况下，所有消息（如 telemetry、connectivity、lifecycle 事件）推送到同一 message queue/topic（由 Kafka、RabbitMQ、AWS SQS、Azure Service Bus、Google Pub/Sub 支持）。
当禁用 isolated processing（默认）时，ThingsBoard 将来自所有 Tenant 的消息推送到公共 queue。 

当您为特定 tenant 选择 isolated 处理时，ThingsBoard 将消息推送到独立 queue。
这为这些 tenant 提供更好的隔离。您需创建启用 "Use isolated ThingsBoard Rule Engine queues" 的 tenant profile，
并分配给特定 Tenant，或更新现有 tenant profile。
这将指示 Rule Engine 订阅包含对应 tenant 数据的特定 message queue topic。

您还可配置单独处理特定 tenant profile 的 tenant 的 Rule Engine 实例。
参见 [configuration parameters](/docs/user-guide/install/config/#thingsboard-service-parameters)。

### Queue configuration for isolated tenants

{% include images-gallery.html imageCollection="isolatedQueueConfiguration" showListImageTitles="true"%}

为特定 tenant 分配 tenant profile 后，配置的 queue 会自动创建并启动，可立即在 rule chain 或 device profile 中使用。

更多 queue 设置参见 [guide](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-settings)
