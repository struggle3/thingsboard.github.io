---
layout: docwithnav
assignees:
- ashvayka
title: 使用 GCP 基础设施的单体设置
description: 在 GKE 中的 ThingsBoard IoT 平台单体设置

---

* TOC
{:toc}

本指南将帮助您在 GKE 中以单体模式搭建 ThingsBoard。

## 前置条件

{% include templates/install/gcp/gke-prerequisites.md %}

## 步骤 1. 克隆 ThingsBoard CE K8S 脚本仓库

克隆仓库并将工作目录切换到 GCP 脚本。

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-сe-k8s.git
cd thingsboard-сe-k8s/gcp/monolith
```
{: .copy-code}

## 步骤 2. 定义环境变量

{% assign tbClusterName = "tb-ce" %}
{% include templates/install/gcp/env-variables-monolith.md %}

## 步骤 3. 配置并创建 GKE 集群

{% include templates/install/gcp/zonal-gke-cluster.md %}

## 步骤 4. 更新 kubectl 的 context

{% include templates/install/gcp/update-kubectl-zone.md %}

## 步骤 5. 配置数据库

### 步骤 5.1 Google Cloud SQL (PostgreSQL) 实例

{% assign tbDbName = "thingsboard" %}
{% include templates/install/gcp/provision-postgresql.md %}

### 步骤 5.2 Cassandra（可选）

{% include templates/install/gcp/configure-cassandra.md %}

## 步骤 6. 安装

{% include templates/install/gcp/install.md %}

## 步骤 7. 启动

{% include templates/install/gcp/start-monolith.md %}

## 步骤 8. 配置负载均衡器

### 8.1 配置 HTTP(S) 负载均衡器

{% include templates/install/gcp/configure-http.md %}

#### 透明负载均衡器

此类型的负载均衡器需要您自行配置并维护有效的 SSL 证书。
按照通用 [HTTP over SSL](/docs/{{docsPrefix}}user-guide/ssl/http-over-ssl/#ssl-configuration-using-pem-certificates-file) 指南
在 *tb-node.yml* 文件中配置所需环境变量。

然后，设置 TCP 负载均衡器将 443 端口的流量转发到相应服务的 8080 端口。
此版本设置不支持从 http 80 端口到 https 443 端口的自动重定向。

```bash
 kubectl apply -f receipts/transparent-http-load-balancer.yml
```
{: .copy-code}
 
### 8.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "tb-node.yml" %}
{% include templates/install/gcp/configure-mqtt.md %}

### 8.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/gcp/configure-udp.md %}

### 8.4. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 9. 使用

{% include templates/install/gcp/using.md %}

## 升级

{% include templates/install/gcp/upgrading-monolith.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
