{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

{{appPrefix}}移动应用允许您在不修改代码的情况下进行以下自定义：

- **[自定义主屏幕](/docs/{{docsPrefix}}mobile/customize-dashboards)**
- **[自定义设备图标](/docs/{{docsPrefix}}mobile/customize-devices)**
- **[设置设备详情仪表板](/docs/{{docsPrefix}}mobile/device-dashboard)**
- **[设置告警详情仪表板](/docs/{{docsPrefix}}mobile/alarm-dashboard)**
- **[配置移动操作](/docs/{{docsPrefix}}mobile/mobile-actions)**
- **[配置OAuth 2.0](/docs/{{docsPrefix}}mobile/oauth2)**
- **[配置移动应用QR code设置](/docs/{{docsPrefix}}mobile/qr-code-settings/)**
- **[应用图标和启动画面](/docs/{{docsPrefix}}/mobile/app-icon-splash-screen)**
{% if docsPrefix == 'pe/' %}
- **[配置白标](/docs/pe/mobile/white-labeling)**
- **[配置自助注册](/docs/pe/mobile/self-registration)**
- **[配置移动应用QR code设置](/docs/pe/mobile/qr-code-settings/)**
{% endif %}
