要在 EKS 集群上使用 Helm 部署 TBMQ 集群，需在本地机器上安装以下工具：

- [helm](https://helm.sh/docs/intro/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)
- [awscli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

此外，需配置 Access Key、Secret Key 和默认区域。
获取 Access Key 和 Secret Key 请参阅 [此指南](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)。
默认区域应为要部署集群的目标区域的 ID。
