Statistics（统计）- 在此标签页可配置通用统计及自定义统计：
- General statistics（通用统计）- 启用/禁用网关统计（machine、storage、connector）。
- Custom statistics（自定义统计）- 启用/禁用使用自定义命令收集统计。
- Statistic send period（统计发送周期，秒）- 发送统计的时间周期。
- Custom send period（自定义发送周期，秒）- 发送自定义统计的时间周期。
- Commands（命令）- 用于收集附加统计的命令（添加新命令请点击 **"Add command"** 按钮）：
  - Timeseries name（时序名称）- 网关 telemetry key 名称。
  - Timeout（超时，秒）- 命令执行超时。
  - Command（命令）- 命令结果将作为 client attribute 的值使用（例如 **"/bin/sh -c ipconfig getifaddr en0"**）。
  - Advanced settings（高级设置）：
    - Install command（安装命令）- 用于安装所需包的命令（例如 **"apt-get install -y curl"**）。

![](/images/gateway/dashboard/gateway-dashboard-statistics-conf.png)
