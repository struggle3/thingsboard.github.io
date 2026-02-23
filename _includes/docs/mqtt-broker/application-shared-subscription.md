
* TOC
{:toc}

Application Shared Subscription 实体提供为 **APPLICATION** 客户端使用[共享订阅](/docs/{{docsPrefix}}mqtt-broker/user-guide/shared-subscriptions/)的能力。该功能允许多个客户端订阅并接收来自共享订阅的消息。
创建 Application Shared Subscription 实体后，会自动创建对应的 Kafka 主题。
该 Kafka 主题作为该共享订阅所有消息的存储库。

要在系统中创建新的 Application Shared Subscription 实体，需要以 Admin 用户身份进行认证。

{% include templates/mqtt-broker/authentication.md %}

### 创建/更新 Application Shared Subscription

```bash
curl --location --request POST 'http://localhost:8083/api/app/shared/subs' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "test",
    "partitions": 1,
    "topicFilter": "test/topic"
}'
```
{: .copy-code}

执行上述请求后，将在 PostgreSQL 数据库中创建一个实体，并添加名为 `tbmq.msg.app.shared.test.topic` 的 Kafka 主题。
该 Kafka 主题将包含单个分区。
{% include templates/mqtt-broker/application-shared-subscriptions.md %}

**请注意**：实体创建后，无法更新 _partitions_ 或 _topicFilter_ 字段。
因此，在创建实体前，务必仔细考虑所需的主题过滤器和分区数量。
建议使用较多而非较少的分区数量创建实体。
这样可在未来添加新客户端到共享订阅时实现水平扩展。
若实体已使用不当的值或配置创建，则需删除该实体并重新创建具有正确值的新实体。
因此，在初次创建过程中务必谨慎并做出明智决策，以避免后续修改或重建。

举例而言，若预计有 5 个客户端将订阅某一主题过滤器，
建议将分区数量配置为 5 的倍数，例如 5、10 或 15。
这样可确保负载在订阅者之间均匀分布，促进均衡处理并提升性能。

### 获取所有 Application Shared Subscription 实体

```bash
curl --location --request GET 'http://localhost:8083/api/app/shared/subs?pageSize=100&page=0' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}
**注意**：_pageSize_ 参数为 100，_page_ 参数为 0，因此上述请求将获取前 100 个 Application Shared Subscription 实体。

### 删除 Application Shared Subscription 实体

删除 Application Shared Subscription 实体后，对应的 Kafka 主题也将被删除。
**注意**：为此需将 `TB_KAFKA_ENABLE_TOPIC_DELETION` 环境变量设置为 `true`。

```bash
curl --location --request DELETE 'http://localhost:8083/api/app/shared/subs/$APP_SHARED_SUBS_ID' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}

请将 _$APP_SHARED_SUBS_ID_ 替换为要删除的 Application Shared Subscription 实体的实际 ID。
