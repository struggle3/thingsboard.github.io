{% include templates/install/queue-kafka-in-docker.md %}

##### ThingsBoard 配置

以管理员身份打开记事本或其他编辑器（右键点击应用图标并选择“以管理员身份运行”）。  
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而非“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\conf\thingsboard.yml
``` 
{: .copy-code}

并找到 "queue:" 配置块。确保队列类型为 "kafka"，且**请勿忘记**将 "localhost:9092" 替换为您的实际 Kafka 引导服务器地址：

```yml
queue:
  type: "${TB_QUEUE_TYPE:kafka}"
...
  kafka:
    bootstrap.servers: "${TB_KAFKA_SERVERS:localhost:9092}"
    acks: "${TB_KAFKA_ACKS:all}"
    retries: "${TB_KAFKA_RETRIES:1}"
    batch.size: "${TB_KAFKA_BATCH_SIZE:16384}"
    linger.ms: "${TB_KAFKA_LINGER_MS:1}"
    buffer.memory: "${TB_BUFFER_MEMORY:33554432}"
    replication_factor: "${TB_QUEUE_KAFKA_REPLICATION_FACTOR:1}"
```
