为确保基于 EKS 的 TBMQ 集群高可用及正确调度，
必须使用 Helm `values.yml` 中的 `nodeSelector` 字段将 TBMQ 组件分配到特定节点组。

您的 `cluster.yml` 已定义带基于角色标签的专用节点组。
例如，`tbmq-node` 托管节点组为：

```yaml
labels: { role: tbmq }
```

必须使用这些标签将各组件映射到相应节点组。

以下为显式分配各组件的示例：

- TBMQ Broker：

```yaml
tbmq:
  nodeSelector:
    role: tbmq
```
{: .copy-code}

- TBMQ Integration Executor：

```yaml
tbmq-ie:
  nodeSelector:
    role: tbmq-ie
```
{: .copy-code}

- Kafka Controller 节点：

```yaml
kafka:
  controller:
    nodeSelector:
      role: kafka
```
{: .copy-code}

- Redis 集群节点：

```yaml
redis-cluster:
  redis:
    nodeSelector:
      role: redis
```
{: .copy-code}

- PostgreSQL（若未使用外部数据库）：

```yaml
postgresql:
  primary:
    nodeSelector:
      role: postgresql

  backup:
    cronjob:
      nodeSelector:
        role: postgresql
```
{: .copy-code}
