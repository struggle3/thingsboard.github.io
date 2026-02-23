定义本指南后续命令中将使用的环境变量。

假设您使用 Linux，请执行以下命令：

```bash
export GCP_PROJECT=$(gcloud config get-value project)
export GCP_REGION=us-central1
export GCP_ZONE=us-central1
export GCP_ZONE1=us-central1-a
export GCP_ZONE2=us-central1-b
export GCP_ZONE3=us-central1-c
export GCP_NETWORK=default
export TB_CLUSTER_NAME=tbmq-cluster
export TB_DATABASE_NAME=tbmq-db
echo "You have selected project: $GCP_PROJECT, region: $GCP_REGION, gcp zones: $GCP_ZONE1,$GCP_ZONE2,$GCP_ZONE3, network: $GCP_NETWORK, cluster: $TB_CLUSTER_NAME, database: $TB_DATABASE_NAME"
```
{: .copy-code}

参数说明：

* 第一行使用 gcloud 命令获取当前 GCP 项目 ID，本指南后续以 **$GCP_PROJECT** 引用；
* *us-central1* 为可用计算 [regions](https://cloud.google.com/compute/docs/regions-zones#available) 之一，本指南后续以 **$GCP_REGION** 引用；
* *default* 为默认 GCP 网络名称，本指南后续以 **$GCP_NETWORK** 引用；
* *tbmq-cluster* 为集群名称，可改为其他名称，本指南后续以 **$TB_CLUSTER_NAME** 引用；
