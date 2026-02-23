Logs（日志）- 用于设置本地和远程日志的标签页，包含 3 个主要部分：
- General log settings（通用日志设置）- 使用 Python [logging](https://docs.python.org/3.8/library/logging.config.html) 模块的常规设置：
  - Date format（日期格式）- 日志消息的日期格式。
  - Log format（日志格式）- 日志消息格式。
- Remote logging（远程日志）- 配置远程日志：
  - Remote logs - 启用远程日志及从网关读取日志。
  - Log level（日志级别）。
- Local logging（本地日志）- 配置本地 logger（Service、Connector、Converter、TB Connection、Storage、Extension）：
  - Log level - 各本地 logger 的日志级别：INFO、DEBUG、WARNING、ERROR、CRITICAL、TRACE、NONE。
  - File path（文件路径）- 日志文件夹路径。
  - Log saving period（日志保存周期）。
  - Backup count - 若 **Backup count** > 0，则轮换时最多保留 **Backup count** 个文件， oldest 将被删除。

![](/images/gateway/dashboard/gateway-dashboard-logs-conf.png)
