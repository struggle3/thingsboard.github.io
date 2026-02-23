---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用 AWS 基础设施的微服务设置
description: 使用 AWS EKS 中的 Kubernetes 进行 ThingsBoard IoT 平台微服务设置

rdsSetup:
    0:
        image: /images/install/cloud/aws/rds-1.png
        title: '确保 PostgreSQL 版本为最新的 16.x。'
    1:
        image: /images/install/cloud/aws/rds-2.png
        title: '请妥善保存 PostgreSQL 主密码。本指南稍后将使用 YOUR_RDS_PASSWORD 引用它。'
    2:
        image: /images/install/cloud/aws/rds-3.png
        title: '使用"预置 IOPS"以获得更好的性能。'
    3:
        image: /images/install/cloud/aws/rds-4.png
        title: '确保 ThingsBoard 集群可访问 PostgreSQL RDS 实例；最简单的方式是在同一 VPC 中部署 PostgreSQL RDS 实例，并使用 "eksctl-thingsboard-cluster-ClusterSharedNodeSecurityGroup-*" 安全组。'
    4:
        image: /images/install/cloud/aws/rds-5.png
        title: '确保使用 "thingsboard" 作为初始数据库名称。'
    5:
        image: /images/install/cloud/aws/rds-6.png
        title: '禁用"自动次要版本更新"。'

rdsEndpointUrl:
    0:
        image: /images/install/cloud/aws/rds-endpoint-url.png
        title: '数据库切换到"可用"状态后，进入"连接和安全"，复制端点值。本指南稍后将使用 **YOUR_RDS_ENDPOINT_URL** 引用它。'

mskSetup:
    0:
        image: /images/install/cloud/aws/msk-1.png
        title: '确保 Apache Kafka 版本为 3.7.x。'
    1:
        image: /images/install/cloud/aws/msk-2.png
        title: '确保 ThingsBoard 集群可访问 MSK 实例。最简单的方式是在同一 VPC 中部署 MSK 实例。建议使用私有子网，这样几乎不可能意外暴露到互联网。'
    2:
        image: /images/install/cloud/aws/msk-3.png
        title: '使用 m5.large 或类似实例类型。'
    3:
        image: /images/install/cloud/aws/msk-4.png
        title: '选择默认安全设置。确保启用"Plaintext"模式。'
    4:
        image: /images/install/cloud/aws/msk-5.png
        title: '使用"<b>基本监控</b>"或"<b>增强的主题级监控</b>"设置。'

mskConnectionParams:
    0:
        image: /images/install/cloud/aws/msk-connection-params.png
        title: 'MSK 集群切换到"Active"状态后，进入"Details"并点击"View client information"。'
    1:
        image: /images/install/cloud/aws/msk-connection-params2.png
        title: '复制纯文本的 bootstrap server 信息。本指南稍后将使用 **YOUR_MSK_BOOTSTRAP_SERVERS_PLAINTEXT** 引用它。'

redisSetup:
    0:
        image: /images/install/cloud/aws/valkey-1.png
        title: '指定 <b>Valkey Engine 版本 8.x</b> 以及至少 1 GB RAM 的节点类型。'
    1:
        image: /images/install/cloud/aws/valkey-3.png
        title: '确保 <b>ThingsBoard 集群</b> 可访问 <b>Valkey 集群</b>。最简单的方式是 <b>在同一 VPC 中部署 Valkey 集群</b>。建议使用 <b>私有子网</b>。使用您的 <b>group ID</b>。'
    2:
        image: /images/install/cloud/aws/valkey-2.png
        title: '禁用"<b>启用自动备份</b>"选项。'

redisEndpointUrl:
    0:
        image: /images/install/cloud/aws/valkey-4.png
        title: '<b>Valkey 集群</b> 切换到 "<b>可用</b>" 状态后，进入 "<b>Details</b>" 部分，复制 "<b>Endpoint</b>" 字段（<b>不含 ":6379" 端口后缀</b>）——这是 ThingsBoard 的 <b>Valkey 端点</b>。'

---

* TOC
{:toc}

{% assign tbServicesFile = "tb-services.yml" %}

本指南将帮助您在 AWS EKS 中以微服务模式设置 ThingsBoard。

## 前置条件

{% include templates/install/aws/eks-prerequisites.md %}

### 从 Docker Hub 拉取 ThingsBoard PE 镜像

{% include templates/install/dockerhub/checkout.md %}

## 步骤 1. 克隆 ThingsBoard PE K8S 脚本仓库

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-pe-k8s.git --depth 1
cd thingsboard-pe-k8s/aws/microservices
```
{: .copy-code}

## 步骤 2. 配置并创建 EKS 集群

{% assign eksNote = "**3** nodes of type **m5.xlarge**" %}
{% include templates/install/aws/eks-create-cluster.md %}

## 步骤 3. 创建 AWS 负载均衡控制器

{% include templates/install/aws/eks-lb-controller.md %}

## 步骤 4. 配置数据库

### 步骤 4.1 Amazon PostgreSQL 数据库配置

{% include templates/install/aws/rds-setup.md %}

### 步骤 4.2 Cassandra（可选）

{% include templates/install/aws/configure-cassandra.md %}

## 步骤 5. Amazon MSK 配置

{% include templates/install/aws/msk-setup.md %}

## 步骤 6. Amazon ElastiCache (Redis) 配置

{% include templates/install/aws/redis-setup.md %}

## 步骤 7. 配置 Kafka (Amazon MSK)/Redis/Postgres 链接

{% include templates/install/aws/links.md %}

## 步骤 8. 获取并配置许可证密钥

{% include templates/install/k8s-license-secret.md %}

## 步骤 9. CPU 与内存资源分配

脚本已为每项服务预配置资源值。您可在 `resources` 子菜单下的 `.yml` 文件中修改。

**注意**：若要分配更多资源，需增加 Amazon 节点数量或使用更大的机器。

推荐的 CPU/内存资源分配：
- TB Node: 1.5 CPU / 6Gi memory
- TB HTTP Transport: 0.5 CPU / 2Gi memory
- TB MQTT Transport: 0.5 CPU / 2Gi memory
- TB COAP Transport: 0.5 CPU / 2Gi memory
- TB Web UI: 0.3 CPU / 0.5Gi memory
- JS Executor: 0.1 CPU / 0.3Gi memory
- Zookeeper: 0.3 CPU / 1Gi memory
- Trendz (Optional): 2 CPU / 4Gi memory
- Trendz Python Executor (Optional): 1 CPU / 4Gi memory

## 步骤 10. 安装

{% include templates/install/aws/eks-installation.md %}

## 步骤 11. 启动

执行以下命令部署 ThingsBoard 服务：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后可执行 `kubectl get pods`。若一切正常，您应能看到：

* 5x `tb-js-executor`
* 1x `tb-node`（默认设置一个节点，若许可证包含附加实例，可扩展为多个节点）
* 2x `tb-web-ui`
* 3x `zookeeper`。

每个 pod 应处于 `READY` 状态。

{% include templates/install/aws/start-transports.md %}

## 步骤 12. 配置负载均衡器

### 12.1 配置 HTTP(S) 负载均衡器

{% include templates/install/aws/http-lb.md %}

### 12.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "tb-services.yml" %}
{% include templates/install/aws/configure-mqtt.md %}

### 12.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/aws/configure-udp.md %}

### 12.4. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 13. 配置 Trendz（可选）

### 13.1. 从 Docker Hub 拉取 Trendz 镜像

{% include templates/install/trendz/pull_trendz.md %}

### 13.2. 在现有 RDS 实例中创建 Trendz 数据库

{% include templates/install/trendz/eks/k8s-trendz-db-creating.md %}

### 13.3. 启动 Trendz

{% include templates/install/trendz/k8s-trendz-starting.md %}

## 步骤 14. 验证设置

{% include templates/install/aws/eks-validate.md %}

## 升级

### 升级到新版 ThingsBoard

{% include templates/install/aws/eks-upgrading.md %}

### 升级到新版 Trendz（可选）

{% include templates/install/trendz/k8s-trendz-upgrading.md %}

{% include templates/install/aws/eks-deletion.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
