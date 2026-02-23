---
layout: docwithnav-edge
title: 从云端向Edge配置客户
description: 从云端向Edge配置客户

---

![image](/images/coming-soon.jpg)

### 用户访问管理

ThingsBoard Edge 用户访问管理取决于云版本。
 
#### ThingsBoard CE 用户访问管理

##### 租户管理员用户
ThingsBoard Edge 连接至 ThingsBoard CE 云端后，每位租户管理员用户将同步至Edge，任一用户均可登录 ThingsBoard Edge UI。

租户管理员用户可在Edge上创建或删除设备。 

租户管理员对Edge上可用的所有其他实体具有**只读**访问权限。   

##### 客户用户
若云端已将**Edge**实体分配给客户，则每位客户用户实体将同步至Edge，任一用户均可登录 ThingsBoard Edge UI。

客户用户可查看其在云端有权限访问的Edge设备。 

客户用户对已分配至Edge且其在云端有权限访问的所有其他实体具有**只读**访问权限。   

### 下一步

{% assign currentGuide = "ProvisionCustomerFromCloudToEdge" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}