{% capture contenttogglespec %}
ThingsBoard Cloud（云端）%,%cloud%,%templates/edge/install/prerequisites-pe-cloud.md%br%
Local Server（本地服务器）%,%on-premise%,%templates/edge/install/prerequisites-on-premise.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="cloudType" toggle-spec=contenttogglespec %}
