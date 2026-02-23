ThingsBoard 使用 **Kafka 作为外部队列**，用于在微服务之间交换数据、存储未处理的消息等。
Kafka 有助于**处理峰值负载和故障**，确保来自设备的所有消息得到可靠处理。
默认情况下，部署使用**本地 Kafka**，但 ThingsBoard 也兼容 **Amazon MSK 等托管服务**。

以下为创建**基础 Kafka MSK 集群**的步骤：

- 打开 **AWS 控制台**，前往 [MSK](https://console.aws.amazon.com/msk){:target="_blank"}，点击“**创建集群**”按钮。
- 选择“**自定义创建**”方式。
- 指定**集群名称**，选择“**集群类型**”为“**预置型**”，以便指定**代理数量和存储卷**。
- 选择 **Apache Kafka 3.8.x** 使用 **Express 代理**，或 **4.0.x** 使用 **Standard 代理**。
- 选择 **kafka.m7.large** 或类似实例类型。
- 为代理选择**存储大小**（使用默认 ThingsBoard 分区设置时，Kafka 最多可使用 **100 GB**）。
- 确保 **MSK 实例**可从 **ThingsBoard 集群**访问。最简单的方式是**在同一 VPC 中部署 MSK 实例**。
  建议使用**私有子网**，这样几乎不可能意外将实例暴露到 **Internet**。
- 使用**默认安全设置**。确保启用“**Plaintext**”模式。
- 使用“**基本监控**”或“**增强主题级监控**”设置。

{% include images-gallery.html imageCollection="mskSetup" %}

**MSK 集群**切换为“**Active**”状态后，进入“**详情**”并点击“**查看客户端信息**”。
复制**明文 bootstrap server 信息**——即您的 **Kafka 端点**。

{% include images-gallery.html imageCollection="mskConnectionParams" %}

编辑 `tb-kafka.yml` 文件，找到名为 `tb-kafka` 的 **StatefulSet 部分**，将 `spec.replicas` 设置为 **0** 以禁用默认本地 **Kafka 部署**。

编辑 `tb-kafka-configmap.yml`，将 **TB_KAFKA_SERVERS** 值替换为 **MSK 端点**。
