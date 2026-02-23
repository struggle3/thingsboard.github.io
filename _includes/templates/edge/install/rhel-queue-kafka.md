#### Docker 安装

为 [CentOS/RHEL](https://docs.docker.com/engine/install/centos/) 安装 Docker

{% include templates/install/docker-install-note.md %}

{% include templates/edge/install/queue-kafka-in-docker.md %}

##### ThingsBoard Edge 配置

编辑 **ThingsBoard Edge** 配置文件 (tb-edge.conf)：

```bash
echo -e "\nexport TB_QUEUE_TYPE=kafka\nexport TB_KAFKA_SERVERS=localhost:9092" | sudo tee -a /etc/tb-edge/conf/tb-edge.conf > /dev/null
```