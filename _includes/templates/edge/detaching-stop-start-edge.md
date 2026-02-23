可使用 **Ctrl+p** 后跟 **Ctrl+q** 从会话终端分离。容器将在后台继续运行。

若遇问题，可查看服务日志排查错误。
例如，要查看 {{serviceFullName}} 容器日志，执行以下命令：

```
docker compose logs -f my{{serviceName}}
```
{: .copy-code}

要 **停止** 容器，请执行：
```
docker compose stop my{{serviceName}}
```
{: .copy-code}

要 **启动** 容器，请执行：
```
docker compose start my{{serviceName}}
```
{: .copy-code}

要 **停止并清理** docker compose 环境并删除所有相关数据，请执行：
```bash
docker compose down -v
```
{: .copy-code}

要 **重建** 容器、卷和网络，请执行：
```bash
docker compose up -d
```
{: .copy-code}
