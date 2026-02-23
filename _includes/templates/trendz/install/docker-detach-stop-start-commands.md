可使用 `Ctrl-p` `Ctrl-q` 组合键从终端会话中分离，容器将在后台继续运行。

若遇问题，可查看服务日志排查错误。
例如，查看 Trendz 容器日志可执行：

```
docker compose logs -f trendz
```
{: .copy-code}

停止容器：

```
docker compose stop trendz
```
{: .copy-code}

启动容器：

```
docker compose start trendz
```
{: .copy-code}
