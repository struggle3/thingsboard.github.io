定义您将在本指南后续各种命令中使用的环境变量。

假设您使用 Linux。执行以下命令：

```bash
export GCP_PROJECT=$(gcloud config get-value project)
export GCP_REGION=us-central1
export GCP_ZONE=us-central1-a
export GCP_NETWORK=default
export TB_CLUSTER_NAME={{tbClusterName}}
export TB_DATABASE_NAME=tb-db
echo "You have selected project: $GCP_PROJECT, region: $GCP_REGION, network: $GCP_NETWORK zone: $GCP_ZONE, cluster: $TB_CLUSTER_NAME and database: $TB_DATABASE_NAME"
```
{: .copy-code}

其中：

* 第一行使用 gcloud 命令获取您当前的 GCP 项目 ID。我们将在本指南后续使用 **GCP_PROJECT** 引用；
* *us-central1* 是可用计算[区域](https://cloud.google.com/compute/docs/regions-zones#available)之一。我们将在本指南后续使用 **GCP_REGION** 引用；
* *us-central1-a* 是可用计算[可用区](https://cloud.google.com/compute/docs/regions-zones#available)之一。应与所选区域匹配。我们将在本指南后续使用 **GCP_ZONE** 引用；
* *default* 是默认 GCP 网络名称；我们将在本指南后续使用 **GCP_NETWORK** 引用；
* *tb-ce* 是您的集群名称。您可输入其他名称。我们将在本指南后续使用 **$TB_CLUSTER_NAME** 引用；
* *tb-db* 是您的数据库服务器名称。您可输入其他名称。我们将在本指南后续使用 **TB_DATABASE_NAME** 引用；
