{% capture edge_service_port_warn %}
**注意**：Edge 需能访问此端口才能通信。如需要，请更新防火墙设置或 Docker 配置。

{% endcapture %}
{% include templates/warn-banner.md content=edge_service_port_warn %}
