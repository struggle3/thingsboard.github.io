### 配置 AWS 工具

```bash
aws configure
```
{: .copy-code}

### 配置概述

要部署 EKS 集群，建议使用预定义的 EKS 集群配置文件。
请使用以下命令下载：

```bash
curl -o cluster.yml https://raw.githubusercontent.com/thingsboard/tbmq/{{ site.release.broker_branch }}/k8s/helm/aws/cluster.yml
```
{: .copy-code}

可根据需要修改以下字段：
- `region` - 集群所在的 AWS 区域（默认 `us-east-1`）
- `availabilityZones` - 区域可用区的具体 ID（默认 `[ us-east-1a,us-east-1b,us-east-1c ]`）
- `instanceType` - 节点组实例类型。可按工作负载（如 TBMQ、Redis、Kafka）分别调整。
- `desiredCapacity` - 每个节点组的节点数。默认值适用于测试。
- `volumeType` - EC2 节点的 EBS 卷类型。默认为 `gp3`。

请参阅 [Amazon EC2 Instance types](https://aws.amazon.com/ec2/instance-types/)
为生产工作负载选择合适的实例类型。

### PostgreSQL 相关说明（可选节点组）

TBMQ Helm chart 支持外部 PostgreSQL，因此可能不需要此节点组：

```yaml
  - name: tbmq-postgresql
    instanceType: c7a.large
    desiredCapacity: 1
    maxSize: 1
    minSize: 0
    labels: { role: postgresql }
    volumeType: gp3
    volumeSize: 20
```

以下情况可安全移除此部分：

 - 使用 Amazon RDS 或现有 PostgreSQL 服务。
 - 希望将数据库置于 EKS 集群外部。

### OIDC 与 AWS Load Balancer Controller 的 IAM 设置

在 `cluster.yml` 中包含以下块，将自动启用服务账户的 IAM 角色并为 AWS Load Balancer Controller 创建服务账户：

```yaml
iam:
  withOIDC: true
  serviceAccounts:
    - metadata:
        name: aws-load-balancer-controller
        namespace: kube-system
      wellKnownPolicies:
        awsLoadBalancerController: true
```

此配置：
 - 启用 [OIDC](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html) 集成（服务账户 IAM 角色所需）。
 - 自动创建具有 [AWS Load Balancer Controller](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html) 适当 IAM 策略的服务账户。

使用 `eksctl` 时，这是最简单、最集成的方式。

若不愿在 `cluster.yml` 中管理 IAM，或组织要求手动创建 IAM 策略，可在集群创建后手动设置。

请遵循以下 AWS 官方指南：

- [为集群创建 IAM OIDC 提供程序](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)
- [使用 AWS Load Balancer Controller 路由互联网流量](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)

### 插件说明

`cluster.yml` 中的 `addons` 部分会自动安装并配置扩展 EKS 集群基础功能的必要组件。

 - **aws-ebs-csi-driver** - 通过 [EBS CSI driver](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html) 启用 Amazon EBS 卷动态配置。
   Redis 和 Kafka 等 TBMQ 组件需要持久化存储。此驱动允许 Kubernetes 在创建 PersistentVolumeClaim 时按需配置 `gp3` 卷。
 - **aws-efs-csi-driver** - 通过 [EFS CSI driver](https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html) 使工作负载可使用 Amazon EFS（Elastic File System）作为持久卷。
   TBMQ 不需要 EFS，但若需多个 pods 共享同一卷（如共享日志、配置文件或支持水平扩展的有状态工作负载），则很有用。
 - **vpc-cni** - 安装 [Amazon VPC CNI 插件](https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html)，使 Kubernetes pods 具备原生 VPC 网络能力。
   为每个 pod 从 VPC 子网分配独立 IP 地址。对 pod 间及 pod 对外通信至关重要。
 - **coredns** - 通过 [CoreDNS](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/) 为 Kubernetes 服务提供内部 DNS 解析。
 - **kube-proxy** - 通过 [kube-proxy](https://kubernetes.io/docs/concepts/services-networking/service/#kube-proxy) 管理各节点上的网络规则以处理服务路由。

### 创建 EKS 集群

```bash
eksctl create cluster -f cluster.yml
```
{: .copy-code}

### 创建 GP3 存储类并将其设为默认

{% include templates/mqtt-broker/install/aws/gp3-sc.md %}

### 附加策略

若使用提供的 `cluster.yml` 创建了 EKS 集群，则以下内容已自动配置：
 - 已启用 OIDC 提供程序（withOIDC: true）
 - 已在 kube-system 命名空间中创建服务账户 aws-load-balancer-controller。
 - 该账户已标注 IAM 访问权限并与 AWS 托管已知策略关联。

但您必须手动将 AWSLoadBalancerControllerIAMPolicy（或自定义策略）附加到 eksctl 创建的 IAM 角色。

 - 查找 `eksctl` 创建的角色：

```bash
aws iam list-roles \
  --query "Roles[?contains(RoleName, 'eksctl-tbmq')].RoleName" \
  --output text
```
{: .copy-code}

输出应类似：

```text
eksctl-tbmq-addon-iamserviceaccount-kube-syst-Role1-J9l4M87BqmNu
```

- 附加策略：

将 `YOUR_AWS_ACCOUNT_ID` 和 `ROLE_NAME` 替换为实际 AWS 账户 ID 和上一步找到的 IAM 角色名称：

```bash
aws iam attach-role-policy \
--policy-arn arn:aws:iam::YOUR_AWS_ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy \
--role-name ROLE_NAME
```
{: .copy-code}

可使用以下命令验证附加结果：

```bash
aws iam list-attached-role-policies --role-name ROLE_NAME
```
{: .copy-code}

输出应类似：

```text
ATTACHEDPOLICIES        arn:aws:iam::YOUR_AWS_ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy     AWSLoadBalancerControllerIAMPolicy
```

### 创建 AWS Load Balancer Controller

要支持通过 Kubernetes 注解配置 Network Load Balancer (NLB) 和 Application Load Balancer (ALB)，
需在 EKS 集群中部署 AWS Load Balancer Controller。

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```
{: .copy-code}

然后，将 controller 安装到 `kube-system` 命名空间并关联到您的集群：

```bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
--namespace kube-system \
--set clusterName=tbmq \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller
```
{: .copy-code}

验证 controller 是否已安装：

```bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```
{: .copy-code}

示例输出如下。

```text
NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
aws-load-balancer-controller   2/2     2            2           84s
```
