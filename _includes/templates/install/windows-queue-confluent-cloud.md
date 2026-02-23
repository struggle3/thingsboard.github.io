{% include templates/install/queue-confluent-cloud-config.md %}

##### ThingsBoard 配置

以管理员身份打开记事本或其他编辑器（右键点击应用图标并选择“以管理员身份运行”）。  
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而非“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\conf\thingsboard.yml
``` 
{: .copy-code}

并找到 "queue:" 配置块。确保队列类型为 "kafka"，副本因子为 "3"，use confluent cloud 为 "true"。

**请勿忘记**将 "CLUSTER_API_KEY"、"CLUSTER_API_SECRET" 和 "localhost:9092" 替换为您的实际 Confluent Cloud 引导服务器地址：

```yml
queue:
  type: "${TB_QUEUE_TYPE:kafka}"
...
  kafka:
    bootstrap.servers: "${TB_KAFKA_SERVERS:localhost:9092}"
...
    replication_factor: "${TB_QUEUE_KAFKA_REPLICATION_FACTOR:3}"
...
    use_confluent_cloud: "${TB_QUEUE_KAFKA_USE_CONFLUENT_CLOUD:true}"
...
      sasl.config: "${TB_QUEUE_KAFKA_CONFLUENT_SASL_JAAS_CONFIG:org.apache.kafka.common.security.plain.PlainLoginModule required username=\"CLUSTER_API_KEY\" password=\"CLUSTER_API_SECRET\";}"
```

**这些参数影响每个队列每个分区的每秒请求数。**

发往特定消息队列的请求数按以下公式计算：

((Number of Rule Engine and Core Queues) * (Number of partitions per Queue) + 
(Number of transport queues) + (Number of microservices) + (Number of JS executors)) * 1000 / POLL_INTERVAL_MS

例如，基于默认参数的请求数为：

规则引擎队列：

Main **10** partitions + HighPriority **10** partitions + SequentialByOriginator **10** partitions = **30**

核心队列 **10** 个分区

传输请求队列 + 响应队列 = **2**

规则引擎传输通知队列 + 核心传输通知队列 = **2**

总计 = **44**

每秒请求数 = **44 * 1000 / 25 = 1760** 个请求

根据使用场景，若消息负载较低，您可在延迟与队列分区数/请求数之间权衡，减少分区或请求数。

通过 UI 为规则引擎队列设置参数：interval (1000) 和 partitions (1)。

以下为“单体”部署下实现每秒 **10** 个请求的示例参数：

```yml
queue:
...
  transport_api:
    request_poll_interval: "${TB_QUEUE_TRANSPORT_REQUEST_POLL_INTERVAL_MS:1000}"
    response_poll_interval: "${TB_QUEUE_TRANSPORT_RESPONSE_POLL_INTERVAL_MS:1000}"
...
  core:
    poll-interval: "${TB_QUEUE_CORE_POLL_INTERVAL_MS:1000}"
    partitions: "${TB_QUEUE_CORE_PARTITIONS:2}"
...
  vc:
    partitions: "${TB_QUEUE_VC_PARTITIONS:1}"
    poll-interval: "${TB_QUEUE_VC_INTERVAL_MS:1000}"
...
  js:
    response_poll_interval: "${REMOTE_JS_RESPONSE_POLL_INTERVAL_MS:1000}"
...
  rule-engine:
    poll-interval: "${TB_QUEUE_RULE_ENGINE_POLL_INTERVAL_MS:1000}"
...
  transport:
    poll_interval: "${TB_QUEUE_TRANSPORT_NOTIFICATIONS_POLL_INTERVAL_MS:1000}"
```

您可通过 UI 更新默认规则引擎队列配置。有关 ThingsBoard 规则引擎队列的更多信息，请参阅[文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)。
