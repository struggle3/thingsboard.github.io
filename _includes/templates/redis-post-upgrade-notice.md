{% capture redis-notice %}
若将 Redis 用于缓存，在启动 ThingsBoard 前需清空所有已存储的 key。

连接到您的 Redis 实例（或 container/pod，视部署方式而定），执行：

`redis-cli flushall`

注意：仅当 Redis 专门用于 ThingsBoard 时可使用此命令。若其他应用也使用 Redis，需定位 ThingsBoard 使用的数据库并仅清空该库。默认数据库 index 为 0，可通过 <a style="pointer-events: all;" href="/docs/user-guide/install/config/">ThingsBoard 环境变量</a> REDIS_DB 配置。

`redis-cli`

`select 0`

`flushdb`
 
{% endcapture %}
{% include templates/info-banner.md content=redis-notice %}
