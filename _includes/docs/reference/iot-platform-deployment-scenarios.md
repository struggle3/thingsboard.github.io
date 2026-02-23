
* TOC
{:toc}

本文介绍ThingsBoard支持的常用部署架构。
各类部署场景均有利弊，选择合适架构需综合考虑总拥有成本（TCO）、性能及高可用性需求。
从最简单场景入手，展示如何从最小化部署升级到更复杂的架构。

以下提供在AWS上部署ThingsBoard的总拥有成本（TCO）估算示例。
重要说明：以下所有计算与价格仅为近似值，仅供参考，具体定价请咨询您的云服务商。

## Performance requirements {: #performance-requirements }

我们整理了以下项目，以便快速估算典型物联网方案的性能需求：

1. 生产环境或每年连接的设备、资产、客户、客户用户和租户总数；
2. 每台设备每日最大与平均消息量；
3. 设备载荷的最大与平均大小；
4. 每条消息中的平均数据点数量；
5. 设备连接所用的通信协议或集成类型；
6. 实体数据保留期限（以年为单位）。

对上述参数有大致了解后，即可估算所需基础设施。
ThingsBoard性能很大程度上取决于设备产生的消息量及消息结构。

**示例1：20,000 台追踪器**
 
20,000 台设备每分钟向云端发送一条消息，消息格式如下：

```json
{"latitude": 42.222222, "longitude": 73.333333, "speed": 55.5, "fuel": 92, "batteryLevel": 81}
```
在此场景下，ThingsBoard持续维护20,000个连接，每秒处理333条消息。
每条消息包含5个数据点，可能需分别绘图/分析/查询。
每秒产生1,667次数据库写入请求，每天约1.43亿次。
根据所选数据库类型，每日约占用1–2GB（Cassandra）或7–10GB（PostgreSQL）存储。

**示例2：100,000 台智能电表** 

100,000 台LoRaWAN设备每小时向云端发送一条消息，消息格式如下：

```json
{"pulseCounter": 1234567, "leakage": false, "batteryLevel": 81}
```
ThingsBoard通过HTTP或MQTT从可用网络服务器接收上行消息。
典型消息速率为100,000 / 3600 = 28 条/秒，负载较低。
每条消息含3个数据点，可能需分别绘图/分析/查询。
但我们决定不存储 "leakage" 属性，因其多数情况下为 "false"，冗余度较高，仅用于触发告警。
这会导致每秒55.5次数据库写入请求，每天约478万次。
根据所选数据库类型，每日约占用100MB（Cassandra）或238MB（PostgreSQL）存储。

## Key infrastructure characteristics {: #key-infrastructure-characteristics }

根据[性能需求](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#performance-requirements)，
可确定ThingsBoard服务器/集群的关键特征：

- **每秒入站消息数**（主要影响内存和CPU消耗）；
- **并发活跃设备会话数**（主要影响内存消耗）；
- **由规则引擎处理的消息数**（主要影响CPU消耗）；
- **持久化数据点数量**（直接影响IOPS及对应数据库）。 

ThingsBoard集群可水平扩展，便于应对内存/CPU相关负载。
但需谨慎规划持久化数据点数量（上述最后一项）。
若使用PostgreSQL，建议将每秒写入的记录数控制在20,000以下。
若采用混合数据库（PostgreSQL + Cassandra），可将遥测写入扩展至100万数据点/秒，但属性更新仍写入PostgreSQL，20,000限制依然适用。  

## Deployment Scenarios {: #deployment-scenarios }

### 单机部署（场景A）

最简单的部署场景，根据真实生产用例，适用于最多30万台设备、每秒10,000条消息及10,000个数据点。
该场景需在同一台服务器（本地或云端）上部署ThingsBoard平台和PostgreSQL数据库。
HAProxy负载均衡器也安装在同一台服务器上，充当反向代理，并可选择作为TLS终止代理。
见下图。

<object width="80%" data="/images/reference/deployment/single.svg"></object>

**优点**：

* 部署极简，使用[安装指南](/docs/user-guide/install/{{docsPrefix}}installation-options/)约10分钟即可完成；
* 软件实例维护与更新简单。

**缺点**：

* 升级时会产生停机时间，每次约5–10分钟；
* 高可用性有限，硬件或应用故障会影响所有设备与用户；
* 无数据耐久性保障，全部存储于单台服务器；
* 系统性能受单台服务器性能限制。

**性能**：

整体性能取决于实例硬件，并高度依赖数据库性能。
在单机部署场景中建议使用PostgreSQL同时存储实体与遥测数据。
典型虚拟环境可处理约5,000个遥测数据点/秒。
参见[关键基础设施特征](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#key-infrastructure-characteristics)
及不同AWS实例的[性能测试](/docs/{{docsPrefix}}reference/performance-aws-instances/)文档。这些信息有助于为您的方案正确选型基础设施。 

**总拥有成本（TCO）示例**：

假设10,000台LoRaWAN智能电表设备每小时向云端发送一条消息。

单台AWS EC2 "m5.large" 实例约41.66 USD/月（1年预付费约500 USD/年）。
500 GB存储约50 USD/月。
基础设施总成本约100 USD/月。

单份ThingsBoard PE永久许可证（v3.0以下）2,999 USD（含首年可选更新和基础支持）。后续年份软件更新 + 基础支持为1,199 USD。

TCO：约350 USD/月，按10k设备折算约0.035 USD/月/设备。
添加[高级支持](/services/support/)包后约850 USD/月，或0.085 USD/月/设备。  

**说明与建议**：

此部署场景简单，适合开发环境、原型验证及早期初创公司。
在正式投产前，建议配置数据备份脚本，并定期将数据库快照上传至耐久存储（如AWS S3）等。
建议定期对服务器实例做快照，以缩短可能的故障恢复时间。
  
若希望减少数据库维护投入，建议使用云托管数据库。详见场景B。 

### 单机部署与外部数据库（场景B）

此场景与场景A相似，但需在独立服务器上部署托管数据库。
ThingsBoard客户成功使用[AWS RDS](https://aws.amazon.com/rds/postgresql/)、[Azure Database for PostgreSQL](https://azure.microsoft.com/en-us/services/postgresql/)
和[Google Cloud SQL](https://cloud.google.com/sql/docs/postgres/)以简化数据库配置、备份及支持工作。
见下图。

<object width="80%" data="/images/reference/deployment/standalone.svg"></object>

**优点**：

* 部署简单（使用安装指南约1小时即可完成）；
* 软件实例维护与更新方便；
* 数据与托管备份、故障转移分开存储。

**缺点**：

* 升级时会有停机，每次约5分钟；
* 高可用性有限，硬件或应用故障时需管理员手动恢复系统；
* 系统性能受单台服务器限制。

**性能**：

整体性能取决于实例硬件，并高度依赖数据库性能。
在此场景中建议使用PostgreSQL同时存储实体与遥测数据。
典型虚拟环境可处理约5,000个遥测数据点/秒。
参见[关键基础设施特征](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#key-infrastructure-characteristics)
及不同AWS实例的[性能测试](/docs/{{docsPrefix}}reference/performance-aws-instances/)。

**场景B总拥有成本示例**：

假设10,000台LoRaWAN智能电表设备每小时向云端发送一条消息。

单台AWS EC2 "m5.large" 实例约41.66 USD/月（年付约500 USD/年）。
Amazon RDS PostgreSQL实例（db.t2.medium、Multi-AZ）约200 USD/月。
基础设施总成本约250 USD/月。

单份ThingsBoard PE永久许可证2,999 USD（含首年可选更新和基础支持）。后续年份为1,199 USD。

TCO：约500 USD/月，即约0.05 USD/月/设备（10k设备）。
添加[高级支持](/services/support/)包后约1,000 USD/月，或0.1 USD/月/设备。  

### 微服务架构集群部署（场景C）

ThingsBoard支持微服务架构（MSA），可实现百万级设备的可扩展部署。详见[平台架构](/docs/{{docsPrefix}}reference/msa/)。通过MSA部署，管理员可灵活调整transport、rule-engine、web-ui和JavaScript executor微服务数量，从而根据当前负载优化集群。

ThingsBoard使用[Kafka](https://kafka.apache.org/)作为主消息队列与流处理方案，使用[Redis](https://redis.io/)作为分布式缓存，使用[Cassandra](https://cassandra.apache.org/)作为高可用、可扩展的NoSQL数据库。
注意Cassandra为可选，仅在遥测数据速率较高（超过20,000数据点/秒）时建议使用。
其他场景下基于PostgreSQL的部署即可满足需求。

**优点**：

* Kubernetes部署简单；
* 无单点故障（SPOF）；
* 高可用系统；
* 小版本升级无停机。

**缺点**：

* 设备数量较少（<100,000 台/ThingsBoard集群）时TCO偏高。  

**性能**：

整体性能取决于集群硬件及所用数据库性能。
5台ThingsBoard服务器和5个Cassandra节点组成的虚拟机组可支持100万台设备；
详见[关键基础设施特征](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#key-infrastructure-characteristics)。
  
**集群部署场景总拥有成本示例**：

#### 100万智能电表TCO

**示例1：** 假设**100万**台LoRaWAN/NB-IoT**智能电表**设备**每小时**向云端发送一条消息。
每条消息含3个数据点，可能需分别绘图/分析/查询。
消息通过HTTP或UDP集成发送至ThingsBoard（此类场景的典型方式）。

100万台设备对应280条消息/秒负载（1,000,000 设备 / 3600 秒），即每秒280 × 3 = 840次数据库写入请求（数据点），或每天7260万次。
根据所选数据库类型，每天约消耗1.2GB（Cassandra）或4GB（PostgreSQL）磁盘空间。

以下Kubernetes集群足以支持该用例：

- 2 × "r5.xlarge" 实例（4 vCPU、32 GB RAM）用于托管2个ThingsBoard Node容器。约380 USD/月。
- 3 × "c5.large" 实例（2 vCPU、4 GB RAM）用于托管3个Zookeeper及约9个JS Executor。约120 USD/月。
- 基于2 × "cache.m5.large"的Amazon ElastiCache for Redis。约200 USD/月。 
- 基于3 × "kafka.m5.large"及1TB数据存储的Amazon Managed Streaming for Kafka。约620 USD/月。
- 基于 "db.m5.large" Multi-AZ部署的Amazon RDS for PostgreSQL。约220 USD/月。
- 1TB Multi-AZ存储。约230 USD/月。 

<object width="100%" data="/images/reference/deployment/smart-meter-cluster.svg"></object>

因此，基础设施成本约1,770 USD/月，即约0.00177 USD/月/设备。

2份ThingsBoard PE永久许可证共5,998 USD（含首年可选更新和基础支持）。后续年份为2,398 USD。
超过10k设备的用例需提供**托管服务**以支持生产环境（非基础支持订阅）。费率为0.01 USD/设备/月。 
 
TCO：约12,270 USD/月，即约0.01227 USD/月/设备。

**如需在自身集群上复现此用例，请参考：**
[智能电表用例性能测试](https://github.com/ashvayka/tb-pe-k8s-perf-tests/tree/scenario/1-million-smart-meters)

#### 100万智能追踪器TCO

**示例2：** 假设100万台**智能追踪器**设备**每分钟**向云端发送读数。
每条消息含5个数据点，可能需分别绘图/分析/查询。 

典型消息速率为1,000,000 / 60 秒 = 16,667 条/秒。
对应每秒16,667 × 5 = 83,335次数据库写入请求（数据点），或每天72亿次。
Cassandra可稳定承担此负载，每天约144GB，考虑Cassandra内3副本，每天约需432GB磁盘空间。

以下Kubernetes集群足以支持该用例：

- 8 × "c5.large" 实例（2 vCPU、4 GB RAM）用于托管8个ThingsBoard MQTT Transport容器。约320 USD/月。
- 15 × "c5.xlarge" 实例（4 vCPU、8 GB RAM）用于托管15个ThingsBoard Node容器。约1,095 USD/月。
- 15 × "c5.xlarge" 实例（4 vCPU、8 GB RAM）用于托管15个Cassandra容器。约1,095 USD/月。
- 3 × "c5.xlarge" 实例（2 vCPU、4 GB RAM）用于托管3个Zookeeper及约30个JS Executor。约240 USD/月。
- 基于2 × "cache.m5.large"的Amazon ElastiCache for Redis。约200 USD/月。 
- 基于3 × "kafka.m5.large"及1TB数据存储的Amazon Managed Streaming for Kafka。约620 USD/月。
- 基于 "db.m5.large" Multi-AZ部署的Amazon RDS for PostgreSQL。约220 USD/月。 
- 100TB部署存储。约10,000 USD/月。 

<object width="100%" data="/images/reference/deployment/smart-tracker-cluster.svg"></object>

因此，基础设施成本约13,790 USD/月，即约0.0138 USD/月/设备。
15份ThingsBoard PE永久许可证（v3.0以下）共44,985 USD（含首年可选更新和基础支持）。后续年份为17,985 USD。
ThingsBoard**托管服务**支持生产环境：0.01 USD/设备/月。 

TCO：约27,508 USD/月，即约0.0275 USD/月/设备。

**如需在自身集群上复现此用例，请参考：**
[智能追踪器用例性能测试](https://github.com/ashvayka/tb-pe-k8s-perf-tests/tree/scenario/1-million-smart-trackers)
