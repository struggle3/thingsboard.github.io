若某规则引擎队列使用 <code>RETRY_ALL、RETRY_FAILED、RETRY_TIMED_OUT</code> 或 <code>RETRY_FAILED_AND_TIMED_OUT</code> 策略，某个失败节点可能阻塞该队列中所有消息的处理。

可按以下步骤排查原因：

- 分析 [Rule Engine Statistics Dashboard](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-statistics)，查看是否有消息失败或超时。
  仪表盘底部会显示规则引擎中的异常描述及问题规则节点名称。

- 确定失败规则节点后，可[启用 DEBUG](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#debugging)，查看导致该节点失败的消息及详细错误描述。

**提示：** 可为不稳定或测试用例创建独立队列，与其它规则引擎分开。这样失败只会影响该独立队列，不会影响整个系统。
可通过 [Device Profile](/docs/{{docsPrefix}}user-guide/device-profiles/#queue-name) 的 queue-name 功能，为设备自动配置该逻辑。

**提示：** 对连接外部服务（REST API 调用、Kafka、MQTT 等）的规则节点，务必处理 <b>Failure</b> 事件。
这样可在外部系统出现故障时，保证规则引擎处理不会中断。
可将失败消息存入 DB、发送通知，或仅<b>记录</b>消息。