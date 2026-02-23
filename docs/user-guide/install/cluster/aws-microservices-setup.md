---
layout: docwithnav
assignees:
- ashvayka
title: 使用 AWS EKS 的微服务设置
description: 在 AWS EKS 中使用 Kubernetes 的 ThingsBoard IoT 平台微服务设置

rdsSetup:
    0:
        image: /images/install/cloud/aws/rds-1.png
        title: '确保 PostgreSQL 版本为最新 16.x。'
    1:
        image: /images/install/cloud/aws/rds-2.png
        title: '妥善保管 PostgreSQL 主密码。我们将在本指南后续中使用 YOUR_RDS_PASSWORD 引用它。'
    2:
        image: /images/install/cloud/aws/rds-3.png
        title: '使用 "Provisioned IOPS" 以获得更好性能。'
    3:
        image: /images/install/cloud/aws/rds-4.png
        title: '确保 PostgreSQL RDS 实例可从 ThingsBoard 集群访问；实现此目的最简单的方法是在同一 VPC 中部署 PostgreSQL RDS 实例并使用 "eksctl-thingsboard-cluster-ClusterSharedNodeSecurityGroup-*" 安全组。'
    4:
        image: /images/install/cloud/aws/rds-5.png
        title: '确保使用 "thingsboard" 作为初始数据库名。'
    5:
        image: /images/install/cloud/aws/rds-6.png
        title: '禁用 "auto minor version update"。'

rdsEndpointUrl:
    0:
        image: /images/install/cloud/aws/rds-endpoint-url.png
        title: '数据库切换到 "Available" 状态后，导航至 "Connectivity and Security" 并复制 endpoint 值。我们将在本指南后续中使用 **YOUR_RDS_ENDPOINT_URL** 引用它。'

mskSetup:
    0:
        image: /images/install/cloud/aws/msk-1.png
        title: '打开 <b>AWS 控制台</b>，进入 <b>MSK</b> 并点击 "<b>创建集群</b>" 按钮。选择 "<b>自定义创建</b>" 方法。指定<b>集群名称</b>并选择 "<b>集群类型</b>" - "<b>Provisioned</b>"，这将允许您指定<b>代理数量和存储卷</b>。选择 <b>Apache Kafka 3.8.x 版本</b> 使用 <b>Express 代理</b> 或 <b>4.0.x 版本</b> 使用 <b>Standard 代理</b>。'
    1:
        image: /images/install/cloud/aws/msk-2.png
        title: '选择 <b>kafka.m7.large</b> 或类似实例类型。'
    2:
        image: /images/install/cloud/aws/msk-3.png
        title: '选择代理的<b>存储大小</b>（使用 ThingsBoard 默认分区设置时，Kafka 最多可使用 <b>100 GB</b>）。'
    3:
        image: /images/install/cloud/aws/msk-4.png
        title: '确保 <b>MSK 实例</b>可从 <b>ThingsBoard 集群</b>访问。实现此目的最简单的方法是在<b>同一 VPC 中部署 MSK 实例</b>。   
                我们还建议使用<b>私有子网</b>，这将使实例意外暴露到<b>互联网</b> virtually 不可能。'
    4:
        image: /images/install/cloud/aws/msk-5.png
        title: '使用<b>默认安全设置</b>。确保启用 "<b>Plaintext</b>" 模式。'
    5:
        image: /images/install/cloud/aws/msk-6.png
        title: '使用 "<b>Basic monitoring</b>" 或 "<b>Enhanced topic-level monitoring</b>" 设置。'
    
mskConnectionParams:
    0:
        image: /images/install/cloud/aws/msk-connection-params-1.png
        title: 'MSK 集群切换到 "<b>Active</b>" 状态后，导航至 "<b>Details</b>" 并点击 "<b>View client information</b>"。'
    1:
        image: /images/install/cloud/aws/msk-connection-params-2.png
        title: '复制<b> plaintext 的 bootstrap server 信息</b>——这是您的 <b>Kafka endpoint</b>。'

redisSetup:
    0:
        image: /images/install/cloud/aws/valkey-1.png
        title: '指定 <b>Valkey Engine 8.x 版本</b> 以及至少 1 GB 内存的节点类型。'
    1:
        image: /images/install/cloud/aws/valkey-3.png
        title: '确保 <b>Valkey 集群</b>可从 <b>ThingsBoard 集群</b>访问。实现此目的最简单的方法是在<b>同一 VPC 中部署 Valkey 集群</b>。我们还建议使用<b>私有子网</b>。使用您的<b>组 ID</b>。'
    2:
        image: /images/install/cloud/aws/valkey-2.png
        title: '禁用 "<b>Enable automatic backups</b>" 选项。'

redisEndpointUrl:
    0:
        image: /images/install/cloud/aws/valkey-4.png
        title: 'Valkey 集群切换到 "<b>Available</b> 状态</b> 后，导航至 "<b>Details</b>" 部分并复制 "<b>Endpoint</b>" 字段，<b>不含 ":6379" 端口后缀</b>——这是 ThingsBoard 的 <b>Valkey endpoint</b>。'

---

* TOC
{:toc}

本指南将帮助您使用 AWS EKS 以微服务模式搭建 ThingsBoard。
详见 [microservices](/docs/reference/msa/) 架构页了解将安装的每个组件的更多信息。
我们将使用 Amazon RDS 作为托管 PostgreSQL、Amazon MSK 作为托管 Kafka、Amazon ElastiCache 作为托管 Redis。

## 前置条件

{% include templates/install/aws/eks-prerequisites.md %}

## 步骤 1. 克隆 ThingsBoard CE K8S 脚本仓库

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-ce-k8s.git
cd thingsboard-ce-k8s/aws/microservices
```
{: .copy-code}

## 步骤 2. 配置并创建 EKS 集群

{% assign eksNote = "**3** 个 **m5.xlarge** 类型节点" %}
{% include templates/install/aws/eks-create-cluster.md %}

## 步骤 3. 创建 AWS 负载均衡器控制器

{% include templates/install/aws/eks-lb-controller.md %}

## 步骤 4. 配置数据库

### 步骤 4.1 Amazon PostgreSQL DB 配置

{% include templates/install/aws/rds-setup.md %}

### 步骤 4.2 Cassandra

{% include templates/install/aws/configure-cassandra.md %}

## 步骤 5. Amazon MSK 配置（可选）

{% include templates/install/aws/msk-setup.md %}

## 步骤 6. Amazon ElastiCache 配置（可选）

{% include templates/install/aws/redis-setup.md %}

## 步骤 7. CPU 和内存资源分配

脚本已为每项服务预配置了资源值。您可在 `resources` 子菜单下的 `.yml` 文件中修改它们。

**注意**：若要分配更多资源，您需要增加 Amazon 节点数量或使用更大的机器。

推荐的 CPU/内存资源分配：
- TB Node: 1.0 CPU / 2Gi 内存
- TB HTTP Transport: 0.5 CPU / 0.5Gi 内存
- TB MQTT Transport: 0.5 CPU / 0.5Gi 内存
- TB COAP Transport: 0.5 CPU / 0.5Gi 内存
- TB Web UI: 0.1 CPU / 100Mi 内存
- JS Executor: 0.1 CPU / 100Mi 内存
- Zookeeper: 0.1 CPU / 0.5Gi 内存

## 步骤 8. 安装

{% include templates/install/aws/eks-installation.md %}

## 步骤 9. 启动

执行以下命令部署 ThingsBoard 服务：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后，您可调用 `kubectl get pods`。若一切正常，您应能看到：

* 5x `tb-pe-js-executor`
* 2x `tb-pe-web-ui`
* 1x `tb-pe-node`
* 1x `tb-pe-web-report`
* 3x `zookeeper`。
  
每个 pod 应处于 `READY` 状态。

{% include templates/install/aws/start-transports.md %}

## 步骤 10. 配置负载均衡器

### 10.1 配置 HTTP(S) 负载均衡器

{% include templates/install/aws/http-lb.md %}

### 10.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "tb-services.yml" %}
{% include templates/install/aws/configure-mqtt.md %}

### 10.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/aws/configure-udp.md %}

### 10.4. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 11. 验证设置

{% include templates/install/aws/eks-validate.md %}

{% include templates/install/aws/eks-upgrading.md %}

{% include templates/install/aws/eks-deletion.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
