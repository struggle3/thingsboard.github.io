---
layout: docwithnav-pe-mqtt-broker
title: 单节点 TBMQ 实现 300 万条/秒吞吐量
description: TBMQ 单节点 300 万条/秒吞吐量性能测试

tbmq-3m-single-node-test-aws-instances:
  0:
    image: /images/mqtt-broker/reference/single-node-test/aws-instances.png
    title: 'AWS EC2 instances deployed'

tbmq-3m-single-node-test-monitoring:
  0:
    image: /images/mqtt-broker/reference/single-node-test/tbmq-aws.png
    title: 'AWS EC2 TBMQ monitoring'
  1:
    image: /images/mqtt-broker/reference/single-node-test/tbmq-jmx.png
    title: 'JMX TBMQ monitoring'
  2:
    image: /images/mqtt-broker/reference/single-node-test/tbmq-monitoring.png
    title: 'TBMQ graphs monitoring'

---

{% assign docsPrefix = "pe/" %}
{% include docs/mqtt-broker/reference/3m-throughput-single-node-performance-test.md %}
