需在 Amazon RDS 上配置 PostgreSQL。ThingsBoard 将使用其作为主数据库存储设备、仪表盘、规则链和遥测数据。
可参考[此指南](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.PostgreSQL.html)，并注意以下要求：

* 妥善保管 postgresql 密码，本指南后续将用 **YOUR_RDS_PASSWORD** 指代；
* PostgreSQL 版本需为最新 16.x；
* 确保 PostgreSQL RDS 实例可从 ThingsBoard 集群访问；
  最简单的做法是在同一 VPC 部署 RDS 实例，并采用 'eksctl-thingsboard-cluster-ClusterSharedNodeSecurityGroup-*' 安全组。
  本指南默认采用同一 VPC；
* 初始数据库名需使用 **"thingsboard"**。若不指定数据库名，Amazon RDS 不会创建数据库；

建议：

* 使用「Production」模板以获得高可用，默认开启多项实用配置；
* 使用「Provisioned IOPS」提升性能；
* 为 RDS 实例创建自定义参数组，便于修改 DB 参数；
* 将 RDS 实例部署到私有子网，降低意外暴露到互联网的风险。

{% include images-gallery.html imageCollection="rdsSetup"%}

数据库切换为「Available」后，进入「Connectivity and Security」，复制 endpoint 值。

{% include images-gallery.html imageCollection="rdsEndpointUrl"%}

编辑 `tb-node-db-configmap.yml`，将 **YOUR_RDS_ENDPOINT_URL** 和 **YOUR_RDS_PASSWORD** 替换为实际值。

