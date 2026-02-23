#### 5.1 前提条件

启用服务网络以使 K8S 集群连接至 DB 实例：

```bash
gcloud services enable servicenetworking.googleapis.com --project=$GCP_PROJECT

gcloud compute addresses create google-managed-services-$GCP_NETWORK \
--global \
--purpose=VPC_PEERING \
--prefix-length=16 \
--network=projects/$GCP_PROJECT/global/networks/$GCP_NETWORK

gcloud services vpc-peerings connect \
--service=servicenetworking.googleapis.com \
--ranges=google-managed-services-$GCP_NETWORK \
--network=$GCP_NETWORK \
--project=$GCP_PROJECT
    
```
{: .copy-code}

#### 5.2 创建数据库服务器实例

创建数据库版本为 "**PostgreSQL 16**" 的 PostgreSQL 实例，建议如下：

* 使用与 K8S 集群 **GCP_REGION** 相同区域；
* 使用与 K8S 集群 **GCP_REGION** 相同的 VPC 网络；
* 使用私有 IP 连接实例并禁用公网 IP；
* 生产环境使用高可用 DB 实例，开发集群使用单可用区实例；
* 至少使用 2 vCPU 和 7.5 GB 内存，可满足大多数负载，可按需扩展；

执行以下命令：

```bash

gcloud beta sql instances create $TB_DATABASE_NAME \
--database-version=POSTGRES_16 \
--region=$GCP_REGION --availability-type=regional \
--no-assign-ip --network=projects/$GCP_PROJECT/global/networks/$GCP_NETWORK \
--cpu=2 --memory=7680MB
```
{: .copy-code}

也可参考 [此](https://cloud.google.com/sql/docs/postgres/create-instance) 指南配置数据库。

从命令输出中记录 IP 地址（**YOUR_DB_IP_ADDRESS**）。成功执行后的输出类似：

```text
Created [https://sqladmin.googleapis.com/sql/v1beta4/projects/YOUR_PROJECT_ID/instances/$TB_DATABASE_NAME].
NAME                        DATABASE_VERSION  LOCATION       TIER              PRIMARY_ADDRESS  PRIVATE_ADDRESS  STATUS
$TB_DATABASE_NAME           POSTGRES_16       us-central1-f  db-custom-2-7680  35.192.189.68    -                RUNNABLE
```

#### 5.3 设置数据库密码

为新建数据库服务器实例设置密码：

```bash
gcloud sql users set-password postgres \
--instance=$TB_DATABASE_NAME \
--password=secret
```
{: .copy-code}

其中：

* *instance* 为数据库服务器实例名称；
* *secret* 为密码。**应**使用不同密码。本指南后续以 **YOUR_DB_PASSWORD** 引用；

#### 5.4 创建数据库

在 postgres 数据库服务器实例中创建 "{{tbDbName}}" 数据库：

```bash
gcloud sql databases create {{tbDbName}} --instance=$TB_DATABASE_NAME
```
{: .copy-code}

其中 *{{tbDbName}}* 为数据库名称。可使用其他名称。本指南后续以 **YOUR_DB_NAME** 引用；