### 使用Docker和Ubuntu的100万连接配置

如何修改Docker文件以开箱即用地支持更多连接（可选）

```dockerfile
FROM thingsboard/tb:latest
USER root
RUN echo 'net.ipv4.ip_local_port_range = 1024 65535' >> /etc/sysctl.conf
RUN echo 'fs.file-max = 1048576' >> /etc/sysctl.conf
RUN echo '*                soft    nofile          1048576' >> /etc/security/limits.conf
RUN echo '*                hard    nofile          1048576' >> /etc/security/limits.conf
RUN echo 'root             soft    nofile          1048576' >> /etc/security/limits.conf
RUN echo 'root             hard    nofile          1048576' >> /etc/security/limits.conf
USER thingsboard
```
{: .copy-code}

将以下行添加到limits.conf文件。

cat | sudo tee -a /etc/security/limits.conf

```
## /etc/security/limits.conf
## "nofile"表示"打开文件数"
#<user>     <type>    <item>     <value>
*           soft      nofile     1048576
*           hard      nofile     1048576
root        soft      nofile     1048576
root        hard      nofile     1048576
```

将以下行添加到sysctl.conf文件。

cat | sudo tee -a /etc/sysctl.conf

```
## /etc/sysctl.conf
## 增加出站连接数
net.ipv4.ip_local_port_range = 1024 65535

## 增加入站连接数
## 100万以上文件描述符
fs.file-max = 1048576
```

### m6a.2xlarge（8 vCPU AMD EPYC 3rd、32 GiB、EBS GP3）+ Cassandra - 50万设备、5k条消息/秒、15k tps

架构为1台ThingsBoard服务器 + 20台客户端实例，每台提供2.5万设备（共50万）。

50万设备已连接

![](/images/reference/performance-aws-instances/method/m6a-2xlarge/500k-5k-15k/500k-is-connected-watsh-ss.png)

### m6a.4xlarge（16 vCPU AMD EPYC 3rd、64 GiB、EBS GP3）- 50万设备、10k条消息、30k tps - 几乎可承受

几乎可承受，但在50万设备下维持10k mps速率尚需进一步优化。持续改进中！

![](/images/reference/performance-aws-instances/method/m6a-4xlarge/500k-10k-30k/queue-stats.png)

![](/images/reference/performance-aws-instances/method/m6a-4xlarge/500k-10k-30k/api-usage.png)

![](/images/reference/performance-aws-instances/method/m6a-4xlarge/500k-10k-30k/aws-instance-monitoring.png)

![](/images/reference/performance-aws-instances/method/m6a-4xlarge/500k-10k-30k/aws-storage-monitoring.png)

### m6a.4xlarge（16 vCPU AMD EPYC 3rd、64 GiB、EBS GP3）+ Cassandra - 100万设备、5k条消息/秒、15k tps

架构为1台ThingsBoard服务器 + 32台客户端实例，每台提供31250台设备（共100万）。

准备`pt01`实例示例。参见同时管理多台实例的专用脚本

```bash
ssh tb2 <<'ENDSSH'
set +x
#optional. replace with your Thingsboard instance ip
#echo '52.50.5.45 thingsboard' | sudo tee -a /etc/hosts
#extend the local port range up to 64500 
cat /proc/sys/net/ipv4/ip_local_port_range
#32768	60999
echo "net.ipv4.ip_local_port_range = 1024 65535" | sudo tee -a /etc/sysctl.conf
sudo -s sysctl -p
cat /proc/sys/net/ipv4/ip_local_port_range
#1024	65535
sudo apt update
sudo apt install -y git maven docker docker-compose htop iotop mc screen
# manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# test non-root docker run
docker run hello-world
cd ~
git clone https://github.com/thingsboard/performance-tests.git
# git pull
cd performance-tests
./build.sh
ENDSSH
```

```bash
ssh pt01 <<'ENDSSH'
cd ~/performance-tests
export REST_URL=http://172.31.25.132:8080
export MQTT_HOST=54.171.220.200
export DEVICE_START_IDX=0
export DEVICE_END_IDX=50000
export MESSAGES_PER_SECOND=500
export ALARMS_PER_SECOND=1
export DURATION_IN_SECONDS=86400
export DEVICE_CREATE_ON_START=true
nohup mvn spring-boot:run &
ENDSSH
```

重要：为处理超过256k（限制取决于总内存大小）的TCP连接，请调整`conntrack_max`系统参数。

在`thingsboard`节点上运行一次以增加文件描述符和netfilter限制。处理约100万TCP连接需要此配置。

```bash
ulimit -n 1048576
sudo sysctl -a | grep conntrack_max
sudo sysctl -w net.netfilter.nf_conntrack_max=1048576
```

管理20–32台测试实例的脚本

_includes/docs/reference/performance-scripts/*.sh
init-tests.sh
ping-from-tests.sh
reboot-tests.sh
run-test.sh
ssh-tests.sh
test-ips.sh

docker-compose配置如下

```bash
#100万设备
version: '3.0'
services:
  cassandra:
    image: bitnamilegacy/cassandra:4.0
    network_mode: "host"
    restart: "always"
    volumes:
      - cassandra:/bitnami
    environment:
      CASSANDRA_CLUSTER_NAME: "Thingsboard Cluster"
      HEAP_NEWSIZE: "6144M"
      MAX_HEAP_SIZE: "12288M"
      JVM_EXTRA_OPTS: "-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=7199 -Dcom.sun.management.jmxremote.rmi.port=7199  -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1"
  zookeeper:
    image: bitnamilegacy/zookeeper:3.7
    network_mode: "host"
    restart: "always"
    volumes:
      - zookeeper:/bitnami
    environment:
      ALLOW_ANONYMOUS_LOGIN: "yes"
      ZOO_ENABLE_ADMIN_SERVER: "no"
      JVMFLAGS: "-Xmx128m -Xms128m -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9199 -Dcom.sun.management.jmxremote.rmi.port=9199  -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1"
  kafka:
    image: bitnamilegacy/kafka:3
    network_mode: "host"
    restart: "always"
    volumes:
      - kafka:/bitnami
    environment:
#      KAFKA_CFG_LISTENERS: "PLAINTEXT://:9092"
#      KAFKA_CFG_ADVERTISED_LISTENERS: "PLAINTEXT://127.0.0.1:9092"
      KAFKA_CFG_ZOOKEEPER_CONNECT: "localhost:2181"
      ALLOW_PLAINTEXT_LISTENER: "yes"
      KAFKA_JMX_OPTS: "-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.rmi.port=1099 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1"
      JMX_PORT: "1099"
    depends_on:
      - zookeeper
  postgres:
    image: "postgres:14"
    network_mode: "host"
    restart: "always"
    volumes:
      - postgres:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: "thingsboard"
      POSTGRES_PASSWORD: "postgres"
  tb:
    image: "thingsboard/tb"
#    build:
#      context: .
#      dockerfile: Dockerfile # for the custom build for experimental setup
    depends_on:
      - postgres
      - kafka
      - cassandra
    network_mode: "host"
    restart: "always"
    volumes:
      - thingsboard-data:/data
      - thingsboard-logs:/var/log/thingsboard
    environment:
      DATABASE_TS_TYPE: "cassandra"
      DATABASE_TS_LATEST_TYPE: "cassandra" # this is a key difference
      #Cassandra
      CASSANDRA_CLUSTER_NAME: "Thingsboard Cluster"
      CASSANDRA_LOCAL_DATACENTER: "datacenter1"
      CASSANDRA_KEYSPACE_NAME: "thingsboard"
      CASSANDRA_URL: "127.0.0.1:9042"
      CASSANDRA_USE_CREDENTIALS: "true"
      CASSANDRA_USERNAME: "cassandra"
      CASSANDRA_PASSWORD: "cassandra"
      CASSANDRA_QUERY_BUFFER_SIZE: "3000000"
      CASSANDRA_QUERY_CONCURRENT_LIMIT: "3000"
      CASSANDRA_QUERY_POLL_MS: "3"
      #Kafka
      TB_QUEUE_TYPE: "kafka"
      TB_KAFKA_BATCH_SIZE: "65536" # default is 16384 - it helps to produce messages much efficiently
      TB_KAFKA_LINGER_MS: "5" # default is 1
      TB_QUEUE_KAFKA_MAX_POLL_RECORDS: "2048" # default is 8192
      TB_SERVICE_ID: "tb-node-0"
      HTTP_BIND_PORT: "8088"
      # Queue
      TB_QUEUE_RE_MAIN_PACK_PROCESSING_TIMEOUT_MS: "30000"
      TB_QUEUE_CORE_PACK_PROCESSING_TIMEOUT_MS: "20000"
      TB_QUEUE_RE_MAIN_CONSUMER_PER_PARTITION: "true"
      TB_QUEUE_RE_HP_CONSUMER_PER_PARTITION: "false"
      TB_QUEUE_RE_SQ_CONSUMER_PER_PARTITION: "false"
      ACTORS_SYSTEM_RULE_DISPATCHER_POOL_SIZE: "8"
      # Postgres connection
      SPRING_DATASOURCE_URL: "jdbc:postgresql://localhost:5432/thingsboard"
      SPRING_DATASOURCE_USERNAME: "postgres"
      SPRING_DATASOURCE_PASSWORD: "postgres"
      SPRING_DATASOURCE_MAXIMUM_POOL_SIZE: "25"
      # Cache specs
      #1M devices
      CACHE_SPECS_DEVICES_MAX_SIZE: "1048000" # default is 10000
      CACHE_SPECS_DEVICE_CREDENTIALS_MAX_SIZE: "1048000" # default is 10000 
      CACHE_SPECS_SESSIONS_MAX_SIZE: "1048000" # default is 10000
      TS_KV_PARTITIONS_MAX_CACHE_SIZE: "4194000" # default is 100000
      # Device state service
      DEFAULT_INACTIVITY_TIMEOUT: "1800" # defailt is 600 sec (10min)
      DEFAULT_STATE_CHECK_INTERVAL: "900" # default is 60 sec(1min)
      TB_TRANSPORT_SESSIONS_REPORT_TIMEOUT: "60000" # default is 3000 msec
      TB_TRANSPORT_SESSIONS_INACTIVITY_TIMEOUT: "600000" # default is 300000 msec
      PERSIST_STATE_TO_TELEMETRY: "true" # Persist device state to the Cassandra. Default is false (Postgres, as device server_scope attributes)
      #Transport API
      TB_QUEUE_TRANSPORT_MAX_PENDING_REQUESTS: "1000000" # default is 10k
      #DEBUG
      CASSANDRA_USE_JMX: "true"
      CASSANDRA_USE_METRICS: "true"
      # Java options for 64G instance and JMX enabled 
      JAVA_OPTS: " -Xss512k -Xmx20480M -Xms20480M -XX:+AlwaysPreTouch -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.rmi.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1"
    ulimits:
      nofile:
        soft: 1048576
        hard: 1048576
volumes: # to persist data between container restarts or being recreated
  cassandra:
  kafka:
  zookeeper:
  postgres:
  thingsboard-data:
  thingsboard-logs:
```
{: .copy-code}

如何通过SSH为此部署中所有Java应用转发JMX端口。
```bash
ssh -L 9999:127.0.0.1:9999 -L 1099:127.0.0.1:1099 -L 9199:127.0.0.1:9199 -L 7199:127.0.0.1:7199 thingsboard 
```

为PostgreSQL启用pg_stat_statements预加载库
```bash
#config before 
docker exec -it ubuntu_postgres_1 tail /var/lib/postgresql/data/postgresql.conf
#apply changes
docker exec -it ubuntu_postgres_1 /bin/bash
echo "shared_preload_libraries = 'pg_stat_statements'" >> /var/lib/postgresql/data/postgresql.conf
exit
#check the result 
docker exec -it ubuntu_postgres_1 tail /var/lib/postgresql/data/postgresql.conf
```

检查网络连接数。
`watch -n 1 ss -s`

如何生成Java堆转储
```bash
ssh thingsboard
#docker exec -it ubuntu_tb_1 /bin/bash
docker exec -it ubuntu_tb_1 ps -A | grep java
# 8 ?        00:01:46 java
docker exec -it ubuntu_tb_1 jmap -dump:live,format=b,file=/data/dump.hprof 8
# Heap dump file created
sudo mv /var/lib/docker/volumes/ubuntu_thingsboard-data/_data/dump.hprof ~
sudo chown ubuntu:ubuntu ~/dump.hprof
exit
#带压缩复制，速度更快
scp -C tb2:/home/ubuntu/dump.hprof ~
```

100万设备的测试结果如下！

![](/images/reference/performance-aws-instances/method/m6a-4xlarge/500k-10k-30k/queue-stats.png)

![](/images/reference/performance-aws-instances/method/m6a-4xlarge/500k-10k-30k/api-usage.png)

![](/images/reference/performance-aws-instances/method/m6a-4xlarge/500k-10k-30k/aws-instance-monitoring.png)

![](/images/reference/performance-aws-instances/method/m6a-4xlarge/500k-10k-30k/aws-storage-monitoring.png)

结论：
1. 我们做到了！ThingsBoard展现了良好的代码与设计质量。
2. 在单节点上以单体部署超过10万设备投入生产风险较高。
3. 切勿在生产环境中进行此类实验。
4. 本案例有助于发现瓶颈并进一步优化性能。