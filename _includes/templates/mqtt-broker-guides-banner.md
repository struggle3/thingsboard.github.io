{% if currentGuide != "GettingStartedGuide" %}
- [**快速入门指南**](/docs/{{docsPrefix}}mqtt-broker/getting-started/) - 本指南提供 TBMQ 的快速概览。
{% endif %}
{% if currentGuide != "InstallationGuides" %}
- [**安装指南**](/docs/{{docsPrefix}}mqtt-broker/install/installation-options/) - 学习如何使用 Docker 配置 TBMQ 或在 AWS、GCP、Azure 的 K8S 环境中部署。
{% endif %}
{% if currentGuide != "SecurityGuide" %}
- [**安全指南**](/docs/{{docsPrefix}}mqtt-broker/security/overview/) - 学习如何为 MQTT 客户端启用认证与授权。
{% endif %}
{% if currentGuide != "ConfigurationGuide" %}
- [**配置指南**](/docs/{{docsPrefix}}mqtt-broker/install/config/) - 了解 TBMQ 配置文件和参数。
{% endif %}
{% if currentGuide != "MQTTClientTypeGuide" %}
- [**MQTT 客户端类型指南**](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type/) - 了解 TBMQ 客户端类型。
{% endif %}
{% if currentGuide != "TBIntegrationGuide" %}
- [**与 ThingsBoard 集成**](/docs/{{docsPrefix}}mqtt-broker/user-guide/integrations/how-to-connect-thingsboard-to-tbmq/) - 了解如何将 TBMQ 与 ThingsBoard 集成。
{% endif %}
