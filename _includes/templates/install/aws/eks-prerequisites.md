### 安装和配置工具

要在 EKS 集群上部署 ThingsBoard，您需要安装 [`kubectl`](https://kubernetes.io/docs/tasks/tools/)、
 [`eksctl`](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html) 和
 [`awscli`](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) 工具。

安装后需要配置 Access Key、Secret Key 和默认区域。
请按照[此](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)指南获取 Access Key 和 Secret Key。
默认区域应为计划部署集群的区域 ID。

```
aws configure
```
{: .copy-code}
