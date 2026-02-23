以后台模式将全部容器（含 Trendz 容器）作为单一 Compose 项目启动，然后查看 ThingsBoard 日志：

```bash
docker compose -f docker-compose.yml -f docker-compose-trendz.yml up -d
docker compose -f docker-compose.yml -f docker-compose-trendz.yml logs -f thingsboard-pe
```
{: .copy-code}
