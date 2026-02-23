---
layout: docwithnav-pe
assignees:
- ashvayka
title: ThingsBoard 专业版 Kubernetes 与 Minikube 集群设置指南
description: ThingsBoard 专业版 Kubernetes 与 Minikube 集群设置指南

---

{% assign docsPrefix = "pe/" %}

* TOC
{:toc}

本指南将帮助您使用 Kubernetes 和 Minikube 以集群模式设置 ThingsBoard。
为此，我们将使用 [Docker Hub](https://hub.docker.com/search?q=thingsboard&type=image&image_filter=store) 上提供的 Docker 容器镜像。

## 前置条件

ThingsBoard 微服务在 Kubernetes 集群上运行。您需要拥有 Kubernetes 集群，且 `kubectl` 命令行工具必须已配置为与集群通信。
若未安装 Minikube，请按照[此处说明](https://kubernetes.io/docs/setup/learning-environment/minikube/)操作。

### 启用 ingress 插件

Minikube 中 ingress 插件默认禁用，仅在集群 provider 中可用。
要启用 ingress，请执行以下命令：

```
minikube addons enable ingress
```
{: .copy-code}

### 从 Docker Hub 拉取 ThingsBoard PE 镜像

{% include templates/install/dockerhub/checkout.md %}

## 步骤 1. 查看架构页面

自 ThingsBoard v2.2 起，可使用新的微服务架构和 Docker 容器安装 ThingsBoard 集群。
详见 [**微服务**](/docs/reference/msa/) 架构页面。

## 步骤 2. 克隆 ThingsBoard PE Kubernetes 脚本

```bash
git clone -b release-{{ site.release.ce_full_ver }} https://github.com/thingsboard/thingsboard-pe-k8s.git --depth 1
cd thingsboard-pe-k8s/minikube
```
{: .copy-code}

## 步骤 3. 获取许可证密钥

我们假定您已选择订阅计划或决定购买永久许可证。
否则，请前往 [pricing](/pricing/) 页面选择适合的许可证选项并获取许可证。
详见 [如何获取按需付费订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

{% capture multiple_instances_license %}

本指南稍后将使用 PUT_YOUR_LICENSE_SECRET_HERE 引用您在本步骤获取的许可证密钥。

{% endcapture %}
{% include templates/warn-banner.md content=multiple_instances_license %}

## 步骤 4. 配置许可证密钥

```bash
nano tb-node.yml
```
{: .copy-code}

并填入许可证密钥参数：

```
# tb-node StatefulSet configuration

- name: TB_LICENSE_SECRET
  value: "PUT_YOUR_LICENSE_SECRET_HERE"
```

## 步骤 5. 查看架构页面

自 ThingsBoard v2.2 起，可使用新的微服务架构和 Docker 容器安装 ThingsBoard 集群。
详见 [**微服务**](/docs/reference/msa/) 架构页面。

## 步骤 6. 配置 Minikube

Minikube 中 ingress 插件默认禁用，仅在集群 provider 中可用。
要启用 ingress，请执行以下命令：

```
minikube addons enable ingress
```
{: .copy-code} 

## 步骤 7. 配置 ThingsBoard 数据库

执行初始安装前，可配置 ThingsBoard 使用的数据库类型。
要设置数据库类型，请将 `.env` 文件中 `DATABASE` 变量的值改为以下之一：

- `postgres` - 使用 PostgreSQL 数据库；
- `hybrid` - 实体数据库使用 PostgreSQL，时序数据使用 Cassandra；

**注意**：将根据数据库类型部署相应的 kubernetes 资源（详见 `postgres.yml`、`cassandra.yml`）。

## 步骤 8. 配置 Trendz（可选）

### 8.1. 从 Docker Hub 拉取 Trendz 镜像

{% include templates/install/trendz/pull_trendz.md %}

### 8.2. 在现有 RDS 实例中创建 Trendz 数据库

{% include templates/install/trendz/eks/k8s-trendz-db-creating.md %}

### 8.3. 启动 Trendz

{% include templates/install/trendz/k8s-trendz-starting.md %}

## 步骤 9. 运行

执行以下命令进行安装：

```
./k8s-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载额外演示数据。

执行以下命令部署第三方资源：

```
./k8s-deploy-thirdparty.sh
```
{: .copy-code}

首次以 `high-availability` `DEPLOYMENT_TYPE` 运行 ThingsBoard 或尚未配置 Redis 集群时，提示时输入 **'yes'**。

执行以下命令部署 ThingsBoard 资源：
 
```
./k8s-deploy-resources.sh
```
{: .copy-code}

所有资源成功启动后，可在浏览器中打开 `http://{your-cluster-ip}`（例如 `http://192.168.99.101`）。
可使用以下命令查看集群 IP：

```
minikube ip
```
{: .copy-code}

您应能看到 ThingsBoard 登录页面。

使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin

若使用演示数据安装数据库（使用 `--loadDemo` 参数），还可使用以下凭据：

- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

如有问题，可查看服务日志以排查错误。
例如，要查看 ThingsBoard 节点日志，请执行以下命令：

1) 获取运行的 tb-node pod 列表：

```
kubectl get pods -l app=tb-node
```
{: .copy-code}

2) 获取 tb-node pod 的日志：

```
kubectl logs -f [tb-node-pod-name]
```
{: .copy-code}

其中：

- `tb-node-pod-name` - 从运行的 tb-node pod 列表中获得的 pod 名称。

或使用 `kubectl get pods` 查看所有 pod 状态。
或使用 `kubectl get services` 查看所有服务状态。
或使用 `kubectl get deployments` 查看所有部署状态。
详见 [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 命令参考。

执行以下命令删除所有 ThingsBoard 微服务：

```
./k8s-delete-resources.sh
```
{: .copy-code}

执行以下命令删除所有第三方微服务：

```
./k8s-delete-thirdparty.sh
```
{: .copy-code}

执行以下命令删除所有资源（包括数据库）：

```
./k8s-delete-all.sh
```
{: .copy-code}

## 升级

### 升级到新版 ThingsBoard

若要升级，请从 `master` 分支拉取*最新*更改：
```
git pull origin master
```
{: .copy-code}

然后执行以下命令：

```bash
./k8s-delete-resources.sh
./k8s-upgrade-tb.sh
./k8s-deploy-resources.sh
```
{: .copy-code}

注意，需逐一升级版本（例如 4.0.0 -> 4.0.1 -> 4.1.0 等）。

{% capture from-version-note %}
<code style="color:black">"--fromVersion"</code> flag is required for earlier upgrade versions (prior to 3.9.1), for example:

`# upgrading to v3.9.0...`<br>
`./k8s-upgrade-tb.sh --fromVersion=3.8.1`

See [Upgrade Instructions](/docs/user-guide/install/{{docsPrefix}}upgrade-instructions) for valid <code style="color:black">"fromVersion"</code> values.
{% endcapture %}
{% include templates/info-banner.md content=from-version-note %}

### 升级到新版 Trendz（可选）

{% include templates/install/trendz/k8s-trendz-upgrading.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
