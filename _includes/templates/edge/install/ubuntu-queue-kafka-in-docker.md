### Docker 安装

为 [Ubuntu](https://docs.docker.com/engine/install/ubuntu/) 安装 Docker

{% include templates/install/docker-install-note.md %}

{% include templates/edge/install/queue-kafka-in-docker.md %}

##### ThingsBoard Edge 配置

编辑 **ThingsBoard Edge** 配置文件 (tb-edge.conf)：

```text
echo -e "export TB_QUEUE_TYPE=kafka\nexport TB_KAFKA_SERVERS=localhost:9092" | sudo tee -a /etc/tb-edge/conf/tb-edge.conf > /dev/null
```
{: .copy-code}

如有需要，**请务必**将 "localhost:9092" 替换为您的 Kafka bootstrap 服务器地址
