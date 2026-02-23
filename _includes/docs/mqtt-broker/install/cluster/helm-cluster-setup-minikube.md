* TOC
{:toc}

本指南将帮助你在自托管 Kubernetes 环境下使用官方 Helm [chart](https://artifacthub.io/packages/helm/tbmq-helm-chart/tbmq-cluster) 部署 TBMQ 集群，以 Minikube 作为参考环境。
若在无云负载均衡器集成的自管集群中部署 TBMQ，Minikube 便于端到端测试。

## 前置要求

{% include templates/mqtt-broker/install/helm/minikube/prerequisites.md %}

## 配置 Kubernetes 环境

{% include templates/mqtt-broker/install/helm/minikube/configure-deployment.md %}

## 添加 TBMQ 集群 Helm 仓库

{% include templates/mqtt-broker/install/helm/common/add-helm-repo.md %}

## 修改默认 chart 值

{% include templates/mqtt-broker/install/helm/common/get-default-chart-values.md %}

### External PostgreSQL

{% include templates/mqtt-broker/install/helm/common/external-postgres.md %}

### 负载均衡器配置

{% include templates/mqtt-broker/install/helm/minikube/modify-load-balancer.md %}

## 创建命名空间

{% include templates/mqtt-broker/install/helm/common/create-namespace.md %}

## 安装 TBMQ Helm chart

{% include templates/mqtt-broker/install/helm/common/install-chart.md %}

## 验证 HTTP 访问

{% include templates/mqtt-broker/install/helm/minikube/validate-http.md %}

## 验证 MQTT 访问

{% include templates/mqtt-broker/install/helm/minikube/validate-mqtt.md %}

## 故障排除

{% include templates/mqtt-broker/install/helm/common/helm-setup-troubleshooting.md %}

## 升级

{% include templates/mqtt-broker/install/helm/common/upgrading.md %}

## 卸载 TBMQ Helm chart

{% include templates/mqtt-broker/install/helm/common/uninstall-chart.md %}

## 删除 Kubernetes 集群

{% include templates/mqtt-broker/install/helm/minikube/delete-cluster.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
