ThingsBoard 使用**缓存**来提高性能并减少频繁的数据库读取。默认情况下，部署使用**本地 Valkey 缓存**。
但 ThingsBoard 也兼容 **Amazon ElastiCache** 等托管服务。

以下为创建**基础 ElastiCache Valkey 集群**的步骤：
- 打开 AWS 控制台，前往 [ElastiCache Valkey 缓存](https://console.aws.amazon.com/elasticache#/valkey)，点击“**创建**”按钮。
- 可选择 **Serverless** 或 **设计您自己的缓存** 作为部署选项。
- 指定 **Valkey 引擎版本 8.x** 以及至少 1 GB 内存的节点类型。
- 确保 **Valkey 集群**可从 **ThingsBoard 集群**访问。最简单的方式是**在同一 VPC 中部署 Valkey 集群**。建议使用**私有子网**。使用您的**组 ID**。
- 关闭“**启用自动备份**”选项。

{% include images-gallery.html imageCollection="redisSetup"%}

**Valkey 集群**切换为“**Available**”状态后，进入“**详情**”部分，复制“**Endpoint**”字段的值**（不含 ":6379" 端口后缀）**——即 ThingsBoard 的 **Valkey 端点**。

{% include images-gallery.html imageCollection="redisEndpointUrl"%}

编辑 `tb-valkey.yml` 文件，找到名为 `tb-valkey` 的 **StatefulSet 部分**，将 `spec.replicas` 设置为 **0** 以禁用默认本地 Valkey 部署。

然后编辑 `tb-cache-configmap.yml`，将 **REDIS_HOST** 值替换为您的 **Valkey 端点**。
