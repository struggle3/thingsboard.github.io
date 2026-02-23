进入包含 `docker-compose.yml` 的目录，执行以下命令启动 Docker Compose：

```
docker compose --profile trendz up -d && docker compose logs -f trendz
```
{: .copy-code}

执行后可在浏览器中打开 `http://{your-host-ip}:8888`（如 `http://localhost:8888`）。
您将看到 Trendz 登录页面。
