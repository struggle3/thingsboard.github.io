---
layout: docwithnav-mqtt-broker
title: 在 AWS 上使用 Kubernetes 部署 TBMQ 集群
description: 在 AWS EKS 中使用 Kubernetes 配置 TBMQ 微服务

tbmq-rds-set-up:
  0:
    image: /images/mqtt-broker/install-old/aws-rds-vpc.png
    title: 'AWS RDS 连接 - 选择与集群同名的 VPC'
  1:
    image: /images/mqtt-broker/install-old/aws-rds-vpc-sg.png
    title: 'AWS RDS 安全组 - 选择 "eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*" 安全组'
  2:
    image: /images/mqtt-broker/install-old/aws-rds-default-database.png
    title: 'AWS RDS 附加配置 - 在初始数据库名称处填写 "thingsboard_mqtt_broker"'

tbmq-msk-set-up:
  0:
    image: /images/mqtt-broker/install-old/aws-msk-creation.png
    title: 'AWS MSK - 创建集群'

tbmq-msk-configuration:
  0:
    image: /images/mqtt-broker/install-old/aws-msk-vpc.png
    title: 'AWS MSK - 选择 TBMQ 集群的 VPC'
  1:
    image: /images/mqtt-broker/install-old/aws-msk-vpc-sg.png
    title: 'AWS MSK - 选择 "eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*" 安全组'
  2:
    image: /images/mqtt-broker/install-old/aws-msk-security.png
    title: 'AWS MSK - 启用客户端与 Broker 之间的明文通信'

tbmq-redis-set-up:
  0:
    image: /images/mqtt-broker/install-old/aws-redis-create.png
    title: 'AWS ElastiCache - 创建 Redis 集群'
  1:
    image: /images/mqtt-broker/install-old/aws-redis-cluster-settings.png
    title: 'AWS ElastiCache - 选择 7.x 引擎版本及合适的节点类型'
  2:
    image: /images/mqtt-broker/install-old/aws-redis-connectivity.png
    title: 'AWS ElastiCache - 选择 TBMQ 的 VPC 与私有子网'
  3:
    image: /images/mqtt-broker/install-old/aws-redis-advanced.png
    title: 'AWS ElastiCache - 选择 "eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*" 安全组'

tbmq-rds-link-configure:
  0:
    image: /images/mqtt-broker/install-old/aws-rds-endpoint.png
    title: 'AWS RDS 详情'

tbmq-msk-link-configure:
  0:
    image: /images/mqtt-broker/install-old/aws-msk-arn.png
    title: 'AWS MSK 详情'
    
tbmq-redis-link-configure:
  0:
    image: /images/mqtt-broker/install-old/aws-redis-result.png
    title: 'AWS ElastiCache 详情'

---

{% assign tbmqSuffix = "CE" %}
{% include docs/mqtt-broker/install/cluster/aws-cluster-setup-old.md %}
