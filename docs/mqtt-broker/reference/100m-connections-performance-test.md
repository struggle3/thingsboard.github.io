---
layout: docwithnav-mqtt-broker
title: TBMQ 集群支持 1 亿 MQTT 连接
description: TBMQ 集群模式下 1 亿 MQTT 连接的性能测试

broker-aws-monitoring:
    0:
        image: /images/mqtt-broker/reference/aws/aws-broker.png
        title: 'AWS EC2 TBMQ 监控'
    1:
        image: /images/mqtt-broker/reference/aws/aws-kafka.png
        title: 'AWS EC2 Kafka 监控'
    2:
        image: /images/mqtt-broker/reference/aws/aws-kafka-volume.png
        title: 'AWS EBS Kafka 监控'
    3:
        image: /images/mqtt-broker/reference/aws/aws-rds-stats.png
        title: 'AWS RDS 监控'

broker-jmx-monitoring:
    0:
        image: /images/mqtt-broker/reference/jmx/broker-jmx.png
        title: 'TBMQ JMX'

broker-topics-monitoring:
    0:
        image: /images/mqtt-broker/reference/topics/mqtt-pub-topic.png
        title: '发布消息topic - 已接收全部 11,400M 条消息'
    1:
        image: /images/mqtt-broker/reference/topics/mqtt-app-topic-1.png
        title: '应用topic示例 1 - 已接收全部 22.8M 条消息'
    2:
        image: /images/mqtt-broker/reference/topics/mqtt-app-topic-2.png
        title: '应用topic示例 2 - 已接收全部 22.8M 条消息'

broker-grafana-monitoring:
  0:
    image: /images/mqtt-broker/reference/grafana/consumer-lag.png
    title: '消费者延迟监控'
---

{% include docs/mqtt-broker/reference/100m-connections-performance-test.md %}
