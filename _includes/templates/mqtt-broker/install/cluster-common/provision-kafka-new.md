TBMQ 需要运行中的 Kafka 集群。可通过两种方式部署 Kafka：

* **部署自管理的 Apache Kafka 集群**
* **使用 Strimzi Operator 部署托管 Kafka 集群**

根据环境与运维需求选择合适方案。

### 选项 1. 部署 Apache Kafka 集群

* 以 **StatefulSet** 运行，3 个 pod 处于 **KRaft 双角色模式**（每个节点同时充当 controller 和 broker）。
* 适用于轻量、自管的 Kafka 部署。
{% if docsPrefix == null %}
* [完整部署指南见此处](https://github.com/thingsboard/tbmq/blob/{{site.release.broker_branch}}/k8s/{{deployment}}/kafka/README.md).
{% else %}
* [完整部署指南见此处](https://github.com/thingsboard/tbmq-pe-k8s/blob/{{site.release.broker_branch}}/{{deployment}}/kafka/README.md).
{% endif %}

**快速步骤：**

```bash
kubectl apply -f kafka/tbmq-kafka.yml
```
{: .copy-code}

更新 TBMQ 配置文件（`tbmq.yml` 和 `tbmq-ie.yml`），并取消注释标记为以下内容的段落：

```yaml
# Uncomment the following lines to connect to Apache Kafka
```

### 选项 2. 使用 Strimzi Operator 部署 Kafka 集群

* 使用 Kubernetes 的 **Strimzi Cluster Operator** 管理 Kafka。
* 便于升级、扩缩容和运维管理。
{% if docsPrefix == null %}
* [完整部署指南见此处](https://github.com/thingsboard/tbmq/blob/{{site.release.broker_branch}}/k8s/{{deployment}}/kafka/operator/README.md).
{% else %}
* [完整部署指南见此处](https://github.com/thingsboard/tbmq-pe-k8s/blob/{{site.release.broker_branch}}/{{deployment}}/kafka/operator/README.md).
{% endif %}

**快速步骤：**

安装 Strimzi operator：

```bash
helm install tbmq-kafka -f kafka/operator/values-strimzi-kafka-operator.yaml oci://quay.io/strimzi-helm/strimzi-kafka-operator --version 0.47.0
```
{: .copy-code}

部署 Kafka 集群：

```bash
kubectl apply -f kafka/operator/kafka-cluster.yaml
```
{: .copy-code}

更新 TBMQ 配置文件（`tbmq.yml` 和 `tbmq-ie.yml`），并取消注释标记为以下内容的段落：

```yaml
# Uncomment the following lines to connect to Strimzi
```
