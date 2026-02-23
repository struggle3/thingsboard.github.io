当前阶段，本节仅有一个参数：**Authentication Execution Order**。
该参数定义 broker 使用认证提供者验证 MQTT 客户端认证的顺序。

{% include images-gallery.html imageCollection="authentication-settings" %}

**关键规则：**
 
 - 已禁用的提供者将在认证流程中被跳过。
 - 认证流程在第一次成功结果处停止，或在所有已启用提供者评估完成后停止。
 - 若所有提供者均已禁用，客户端将在不进行 MQTT 客户端凭据验证的情况下完成认证。

{% capture scramExecution %}
SCRAM 认证方式始终由 broker 按照 MQTT 5.0 规范处理，不遵循已配置的认证提供者执行顺序。
{% endcapture %}
{% include templates/info-banner.md content=scramExecution %}
