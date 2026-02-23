## 实验

Postgres + Kafka + Cassandra

### AMD与Intel实例上的Cassandra 4.0与3.11版本对比

Cassandra 4.0 m6a.xlarge (4 vCPU, 16 GiB)

![](/images/reference/performance-aws-instances/method/experiments/img_0.png)

Cassandra 3.11 m6a.xlarge (4 vCPU, 16 GiB)

![](/images/reference/performance-aws-instances/method/experiments/img_1.png)

Cassandra 4.0 c6i.xlarge (4 vCPU, 8 GiB)

![](/images/reference/performance-aws-instances/method/experiments/img_2.png)

### Cassandra 4.0 m6a.4xlarge（16 vCPU、32 GiB）最大消息速率实验

Cassandra 4.0 m6a.4xlarge（16 vCPU、32 GiB）

5k设备、15k条消息/秒、45k数据点/秒 —— 100%可处理

![](/images/reference/performance-aws-instances/method/experiments/img_4.png)

![](/images/reference/performance-aws-instances/method/experiments/img_3.png)

5k设备、25k条消息/秒、75k数据点/秒 —— 100%可处理

![](/images/reference/performance-aws-instances/method/experiments/img_5.png)

![](/images/reference/performance-aws-instances/method/experiments/img_6.png)

5k设备、40k条消息/秒、120k数据点/秒 - 出现瓶颈

![](/images/reference/performance-aws-instances/method/experiments/img_8.png)

CPU约60%，出现瓶颈。

![](/images/reference/performance-aws-instances/method/experiments/img_7.png)

尝试不将最新值持久化到PostgreSQL的时序写入——无效果

![](/images/reference/performance-aws-instances/method/experiments/img_9.png)
