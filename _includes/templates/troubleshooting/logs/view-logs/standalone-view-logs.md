实时查看最新日志：

```bash
tail -f /var/log/thingsboard/thingsboard.log
```

可使用 <b>grep</b> 命令仅显示包含指定字符串的输出。
例如，可用以下命令检查后端是否存在错误：

```bash
cat /var/log/thingsboard/thingsboard.log | grep ERROR
```