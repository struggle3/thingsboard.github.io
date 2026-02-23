
* TOC
{:toc}

Application Shared Subscription 实体支持为 **APPLICATION** 客户端使用 [Shared Subscriptions](/docs/{{docsPrefix}}mqtt-broker/user-guide/shared-subscriptions/) 功能。
该功能允许多个客户端订阅共享订阅并接收消息。

## 使用说明

在 TBMQ 中，Application shared subscriptions 是用于管理共享订阅的实体。

* 若计划与 [Application clients](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type/#application-client) 使用共享订阅功能，请添加 Application shared subscriptions。
* 创建后，**Topic filter** 和 **Partitions** 字段**不可修改**。
* Application Shared Subscription 功能**支持 MQTT v5 及更早版本**。

Broker 管理员可通过 Web UI 或 [REST API](/docs/{{docsPrefix}}mqtt-broker/application-shared-subscription/) 管理共享订阅。

## 添加 Shared Subscription

添加新共享订阅，请按以下步骤操作：
1. 打开 _Shared Subscriptions_ 页面，点击加号图标 Add Application Shared Subscription。
2. 在对话框中填写以下字段：
   - **Name** - 共享订阅名称，可为任意名称，如 "Application Shared Subscription"。
   - **Topic filter** - 实际的主题过滤器，可包含通配符（#、+）。若共享订阅 topic filter 为 `$share/group1/city/+/home/#`，则将 Topic filter 字段设为 `city/+/home/#`。
       创建后不可修改，且必须唯一。
   - **Partitions** - 建议 partition 数量等于或为预期共享订阅客户端数量的倍数。
    例如，若有 5 个客户端将订阅该共享订阅，可将 Partitions 设为 5、10 或 15。
    这将保证负载在订阅者间均匀分布。创建后不可修改。
3. 点击 _Add_ 按钮。

{% include images-gallery.html imageCollection="add-shared-subscriptions" %}

执行上述操作后，将添加名为 `tbmq.msg.app.shared.city.slw.home.mlw` 的 Kafka topic。
{% include templates/mqtt-broker/application-shared-subscriptions.md %}

## 编辑 Shared Subscriptions

当前 TBMQ 版本中，创建后仅可编辑 Shared Subscription 的 Name 字段。

编辑实体步骤：
1. 点击 Shared Subscriptions 表中对应行。
2. 点击右上角铅笔图标的 _Toggle edit mode_ 按钮。
3. 修改名称。
4. 点击 _Apply changes_ 按钮保存。

## 删除 Shared Subscriptions

可通过 Web UI 或 [REST API](/docs/{{docsPrefix}}mqtt-broker/application-shared-subscription/) 从 TBMQ 系统中移除 Shared Subscriptions 实体。

删除方式：

1. **单条删除**。
   * 点击 subscriptions 对应行的 Delete 图标并确认。
   * 点击行后，在实体详情右侧面板中点击 _Delete Application Shared Subscription_ 按钮。
2. **批量删除**。
   * 勾选复选框选择多条，再点击右上角 Delete 图标并确认。

{% include images-gallery.html imageCollection="delete-shared-subscriptions" %}

删除 Application Shared Subscription 实体后，对应的 Kafka topic 也将被删除。
**注意**，需将 `TB_KAFKA_ENABLE_TOPIC_DELETION` 环境变量设为 `true`。
