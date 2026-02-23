{% if docsPrefix == "pe/" %}
{% capture paas_only %}
Solution Templates 可在 [ThingsBoard Cloud](/products/paas/) 中使用。自 3.3.1PE 版本起，[ThingsBoard PE](/products/thingsboard-pe/) 也提供 Solution templates。
{% endcapture %}
{% include templates/info-banner.md content=paas_only %}
{% endif %}
