外部节点是 ThingsBoard 规则引擎的集成组件，用于将消息发送到第三方服务和外部系统。

这些节点向 ThingsBoard 外部的目的地发布或传输数据，包括云平台（AWS、Azure、GCP）、消息系统（MQTT、Kafka、RabbitMQ）、通信服务（邮件、SMS、Slack）、AI 服务和 REST API。

这使规则链能够与外部基础设施和服务集成，作为自动化工作流的一部分。

- [AI 请求](/docs/user-guide/rule-engine-2-0/nodes/external/ai-request) — 向大语言模型发送可自定义提示和可选文件附件的请求，将 AI 生成的响应作为出站消息数据返回。
- [AWS Lambda](/docs/user-guide/rule-engine-2-0/nodes/external/aws-lambda) — 以入站消息数据为负载调用 AWS Lambda 函数，并将函数响应作为出站消息数据返回。
- [AWS SNS](/docs/user-guide/rule-engine-2-0/nodes/external/aws-sns) — 将入站消息数据发布到 AWS SNS 主题，在出站消息中返回响应元数据。
- [AWS SQS](/docs/user-guide/rule-engine-2-0/nodes/external/aws-sqs) — 将入站消息数据发布到 AWS 简单队列服务 (SQS) 队列，在出站消息中返回响应元数据。
- [Azure IoT Hub](/docs/user-guide/rule-engine-2-0/nodes/external/azure-iot-hub) — 使用 MQTT 协议（QoS 1）将入站消息数据发布到 [Azure IoT Hub](https://azure.microsoft.com/en-us/products/iot-hub)，支持 SAS 令牌和 X.509 证书认证。
- [GCP Pub/Sub](/docs/user-guide/rule-engine-2-0/nodes/external/gcp-pubsub) — 将入站消息数据发布到 [Google Cloud Pub/Sub](https://cloud.google.com/pubsub){:target="_blank"} 主题，在出站消息中返回响应元数据。
- [Kafka](/docs/user-guide/rule-engine-2-0/nodes/external/kafka) — 将消息发布到 [Apache Kafka](https://kafka.apache.org/){:target="_blank"} 主题，以入站消息数据作为记录值发送。
- [MQTT](/docs/user-guide/rule-engine-2-0/nodes/external/mqtt) — 使用 QoS 1（至少一次）将入站消息数据发布到外部 MQTT 代理，支持动态主题模式、多种认证方式和 TLS/SSL 加密。
- [RabbitMQ](/docs/user-guide/rule-engine-2-0/nodes/external/rabbitmq) — 将消息发布到 [RabbitMQ](https://www.rabbitmq.com/){:target="_blank"} 交换机，以入站消息数据作为消息体发送。
- [REST API 调用](/docs/user-guide/rule-engine-2-0/nodes/external/rest-api-call) — 使用可配置的方法、认证和代理设置向外部端点发送 HTTP 请求，将响应作为出站消息数据返回。
- [发送邮件](/docs/user-guide/rule-engine-2-0/nodes/external/send-email) — 通过 SMTP 服务器发送邮件，支持 TLS 加密和代理配置。
- [发送通知](/docs/user-guide/rule-engine-2-0/nodes/external/send-notification) — 通过[通知中心](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}使用通知模板向指定收件人发送通知。
- [发送短信](/docs/user-guide/rule-engine-2-0/nodes/external/send-sms) — 通过 AWS SNS、Twilio 或 SMPP 提供商向指定电话号码发送短信，支持模板化。
- [发送到 Slack](/docs/user-guide/rule-engine-2-0/nodes/external/send-to-slack) — 通过 Slack API 向 [Slack](https://slack.com/){:target="_blank"} 公共频道、私有频道或私信发送消息。
- <span class="item-pe product-label-padding">[Twilio 短信](/docs/user-guide/rule-engine-2-0/nodes/external/twilio-sms)</span> — 通过 [Twilio](https://www.twilio.com/messaging/channels/sms){:target="_blank"} 将入站消息数据以短信形式发送到指定电话号码。
- <span class="item-pe product-label-padding">[Twilio 语音](/docs/user-guide/rule-engine-2-0/nodes/external/twilio-voice)</span> — 通过 [Twilio](https://www.twilio.com/voice){:target="_blank"} 语音转文字服务将入站消息数据以语音消息形式发送到指定电话号码。
