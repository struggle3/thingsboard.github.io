---
layout: docwithnav-mqtt-broker
title: 持久化设备客户端的 Redis 架构
description: 持久化设备客户端的 Redis 架构概览

redis-cluster-constraints:
 0:
  image: /images/mqtt-broker/architecture/details/redis-cluster-constraints.png
  title: 'Redis 集群中基于 key-slot 的分片（主节点与副本）'

redis-data-structures:
  0:
   image: /images/mqtt-broker/architecture/details/sorted-set.png
   title: '使用 Redis 有序集合维护每客户端消息顺序'
   
jedis-to-lettuce:
  0:
   image: /images/mqtt-broker/architecture/details/jedis-performance.png
   title: 'RedisInsight 显示每节点约 66k 命令/秒，与 TBMQ 的 40k 消息/秒一致，因 Lua 脚本每条消息会触发多次 Redis 操作。'
  1:
   image: /images/mqtt-broker/architecture/details/lettuce-performance.png
   title: '在 60k 消息/秒时，RedisInsight 显示每节点约 100k 命令/秒，与从 40k 消息/秒（约 66k 命令/秒每节点）的预期提升一致。' 

---

{% include docs/mqtt-broker/architecture-details/persistent-device-client.md %}
