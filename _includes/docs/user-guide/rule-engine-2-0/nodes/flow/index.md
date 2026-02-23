流控节点控制消息在规则引擎不同部分之间的流动方式。

这些节点可在队列之间转移消息以实现顺序处理或分离不同工作负载，可将消息转发到其他规则链，并将结果返回到调用规则链。

这使您能够通过将复杂逻辑拆分为可复用的规则链来构建模块化工作流。

- [确认](/docs/user-guide/rule-engine-2-0/nodes/flow/acknowledge) — 确认入站消息并将其转发到规则链中的下一节点。
- [检查点](/docs/user-guide/rule-engine-2-0/nodes/flow/checkpoint) — 将入站消息转移到指定队列。
- [规则链](/docs/user-guide/rule-engine-2-0/nodes/flow/rule-chain) — 将入站消息转发到指定规则链。
- [输出](/docs/user-guide/rule-engine-2-0/nodes/flow/output) — 与规则链节点配合使用。允许将消息处理结果发布到调用规则链。
