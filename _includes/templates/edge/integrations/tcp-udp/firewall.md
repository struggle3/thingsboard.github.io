{% capture tcp_udp_firewall_note %}
在运行远程 {{integrationName}} Integration 的机器上，必须为入站连接开放端口 **{{integrationPort}}**——**nc** 工具必须能连接到 {{integrationName}} socket。
若在本地运行，通常无需额外更改。
{% endcapture %}
{% include templates/info-banner.md content=tcp_udp_firewall_note %}
