### 安装并配置工具

要在 EKS 集群上部署 TBMQ，需安装 [kubectl](https://kubernetes.io/docs/tasks/tools/)、
 [eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html) 和
 [awscli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) 工具。

此外，需配置 Access Key、Secret Key 和默认区域。
获取 Access Key 和 Secret Key 请参阅 [此指南](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)。
默认区域应为要部署集群的目标区域的 ID。

```
aws configure
```
{: .copy-code}
