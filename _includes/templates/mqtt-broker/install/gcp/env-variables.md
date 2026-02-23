定义您将在此指南后续各种命令中使用的环境变量。

假设您使用 Linux。执行以下命令：

```bash
export GCP_PROJECT=$(gcloud config get-value project)
export GCP_REGION=us-central1
export GCP_ZONE=us-central1
export GCP_ZONE1=us-central1-a
export GCP_ZONE2=us-central1-b
export GCP_ZONE3=us-central1-c
export GCP_NETWORK=default
export TB_CLUSTER_NAME={{tbClusterName}}
export TB_DATABASE_NAME={{tbDbClusterName}}
echo "You have selected project: $GCP_PROJECT, region: $GCP_REGION, gcp zones: $GCP_ZONE1,$GCP_ZONE2,$GCP_ZONE3, network: $GCP_NETWORK, cluster: $TB_CLUSTER_NAME, database: $TB_DATABASE_NAME"
```
{: .copy-code}

其中：

* 第一行使用 gcloud 命令获取您当前的 GCP 项目 ID。我们将在本指南后续内容中使用 **$GCP_PROJECT** 引用；
* *us-central1* 是可用的计算[区域](https://cloud.google.com/compute/docs/regions-zones#available)之一。我们将在本指南后续内容中使用 **$GCP_REGION** 引用；
* *default* 是默认 GCP 网络名称；我们将在本指南后续内容中使用 **$GCP_NETWORK** 引用；
* *{{tbClusterName}}* 是您的集群名称。您可以输入不同的名称。我们将在本指南后续内容中使用 **$TB_CLUSTER_NAME** 引用；
* *{{tbDbClusterName}}* 是您的数据库服务器名称。您可以输入不同的名称。我们将在本指南后续内容中使用 **$TB_DATABASE_NAME** 引用。
