* TOC
{:toc}

本指南将帮助你在 Azure Kubernetes Service (AKS) 上使用官方 Helm [chart](https://artifacthub.io/packages/helm/tbmq-helm-chart/tbmq-cluster) 部署 TBMQ 集群。

## 前置要求

{% include templates/mqtt-broker/install/helm/azure/prerequisites.md %}

## 配置 Kubernetes 环境

{% include templates/mqtt-broker/install/helm/azure/configure-deployment.md %}

## 添加 TBMQ 集群 Helm 仓库

{% include templates/mqtt-broker/install/helm/common/add-helm-repo.md %}

## 修改默认 chart 值

{% include templates/mqtt-broker/install/helm/common/get-default-chart-values.md %}

### External PostgreSQL

{% include templates/mqtt-broker/install/helm/common/external-postgres.md %}

若在 Azure AKS 上部署并计划使用 Azure Database for PostgreSQL，请按此[指南](/docs/{{docsPrefix}}mqtt-broker/install/cluster/azure-cluster-setup/#step-5-provision-postgresql-db)配置并创建 PostgreSQL 实例。

### 负载均衡器配置

{% include templates/mqtt-broker/install/helm/azure/modify-load-balancer.md %}

## 创建命名空间

{% include templates/mqtt-broker/install/helm/common/create-namespace.md %}

## 安装 TBMQ Helm chart

{% include templates/mqtt-broker/install/helm/common/install-chart.md %}

## 验证 HTTP 访问

{% include templates/mqtt-broker/install/helm/azure/validate-http.md %}

## 验证 MQTT 访问

{% include templates/mqtt-broker/install/helm/azure/validate-mqtt.md %}

## 故障排除

{% include templates/mqtt-broker/install/helm/common/helm-setup-troubleshooting.md %}

## 升级

{% include templates/mqtt-broker/install/helm/common/upgrading.md %}

## 卸载 TBMQ Helm chart

{% include templates/mqtt-broker/install/helm/common/uninstall-chart.md %}

## 删除 Kubernetes 集群

{% include templates/mqtt-broker/install/helm/azure/delete-cluster.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
