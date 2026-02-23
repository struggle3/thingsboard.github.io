结果会立即处理，无需使用 Rule Chain，确保最低延迟并根据所选选项直接处理。

**时序数据选项：**
- **Save to time series** — 将历史值存储到 <span class="code-light">ts_kv</span>。
- **Save to latest values** — 若时间戳更新，则更新 <span class="code-light">ts_kv_latest</span>。
- **Send to WebSockets** — 向活跃的 WebSocket 订阅者推送更新（不写入数据库）。
- **Send to Calculated fields** — 将更新转发给其他计算字段。  
  可构建*依赖字段链*，单次事件可触发多次二次计算，无需使用 Rule Chain。
- **Custom TTL** — 为此时序设置自定义存储时长（TTL）。  
  若关闭，则使用**租户配置**中定义的 TTL。

**属性选项：**
- **Save to database** — 将属性写入持久化存储。
- **Send to WebSockets** — 向活跃的 WebSocket 订阅者推送更新（不写入数据库）。
- **Send to Calculated fields** — 通知其他计算字段属性变更，实现级联计算。
- **Update attribute only on value change** — 仅在值实际变化时更新属性。
- **Send attributes updates notification** — 生成“属性已更新”事件并发送至 Default Rule Chain。