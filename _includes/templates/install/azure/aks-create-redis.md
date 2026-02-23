ThingsBoard 使用缓存来提高性能并避免频繁的数据库读取。
默认情况下，部署已使用本地 Valkey 缓存。Azure 不提供托管 Valkey 集群，但您可以根据 [Azure 文档](https://learn.microsoft.com/en-us/azure/aks/valkey-overview) 设置自己的 Valkey 集群，以替代默认部署。

{% capture redis-azure-version %}
自 **ThingsBoard v4.0.0** 起，Valkey 8.x 为官方支持版本。
Valkey 仍兼容 Redis 7.2.x，因此使用 Redis 的配置也可工作。
但 Redis 7.2.x 仅在 Enterprise 或 Enterprise Flash SKU 中可用。
Basic、Standard 和 Premium SKU 仍仅支持 **Redis 6.x**。
Redis Enterprise 安装指南请参阅：
[创建 Redis Enterprise 缓存](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/quickstart-create-redis-enterprise)
{% endcapture %}
{% include templates/info-banner.md content=redis-azure-version %}

编辑 `thirdparty.yml` 文件，找到名为 `tb-valkey` 的 StatefulSet 部分，将 `spec.replicas` 设置为 0。

Valkey 集群就绪后，需要在配置文件中替换端点。
若使用独立 Valkey，请编辑 `tb-cache-configmap.yml`，将 **REDIS_HOST** 值替换为 Redis 端点。
若以集群模式部署 Valkey，请将 **REDIS_HOST** 替换为：
```yaml
REDIS_CONNECTION_TYPE: cluster
REDIS_NODES: (用于引导的 "host:port" 对的逗号分隔列表)
```
