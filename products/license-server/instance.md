---
layout: docwithnav-license
assignees:
- ashvayka
title: 管理实例
description: 通过 ThingsBoard 许可证服务器管理实例

---


**ThingsBoard 许可证服务器** 支持管理运行中的实例。应用许可证密钥后，ThingsBoard 客户端会从许可证服务器获取 InstanceID。一个许可证可与单个实例关联。
采用现代微服务部署方式，单一许可证密钥可在 ThingsBoard 集群的所有节点上运行。这简化了集群管理工作，并减少添加/移除集群节点所需的手动操作。在浮动模式下启动多个集群节点时，您可先在节点 1 使用许可证密钥，然后停用该节点，再在节点 2 应用现有密钥。

注意：同一密钥不能同时在两个或更多节点使用。根据许可证服务器[架构](/products/license-server/#architecture)，每个 ThingsBoard 客户端都会发送许可证验证请求。若许可证密钥与多个 InstanceID 绑定，ThingsBoard 将关闭相关实例。
