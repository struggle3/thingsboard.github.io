---
layout: docwithnav-mqtt-broker
title: "使用持久化 MQTT 客户端实现每秒 100 万条 P2P 消息扩展"
description: 每秒 100 万条消息吞吐量，利用持久化 DEVICE 客户端作为订阅者实现点对点消息传输

tbmq-p2p-test-aws-infrastructure:
  0:
    image: /images/mqtt-broker/reference/p2p-test/aws-instances.png
    title: '已部署的 AWS EC2 实例'
  1:
    image: /images/mqtt-broker/reference/p2p-test/eks-pods.png
    title: '运行中的 AWS EKS 集群 Pod'

tbmq-p2p-test-monitoring:
  0:
    image: /images/mqtt-broker/reference/p2p-test/tbmq-aws.png
    title: 'AWS EC2 TBMQ 监控'
  1:
    image: /images/mqtt-broker/reference/p2p-test/tbmq-visual-vm-jmx.png
    title: 'Visual VM JMX TBMQ 监控'
  2:
    image: /images/mqtt-broker/reference/p2p-test/redis-monitoring.png
    title: 'Redis Insight 监控：每秒处理约 500 万条命令、管理约 250 万密钥'
  3:
    image: /images/mqtt-broker/reference/p2p-test/tbmq-total-connected-clients.png
    title: 'TBMQ 100 万已连接客户端'
  4:
    image: /images/mqtt-broker/reference/p2p-test/tbmq-total-subscriptions.png
    title: 'TBMQ 50 万订阅 QoS 1'  

---

{% include docs/mqtt-broker/reference/1m-throughput-p2p-performance-test.md %}