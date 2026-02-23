在 `cluster.yml` 文件中可找到推荐的集群配置。
以下字段可根据需要修改：
- `region` - 集群所在的 AWS 区域（默认 `us-east-1`）
- `availabilityZones` - 该区域可用区的具体 ID（默认 `[us-east-1a,us-east-1b,us-east-1c]`）
- `instanceType` - 运行 TB 节点的实例类型（默认 `m5.xlarge`）

**注意**：若不修改 `instanceType` 和 `desiredCapacity`，EKS 将部署 {{eksNote}}。

{% capture aws-eks-vpc %}

以下命令将为 ThingsBoard 集群创建新的 VPC。本指南假设您将创建新 VPC。
使用现有 VPC 和子网也可以。
有关为 `eksctl` 配置 VPC 的更多信息请参阅 [此处](https://eksctl.io/usage/vpc-networking/)。

{% endcapture %}
{% include templates/info-banner.md content=aws-eks-vpc %}

创建 AWS 集群的命令：

```
eksctl create cluster -f cluster.yml
```
{: .copy-code}
