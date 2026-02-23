---
layout: docwithnav-mqtt-broker
title: TBMQ 路线图
description: TBMQ 即将发布的版本

---

* TOC
{:toc}

以下产品路线图仅涵盖主要功能，不包含小幅改进与 bug 修复。

## 即将发布

* **通过 Webhook 外部化客户端认证**
    * **重点：**安全与企业集成
    * **价值：**该特性使 TBMQ 可通过 webhook 调用将 MQTT 客户端认证（Client ID、Username、Password）委托给任意外部自定义身份服务或企业 IAM 系统，提供**灵活的安全策略**并简化与现有 IT 基础设施的集成。

* **实时客户端生命周期事件溯源**
    * **重点：**运维监控与数据管道
    * **价值：**使 broker 能将所有关键客户端生命周期事件（如连接、断开等）直接推送至外部系统（通过内置 TBMQ 集成如 Kafka、HTTP 等），确保**实时运维可见性**，便于准确的日志记录、审计及用量/计费计算。
