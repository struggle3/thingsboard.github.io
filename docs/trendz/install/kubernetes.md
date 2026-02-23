---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 在 Kubernetes 上安装 ThingsBoard Trendz 分析
description: 在 Kubernetes 上安装 ThingsBoard Trendz 分析

trendz-settings:
  0:
    image: /images/trendz/install/sync/trendz-settings-1.png
    title: "以 <b>系统管理员</b> 身份登录 <b>ThingsBoard</b>。"
  1:
    image: /images/trendz/install/sync/trendz-settings-2.png
    title: "打开 <b>Trendz 设置</b> 页面。"
  2:
    image: /images/trendz/install/sync/trendz-settings-3.png
    title: "如果看到 <b>\"同步成功完成\"</b> 消息，则同步已自动完成，无需进一步操作。"
trendz-sync:
  0:
    image: /images/trendz/install/sync/trendz-sync-1.png
    title: "如果看到错误消息，请按以下步骤操作。"
  1:
    image: /images/trendz/install/sync/trendz-sync-2.png
    title: "输入正确的 <b>Trendz 内部 URL</b> 和 <b>ThingsBoard 内部 URL</b>。"
  2:
    image: /images/trendz/install/sync/trendz-sync-3.png
    title: "点击 <b>保存配置</b>。"
  3:
    image: /images/trendz/install/sync/trendz-sync-4.png
    title: "点击 <b>重试发现</b>。"
  4:
    image: /images/trendz/install/sync/trendz-sync-5.png
    title: "当出现 <b>\"同步成功完成\"</b> 消息时，同步即告完成。"

---
* TOC
{:toc}

本指南介绍如何使用 Kubernetes 和 Minikube 搭建 Trendz 分析集群。

## 前置条件

{% include templates/trendz/install/thingsboard-requirements.md %}

您需要拥有 Kubernetes 集群，且 `kubectl` 命令行工具必须配置为可与集群通信。
若尚未安装 Minikube，请按[此说明](https://kubernetes.io/docs/setup/learning-environment/minikube/)操作。

通过指定用于 Trendz 实例的节点并为该节点添加自定义标签来配置集群。利用亲和性设置，指示 Kubernetes 在指定节点上部署 Trendz 实例。
确保节点满足特定 CPU 和内存要求，典型用量约为 4 CPU 和 8GB 内存。您可设置自己的限制，但我们建议遵循或超过前述推荐规格。

## 安装步骤

### 步骤 1. 克隆 Trendz Kubernetes 脚本

```bash
git clone https://github.com/thingsboard/trendz-k8s.git --depth 1
cd trendz-k8s
```
{: .copy-code}

### 步骤 2. 配置 Trendz 数据库

搭建外部 PostgreSQL 数据库实例，并创建名为 "trendz" 的空数据库。此实例可托管在 RDS（AWS）等服务上或作为您的有状态部署。
确保您拥有以下信息：

- URL（示例：jdbc:postgresql://trendz-db-service:5432/trendz）
- 用户名（示例：postgres）
- 密码（示例：postgres）

编辑 trendz-secret.yml 文件配置 Trendz 数据库：

```bash
nano trendz-secret.yml
```
{: .copy-code}

```
  SPRING_DATASOURCE_URL: jdbc:postgresql://trendz-db-service:5432/trendz
  SPRING_DATASOURCE_USERNAME: postgres
  SPRING_DATASOURCE_PASSWORD: postgres

```

### 步骤 3. 运行

```bash
kubectl apply -f trendz-namespace.yml
kubectl apply -f trendz-app-config.yml
kubectl apply -f trendz-app-db-config.yml
kubectl apply -f trendz-app-pvc.yml
kubectl apply -f trendz-app-deployment.yml
kubectl apply -f trendz-python-executor-config.yml
kubectl apply -f trendz-python-executor-deployment.yml

```
{: .copy-code}

### 步骤 4. 检查日志

检查日志并确认实例已成功启动。
应出现以下行：

```bash
kubectl logs -f [trendz-pod-name]

Started TrendzApplication in 5.654 seconds (JVM running for 6.229)
```

其中：

* `trendz-pod-name` - 从运行中的 trendz pod 列表获取的 trendz pod 名称。

### 步骤 5. 设置负载均衡器

最后一步是设置负载均衡器，将请求路由到 Trendz 实例。使用 `trendz-ingress.yml` 文件中的参考更新您当前的负载均衡器配置。

**请勿直接应用此文件，仅供参考。**
不同环境对此配置有不同要求，您需要根据环境调整这些设置。

### 步骤 6. 将 ThingsBoard 与 Trendz 同步

{% include templates/trendz/install/sync-with-tb.md %}

## 认证

{% include templates/trendz/install/authentication.md %}

## 下一步

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}
