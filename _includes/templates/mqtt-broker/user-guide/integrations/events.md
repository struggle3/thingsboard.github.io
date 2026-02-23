TBMQ 为 integration 相关事件提供日志，便于**调试和排查** integration 行为。
以下为三种「Event」类型：

{% assign integrationEvents = '
    ===
        image: /images/mqtt-broker/user-guide/ui/integration-events-1.png,
        title: **Lifecycle Events** – 记录 `Started`、`Created`、`Updated`、`Stopped` 等事件
    ===
        image: /images/mqtt-broker/user-guide/ui/integration-events-2.png,
        title: **Statistics** – 提供 integration 性能洞察，包括已处理消息数和错误数
    ===
        image: /images/mqtt-broker/user-guide/ui/integration-events-3.png,
        title: **Errors** – 记录与认证、超时、payload 格式或外部服务连通性相关的失败
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=integrationEvents %}
