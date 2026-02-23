TBMQ API 由两部分组成：MQTT 客户端 API 和服务端 API。

MQTT 客户端 API 可查阅以下页面：

* [**MQTT Pub**](https://mosquitto.org/man/mosquitto_pub-1.html) - 发布消息。
* [**MQTT Sub**](https://mosquitto.org/man/mosquitto_sub-1.html) - 订阅主题。

服务端 API 以 REST API 形式提供：

* [**Administration REST API**](/docs/{{docsPrefix}}mqtt-broker/rest-api) - 服务端核心 API。
* [**Admin User Management**](/docs/{{docsPrefix}}mqtt-broker/user-management/) - 用户管理的服务端 API。
* [**MQTT Client Credentials Management**](/docs/{{docsPrefix}}mqtt-broker/mqtt-client-credentials-management/) - MQTT 客户端凭证管理的服务端 API。
* [**Application Shared Subscriptions Management**](/docs/{{docsPrefix}}mqtt-broker/application-shared-subscription/) - 应用共享订阅管理的服务端 API。

上述 API 提供管理 TBMQ 及与其交互的完整工具和功能，便于用户高效管理、控制及自定义基于 MQTT 的应用。
