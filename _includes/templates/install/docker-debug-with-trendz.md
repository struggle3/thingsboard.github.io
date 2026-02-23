如遇问题，可实时查看 ThingsBoard 容器日志：

```bash
docker compose -f docker-compose.yml -f docker-compose-trendz.yml logs -f thingsboard-pe
```
{: .copy-code}

实时查看 Trendz 容器日志：

```bash
docker compose -f docker-compose.yml -f docker-compose-trendz.yml logs -f trendz
```
{: .copy-code}

停止 Compose 文件中定义的所有容器：

```bash
docker compose -f docker-compose.yml -f docker-compose-trendz.yml down
```
{: .copy-code}

在后台模式启动所有服务：

```bash
docker compose -f docker-compose.yml -f docker-compose-trendz.yml up -d
```
{: .copy-code}
