
* TOC
{:toc}

可通过多种方式自定义 ThingsBoard 平台以满足需求：
{% unless docsPrefix contains 'paas/' %}
 - [Rule Engine](/docs/{{docsPrefix}}user-guide/contribution/rule-node-development/) - 可创建自定义规则节点并添加到 ThingsBoard 服务器实例。
{% endunless %}
 - [部件库](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/) - 可开发新部件。
{% unless docsPrefix %}
 - [设备连接协议](/docs/reference/protocols/) - 添加新协议或自定义[现有实现](https://github.com/thingsboard/thingsboard/tree/master/transport)。
{% else %}
{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}
 - [自定义 Integration](/docs/{{peDocsPrefix}}user-guide/integrations/custom/) - 可创建具有自定义配置的 integration，用于通过任意传输协议与设备通信。
{% endunless %}
