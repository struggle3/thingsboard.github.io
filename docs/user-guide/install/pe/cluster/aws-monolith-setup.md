---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用 AWS 基础设施的单体设置
description: 使用 AWS EKS 中的 Kubernetes 进行 ThingsBoard IoT 平台单体设置

rdsSetup:
    0:
        image: /images/install/cloud/aws/rds-1.png
        title: '确保 PostgreSQL 版本为最新的 16.x'
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
---

* TOC
{:toc}

{% assign tbServicesFile = "tb-node.yml" %}

本指南将帮助您在 AWS EKS 中以单体模式设置 ThingsBoard。

## 前置条件

{% include templates/install/aws/eks-prerequisites.md %}

### 从 Docker Hub 拉取 ThingsBoard PE 镜像

{% assign checkoutMode = "monolith" %}
{% include templates/install/dockerhub/checkout.md %}

## 步骤 1. 克隆 ThingsBoard PE K8S 脚本仓库

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-pe-k8s.git --depth 1
cd thingsboard-pe-k8s/aws/monolith
```
{: .copy-code}

## 步骤 2. 配置并创建 EKS 集群

{% assign eksNote = "**1** node of type **m5.xlarge**" %}
{% include templates/install/aws/eks-create-cluster.md %}

## 步骤 3. 创建 AWS 负载均衡控制器

{% include templates/install/aws/eks-lb-controller.md %}

## 步骤 4. 配置数据库

### 步骤 4.1 Amazon PostgreSQL 数据库配置

{% include templates/install/aws/rds-setup.md %}

### 步骤 4.2 Cassandra（可选）

{% include templates/install/aws/configure-cassandra.md %}

## 步骤 5. 获取并配置许可证密钥

{% include templates/install/k8s-license-secret.md %}

## 步骤 6. 安装

{% include templates/install/aws/eks-installation.md %}

## 步骤 7. 启动

执行以下命令部署资源：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后可执行 `kubectl get pods`。若一切正常，您应能看到 `tb-node-0` pod 处于 `READY` 状态。

## 步骤 8. 配置负载均衡器

### 8.1 配置 HTTP(S) 负载均衡器

{% include templates/install/aws/http-lb.md %}

### 8.2. 配置 MQTT 负载均衡器（可选）

{% include templates/install/aws/configure-mqtt.md %}

### 8.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/aws/configure-udp.md %}

### 8.4. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 9. 配置 Trendz（可选）

### 9.1. 从 Docker Hub 拉取 Trendz 镜像

{% include templates/install/trendz/pull_trendz.md %}

### 9.2. 在现有 RDS 实例中创建 Trendz 数据库

{% include templates/install/trendz/eks/k8s-trendz-db-creating.md %}

### 9.3. 启动 Trendz

{% include templates/install/trendz/k8s-trendz-starting.md %}

## 步骤 10. 验证设置

{% include templates/install/aws/eks-validate.md %}

## 升级

### 升级到新版 ThingsBoard

{% include templates/install/aws/eks-upgrading.md %}

### 升级到新版 Trendz（可选）

{% include templates/install/trendz/k8s-trendz-upgrading.md %}

{% include templates/install/aws/eks-deletion.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
