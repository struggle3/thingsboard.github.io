* TOC
{:toc}

本指南将帮助你在 Google Cloud Platform (GCP) 的 Google Kubernetes Engine (GKE) 上使用官方 Helm [chart](https://artifacthub.io/packages/helm/tbmq-helm-chart/tbmq-cluster) 部署 TBMQ 集群。

## 前置要求

{% include templates/mqtt-broker/install/helm/gcp/prerequisites.md %}

## 配置 Kubernetes 环境

{% include templates/mqtt-broker/install/helm/gcp/configure-deployment.md %}

## 添加 TBMQ 集群 Helm 仓库

{% include templates/mqtt-broker/install/helm/common/add-helm-repo.md %}

## 修改默认 chart 值

{% include templates/mqtt-broker/install/helm/common/get-default-chart-values.md %}

### External PostgreSQL

{% include templates/mqtt-broker/install/helm/common/external-postgres.md %}

若在 GCP GKE 上部署并计划使用 Google Cloud SQL (PostgreSQL) 实例，请先[启用所需 GCP 服务](/docs/{{docsPrefix}}mqtt-broker/install/cluster/gcp-cluster-setup/#enable-gcp-services)，再按此[说明](/docs/{{docsPrefix}}mqtt-broker/install/cluster/gcp-cluster-setup/#step-5-provision-google-cloud-sql-postgresql-instance)配置并创建 PostgreSQL 实例。

### 负载均衡器配置

{% include templates/mqtt-broker/install/helm/gcp/modify-load-balancer.md %}

## 创建命名空间

{% include templates/mqtt-broker/install/helm/common/create-namespace.md %}

## 安装 TBMQ Helm chart

{% include templates/mqtt-broker/install/helm/common/install-chart.md %}

## 验证 HTTP 访问

{% include templates/mqtt-broker/install/helm/gcp/validate-http.md %}

## 验证 MQTT 访问

{% include templates/mqtt-broker/install/helm/gcp/validate-mqtt.md %}

## 故障排除

{% include templates/mqtt-broker/install/helm/common/helm-setup-troubleshooting.md %}

## 升级

{% include templates/mqtt-broker/install/helm/common/upgrading.md %}

## 卸载 TBMQ Helm chart

{% include templates/mqtt-broker/install/helm/common/uninstall-chart.md %}

## 删除 Kubernetes 集群

{% include templates/mqtt-broker/install/helm/gcp/delete-cluster.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
