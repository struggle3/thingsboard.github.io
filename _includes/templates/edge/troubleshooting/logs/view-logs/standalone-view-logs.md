在运行时查看最新日志：

```bash
tail -f /var/log/tb-edge/tb-edge.log
```

可使用 <b>grep</b> 命令仅显示包含指定字符串的输出。
例如，可用以下命令检查服务端是否存在错误：

```bash
cat /var/log/tb-edge/tb-edge.log | grep ERROR
```
