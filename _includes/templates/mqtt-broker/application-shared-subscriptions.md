主题名称的构建方式是将 MQTT 主题过滤器映射到对应的 Kafka 主题。
通过遵循特定的命名约定（MQTT 主题过滤器 -> Kafka 主题）实现该映射。

```
test/topic -> tbmq.msg.app.shared.test.topic
test/# -> tbmq.msg.app.shared.test.mlw
test/+ -> tbmq.msg.app.shared.test.slw
```

其中
* `tbmq.msg.app.shared.` 作为前缀添加
* `/` 替换为 `.`
* `#` 替换为 `mlw`（多级通配符）
* `+` 替换为 `slw`（单级通配符）

若 MQTT 主题过滤器包含上述未提及的任何特殊字符（除字母数字外），
将使用主题过滤器派生的哈希创建 Kafka 主题。
此方式可确保生成的 Kafka 主题有效且符合必要的命名约定。

```
tbmq.msg.app.shared.$TOPIC_FILTER_HASH
```

上述行为可通过 `TB_APP_PERSISTED_MSG_SHARED_TOPIC_VALIDATION` 属性进行调控。
默认情况下该变量已启用，表示验证流程处于激活状态，确保正确创建主题。
但若将该变量设为 _false_ 以禁用验证，
系统将不再为包含特殊字符的共享订阅创建 Kafka 主题，
导致无法创建对应主题。
配置环境和处理包含特殊字符的主题过滤器时请务必注意这一点。
