TBMQ v2.1.0 引入多项改进，包括新的 Integration Executor 微服务及第三方服务版本升级。

#### 添加 Integration Executor 微服务

本版本通过新的 [Integration Executor](/docs/{{docsPrefix}}mqtt-broker/integrations/) 微服务支持外部集成。

要获取包括 Integration Executor 在内的最新配置文件，请从release分支拉取更新。
按照 [运行升级说明](#run-upgrade) 中的步骤操作，直至执行升级脚本前（暂不执行 **.sh** 命令）。

`cluster.yml` 文件已更新，新增专门用于 Integration Executor pods 的托管节点组。

```yaml
  - name: tbmq-ie
    instanceType: m7a.large
    desiredCapacity: 2
    maxSize: 2
    minSize: 1
    labels: { role: tbmq-ie }
    ssh:
      allow: true
      publicKeyName: 'dlandiak' # 注意：此处请使用您自己的公钥名称
```

要创建该节点组，请执行以下命令：

```shell
eksctl create nodegroup --config-file=cluster.yml
```
{: .copy-code}

您也可以选择不为 Integration Executor 创建专用实例。
若如此，可跳过此步骤，但需相应更新 `tbmq-ie.yml` 文件中的 **nodeSelector** 部分。

```yaml
  nodeSelector:
    role: tbmq-ie
```

将 role 从 **"tbmq-ie"** 改为 **"tbmq"**，可将 Integration Executor pods 部署在与 TBMQ pods 相同的 AWS EC2 实例上。

#### 更新第三方服务

{% include templates/mqtt-broker/upgrade/upgrade-third-parties-for-2.1.0-release-aws-cluster.md %}
