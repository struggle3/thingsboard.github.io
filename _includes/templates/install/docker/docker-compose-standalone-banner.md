{% capture dockerComposeStandalone %}
自 **3.4.2** 版本起，ThingsBoard 支持 **Docker Compose V2**（Docker Desktop 或 Compose 插件），因为 Docker 不再支持 **docker-compose** 作为独立安装方式。

**我们强烈建议升级到 Docker Compose V2 并使用它。**

如仍使用带连字符的 docker-compose，请执行以下命令启动 **ThingsBoard**：

**docker-compose up -d && docker-compose logs -f my{{serviceName}}**

{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}
