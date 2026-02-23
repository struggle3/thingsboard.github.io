![image](/images/gateway/mqtt-connector/workers-settings-1-ce.png)

1. **Max messages queue per worker（每个 worker 的最大消息队列）**<br/>
单个 worker 在一次轮转中处理的 MQTT 消息数量，然后才让其他 worker 运行。
数值越大吞吐越高；越小延迟越低。例如：大量 telemetry 约 ~100，快速 RPC 约 ~10–20。

2. **Max number of workers（最大 worker 数量）**<br/>
同时运行的 worker 数量。worker 越多占用越多 CPU 核心，过多会导致竞争。
建议从接近 CPU 核心数起步，根据积压和 CPU 情况调整。
