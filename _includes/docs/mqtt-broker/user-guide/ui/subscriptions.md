
* TOC
{:toc}

{% if docsPrefix != "pe/" %}
{% assign sinceVersion = "2.0" %}
{% include templates/mqtt-broker/since.md %}
{% endif %}

在 MQTT 中，subscription 是允许客户端接收发往特定主题的消息的机制。
客户端订阅主题时，表示希望接收发往该主题的所有消息。

## Subscriptions 表

在 Subscriptions 页面，可**查看、分析或筛选** broker 上的所有订阅。
表包含每项订阅的以下信息：
* **Client ID**。 拥有该订阅的客户端标识符。
{% include templates/mqtt-broker/subscription-options.md %}

{% include images-gallery.html imageCollection="subscriptions-table" %}

## 管理订阅

可从 "Session details" 窗口轻松添加、删除或编辑订阅。
1. 在左侧菜单打开 "Subscriptions" 页面。
2. 点击表行打开[会话订阅](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/sessions/#subscriptions)详情。
3. 添加、编辑或删除客户端订阅。
4. 点击 "Update" 保存更改。

{% include images-gallery.html imageCollection="subscription-session" %}

{% capture monitoringSubscriptions %}
可在 [Monitoring](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/monitoring/) 和首页页面跟踪当前订阅数量及其它 broker 活动。
{% endcapture %}
{% include templates/info-banner.md title="Subscriptions chart" content=monitoringSubscriptions %}

## 清空空订阅节点

Broker 中的订阅使用 [Trie](https://en.wikipedia.org/wiki/Trie) 数据结构存储在内存中，
该结构以高效搜索著称。
Trie（亦称前缀树）是一种基于树的数据结构，可根据键或字符序列快速检索信息。

Trie 以层级方式组织 topic filters，每个节点表示 topic filter 的一个主题层级。
使用 Trie 结构，broker 可根据发布消息提供的 topic name 快速定位和检索客户端订阅。
这确保客户端能及时收到感兴趣的消息，有助于提升 broker 的性能与响应速度。

当客户端订阅被删除（unsubscribe）时，broker 从内存中移除数据并将节点标记为空。
随着时间推移，若删除大量订阅， broker 内存中可能遗留大量空节点。
这些空节点会导致效率下降并浪费内存资源。

清空空订阅节点可释放内存资源，并可能提升 broker 性能，
因为空节点减少后，订阅匹配处理会更快。

清空空订阅节点：点击右上角 "Clear empty subscription nodes" 按钮（垃圾桶图标）并确认。

{% include images-gallery.html imageCollection="clear-empty-subscription-nodes" %}

此外，broker 通过调度器配置为定期清空空订阅节点。由以下环境变量控制：
`MQTT_SUB_TRIE_CLEAR_NODES_CRON` 和 `MQTT_SUB_TRIE_CLEAR_NODES_ZONE`。
