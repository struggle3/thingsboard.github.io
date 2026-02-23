---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用 GCP 基础设施的微服务设置
description: 使用 GKE 中的 Kubernetes 进行 ThingsBoard IoT 平台微服务设置

---

* TOC
{:toc}

本指南将帮助您在 GKE 中以微服务模式设置 ThingsBoard。

## 前置条件

{% include templates/install/gcp/gke-prerequisites.md %}

## 从 Docker Hub 拉取 ThingsBoard PE 镜像

{% assign checkoutMode = "microservices" %}
{% include templates/install/dockerhub/checkout.md %}

## 步骤 1. 克隆 ThingsBoard PE K8S 脚本仓库

克隆仓库并将工作目录切换到 GCP 脚本目录。

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-pe-k8s.git --depth 1
cd thingsboard-pe-k8s/gcp/microservices
```
{: .copy-code}

## 步骤 2. 定义环境变量

{% assign tbClusterName = "tb-pe-msa" %}
{% assign tbDbClusterName = "tb-db" %}
{% include templates/install/gcp/env-variables-msa.md %}

## 步骤 3. 配置并创建 GKE 集群

{% include templates/install/gcp/regional-gke-cluster.md %}

## 步骤 4. 更新 kubectl 的上下文

{% include templates/install/gcp/update-kubectl-region.md %}

## 步骤 5. 配置数据库

### 步骤 5.1 Google Cloud SQL (PostgreSQL) 实例

{% assign tbDbName = "thingsboard" %}
{% include templates/install/gcp/provision-postgresql.md %}

### 步骤 5.2 Cassandra（可选）

{% include templates/install/gcp/configure-cassandra.md %}

## 步骤 6. 配置许可证密钥

{% include templates/install/k8s-license-secret.md %}

## 步骤 7. 安装

{% include templates/install/gcp/install.md %}

## 步骤 8. 启动

{% include templates/install/gcp/start-msa.md %}

## 步骤 9. 配置负载均衡器

### 9.1 配置 HTTP(S) 负载均衡器

{% include templates/install/gcp/configure-http.md %}

### 9.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-mqtt-transport.yml" %}
{% include templates/install/gcp/configure-mqtt.md %}

### 9.3. 配置 CoAP 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-coap-transport.yml" %}
{% include templates/install/gcp/configure-coap.md %}

### 9.4. 配置 LwM2M 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-lwm2m-transport.yml" %}
{% include templates/install/gcp/configure-lwm2m.md %}

### 9.5. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 10. 配置 Trendz（可选）

### 10.1. 从 Docker Hub 拉取 Trendz 镜像

{% include templates/install/trendz/pull_trendz.md %}

### 10.2. 在现有 Google Cloud SQL (PostgreSQL) 实例中创建 Trendz 数据库

{% include templates/install/trendz/gcp/k8s-trendz-db-creating.md %}

### 10.3. 启动 Trendz

{% include templates/install/trendz/k8s-trendz-starting.md %}

## 步骤 11. 使用

{% include templates/install/gcp/using.md %}

## 升级

### 升级到新版 ThingsBoard

{% include templates/install/gcp/upgrading-msa.md %}

### 升级到新版 Trendz（可选）

{% include templates/install/trendz/k8s-trendz-upgrading.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}

