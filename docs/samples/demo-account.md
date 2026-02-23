---
layout: docwithnav
assignees:
- ashvayka
title: Demo Account
description: ThingsBoard 默认演示账户

---

* TOC
{:toc}

ThingsBoard 安装包含单租户账户，用于 sample applications，并预置大量实体供演示使用。

## System Administrator
 
默认 system administrator 账户：

 - 登录名 - **sysadmin@thingsboard.org**。
 - 密码 - **sysadmin**。
 
## Demo Tenant

默认 tenant administrator 账户：

 - 登录名 - **tenant@thingsboard.org**。
 - 密码 - **tenant**。
 
Demo tenant customers：

 - Customer A 用户 -  **customer@thingsboard.org** 或 **customerA@thingsboard.org**。
 - Customer B 用户 -  **customerB@thingsboard.org**。
 - Customer C 用户 -  **customerC@thingsboard.org**。
 - 所有用户密码均为 **"customer"**。 
 
## Tenant devices

 - Test Device A1、A2、A3 - 属于 Customer A。Access token：A1_TEST_TOKEN、A2_TEST_TOKEN、A3_TEST_TOKEN。
 - Test Device B1 - 属于 Customer B。Access token：B1_TEST_TOKEN。
 - Test Device C1 - 属于 Customer C。Access token：C1_TEST_TOKEN。
 
 - DHT11 Demo Device - Access token：DHT11_DEMO_TOKEN
 - Raspberry Pi Demo Device - Access token：RASPBERRY_PI_DEMO_TOKEN
 
## Rule Chains
预置 Rule Chain 用于存储所有 incoming telemetry 和 attribute 更新。其他 incoming 请求仅作记录。
如需添加 Send Email、Create Alarms 等 Rule Node，请参阅相关文档：

- [Rule Engine Getting Started](/docs/user-guide/rule-engine-2-0/re-getting-started/)
- [Rule Engine Overview](/docs/user-guide/rule-engine-2-0/overview/)
- [Rule Engine Tutorials](/docs/user-guide/rule-engine-2-0/overview/#tutorials)
