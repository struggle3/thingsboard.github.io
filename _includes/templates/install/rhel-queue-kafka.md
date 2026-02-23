#### Docker 安装

为 [CentOS/RHEL](https://docs.docker.com/engine/install/centos/) 安装 Docker

{% include templates/install/docker-install-note.md %}

{% include templates/install/queue-kafka-in-docker.md %}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件

```text
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

将以下行添加到配置文件。**请勿忘记**将「localhost:9092」替换为实际的 Kafka bootstrap 服务器地址：

```bash
export TB_QUEUE_TYPE=kafka
export TB_KAFKA_SERVERS=localhost:9092
```
{: .copy-code}