---
layout: docwithnav
assignees:
- ashvayka
title: 使用 AWS EKS 的单体设置
description: 在 AWS EKS 中使用 Kubernetes 的 ThingsBoard IoT 平台单体设置
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
---

* TOC
{:toc}

{% assign tbServicesFile = "tb-node.yml" %}

本指南将帮助您使用 AWS EKS 以单体模式搭建 ThingsBoard。
详见 [monolithic](/docs/reference/monolithic/) 架构页了解其工作原理。
与 Docker Compose 相比，通过 K8S 进行单体部署的优势在于，若 AWS 实例发生故障，K8S 将在另一实例上重启服务。我们将使用 Amazon RDS 作为托管 PostgreSQL。

## 前置条件

{% include templates/install/aws/eks-prerequisites.md %}

## 步骤 1. 克隆 ThingsBoard CE K8S 脚本仓库

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-ce-k8s.git
cd thingsboard-ce-k8s/aws/monolith
```

## 步骤 2. 配置并创建 EKS 集群

{% assign eksNote = "**1** 个 **m5.xlarge** 类型节点" %}
{% include templates/install/aws/eks-create-cluster.md %}

## 步骤 3. 创建 AWS 负载均衡器控制器

{% include templates/install/aws/eks-lb-controller.md %}

## 步骤 4. 配置数据库

### 步骤 4.1 Amazon PostgreSQL DB 配置

{% include templates/install/aws/rds-setup.md %}

### 步骤 4.2 Cassandra（可选）

{% include templates/install/aws/configure-cassandra.md %}

## 步骤 5. 安装

{% include templates/install/aws/eks-installation.md %}

## 步骤 6. 启动

执行以下命令部署资源：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后，您可调用 `kubectl get pods`。若一切正常，您应能看到 `tb-node-0` pod 处于 `READY` 状态。

## 步骤 7. 配置负载均衡器

### 7.1 配置 HTTP(S) 负载均衡器

{% include templates/install/aws/http-lb.md %}

### 7.2. 配置 MQTT 负载均衡器（可选）

{% include templates/install/aws/configure-mqtt.md %}

### 7.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/aws/configure-udp.md %}

### 7.4. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 8. 验证设置

{% include templates/install/aws/eks-validate.md %}

{% include templates/install/aws/eks-upgrading.md %}

{% include templates/install/aws/eks-deletion.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
