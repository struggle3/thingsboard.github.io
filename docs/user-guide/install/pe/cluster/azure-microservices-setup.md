---
layout: docwithnav-pe
assignees:
- amykolaichuk
title: 使用 AKS 基础设施的微服务设置
description: 使用 Azure AKS 中的 Kubernetes 进行 ThingsBoard IoT 平台微服务设置

---

* TOC
{:toc}

本指南将帮助您在 Azure AKS 中以微服务模式设置 ThingsBoard。

## 前置条件

{% include templates/install/azure/aks-prerequisites.md %}

### 从 Docker Hub 拉取 ThingsBoard PE 镜像

{% include templates/install/dockerhub/checkout.md %}

## 步骤 1. 克隆 ThingsBoard PE K8S 脚本仓库

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-pe-k8s.git --depth 1
cd thingsboard-pe-k8s/azure/microservices
```
{: .copy-code}

## 步骤 2. 定义环境变量

{% include templates/install/azure/aks-env.md %}

## 步骤 3. 配置并创建 AKS 集群

{% assign nodeCount = "3" %}
{% include templates/install/azure/aks-create-cluster.md %}

## 步骤 4. 更新 kubectl 的上下文

{% include templates/install/azure/aks-kubectl-update-context.md %}

## 步骤 5. 配置数据库

### 5.1. 创建 Azure Database for PostgreSQL 服务器

{% include templates/install/azure/aks-create-db.md %}

### 5.2. Cassandra

{% include templates/install/azure/configure-cassandra.md %}

## 步骤 6. Azure Cache for Redis

{% include templates/install/azure/aks-create-redis.md %}

## 步骤 7. 配置许可证密钥

{% include templates/install/k8s-license-secret.md %}

## 步骤 8. 安装

{% include templates/install/azure/aks-installation.md %}

## 步骤 9. 启动

执行以下命令部署 ThingsBoard 服务：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后可执行 `kubectl get pods`。若一切正常，您应能看到 `tb-node-0` pod 处于 `READY` 状态。

{% include templates/install/azure/aks-starting-transports.md %}

## 步骤 10. 配置负载均衡器

### 10.1. 配置 HTTP(S) 负载均衡器
{% include templates/install/azure/aks-http-lb.md %}

### 10.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-mqtt-transport.yml" %}
{% include templates/install/azure/configure-mqtt.md %}

### 10.3. 配置 CoAP 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-coap-transport.yml" %}
{% include templates/install/azure/configure-coap.md %}

### 10.4. 配置 LwM2M 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-lwm2m-transport.yml" %}
{% include templates/install/azure/configure-lwm2m.md %}

### 10.5. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 11. 配置 Trendz（可选）

### 11.1. 从 Docker Hub 拉取 Trendz 镜像

{% include templates/install/trendz/pull_trendz.md %}

### 11.2. 在现有 Azure Database 中创建 Trendz 数据库

{% include templates/install/trendz/azure/k8s-trendz-db-creating.md %}

### 11.3. 启动 Trendz

{% include templates/install/trendz/k8s-trendz-starting.md %}

## 步骤 12. 使用

{% include templates/install/azure/using.md %}

## 升级

### 升级到新版 ThingsBoard

{% include templates/install/azure/upgrading-msa.md %}

### 升级到新版 Trendz（可选）

{% include templates/install/trendz/k8s-trendz-upgrading.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}

