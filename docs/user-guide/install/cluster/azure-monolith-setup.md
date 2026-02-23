---
layout: docwithnav
assignees:
- amykolaichuk
title: 使用 AKS 基础设施的单体设置
description: 在 Azure AKS 中的 ThingsBoard IoT 平台单体设置

---

* TOC
{:toc}

本指南将帮助您在 Azure AKS 中以单体模式搭建 ThingsBoard。

## 前置条件

{% include templates/install/azure/aks-prerequisites.md %}


## 步骤 1. 克隆 ThingsBoard CE K8S 脚本仓库

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-ce-k8s.git
cd thingsboard-ce-k8s/azure/monolith
```
{: .copy-code}

## 步骤 2. 定义环境变量

{% include templates/install/azure/aks-env.md %}

## 步骤 3. 配置并创建 AKS 集群

{% assign nodeCount = "1" %}
{% include templates/install/azure/aks-create-cluster.md %}

## 步骤 4. 更新 kubectl 的 context

{% include templates/install/azure/aks-kubectl-update-context.md %}

## 步骤 5. 配置数据库

### 5.1. 创建 Azure Database for PostgreSQL 服务器

{% include templates/install/azure/aks-create-db.md %}

### 5.2. Cassandra

{% include templates/install/azure/configure-cassandra.md %}

## 步骤 6. 安装

{% include templates/install/azure/aks-installation.md %}

## 步骤 7. 启动

执行以下命令部署资源：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后，您可调用 `kubectl get pods`。若一切正常，您应能看到 `tb-node-0` pod 处于 `READY` 状态。

## 步骤 8. 配置负载均衡器

### 8.1. 配置 HTTP(S) 负载均衡器
{% include templates/install/azure/aks-http-lb.md %}

### 8.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-mqtt-transport.yml" %}
{% include templates/install/azure/configure-mqtt.md %}

### 8.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/azure/configure-udp.md %}

### 8.4. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 9. 使用

{% include templates/install/azure/using.md %}

## 升级

{% include templates/install/azure/upgrading-msa.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
