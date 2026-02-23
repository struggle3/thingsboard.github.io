* TOC
{:toc}

## 实体概述

在 **ThingsBoard** 中，**实体**是表示平台内物理对象或概念的核心组件。您可[在此](/docs/{{peDocsPrefix}}user-guide/entities-and-relations/){: target="_blank"}查看 ThingsBoard 实体列表。

**ThingsBoard Edge** 支持与边缘计算相关的实体。

### 可用的 Edge 实体

* **Devices（设备）：** 物理物联网设备（_传感器、执行器、控制器_）。
* **Assets（资产）：** 用于分组和管理物联网生态系统的真实世界对象（_例如机器、建筑、工厂_）。
* **Customers（客户）：** 分配给特定设备/资产的组织或用户。
* **Users (for PE)（用户）：** 管理并与边缘资源交互的人员。
* **Entity Views（实体视图）：** 所选实体数据的预定义视图。
* **Alarms（告警）：** 异常或预定义条件的警报。
* **Dashboards（仪表板）：** 遥测及设备数据的可视化。
* **Rule Chains（规则链）：** 本地数据处理与自动化逻辑。

除 **Customers** 和 **Users** 外，大多数实体可在 **Edge** 上创建。这些实体可在 **Server** 上创建，然后 [分配](/docs/{{docsPrefix}}config/management/#entities-management){: target="_blank"} 给 **Edge 实例**。

**Devices** 和 **Assets** 实体分别具有 [Device Profiles](/docs/{{peDocsPrefix}}user-guide/device-profiles/){: target="_blank"} 和 [Asset Profiles](/docs/{{peDocsPrefix}}user-guide/asset-profiles/){: target="_blank"} 配置模板。

## 实体核心功能

### 属性
**Attributes（属性）**是与实体相关的结构化数据（如设备型号、位置、token）。
其存储在本地数据库中，可用于可视化、分析、逻辑配置及与其他服务集成。

若要全面了解 **ThingsBoard 属性**，请参阅 [Working with IoT Attributes](/docs/{{peDocsPrefix}}user-guide/attributes/){: target="_blank"} 文档。
您也可参阅 [Edge Attributes article](/docs/{{docsPrefix}}user-guide/edge-attributes/){: target="_blank"} 以了解 **Edge** 特有的属性。

### 遥测

**Telemetry（遥测）**指从物联网设备收集并由 **Rule Chain** 处理的 **时序数据**。

**Telemetry** 以 **键值对** 形式存储：
* **Key（键）：** 遥测字段（_如 temperature、humidity、voltage_）。
* **Value（值）：** 数值或字符串（_如 25.4°C、45%、"ON"_）。

示例：
```bash
{
  "temperature": 25.4,
  "humidity": 45,
  "status": "ON"
}
```
您可[在此](/{{peDocsPrefix}}docs/user-guide/telemetry/){: target="_blank"}了解更多关于遥测数据的使用。

默认情况下，**ThingsBoard Edge** 与 **ThingsBoard Cloud** 同步遥测数据。
在互联网中断期间，遥测 **本地** 存储，并在连接恢复后发送到 **Cloud**。

### 关系

**Relation（关系）**功能定义实体间的连接，并帮助建模物理对象之间的真实层级关系。

以下参数定义实体间的关系层级：
* **Direction（方向）：** 描述实体之间的关联方式。
    * **"Outbound relation - From"：** 表示关系 **源自** 该实体（_该实体为源_）。
    * **"Inbound relation - To"：** 表示关系 **指向** 该实体（_该实体为接收方_）。
* **Relation type（关系类型）：** 描述实体间连接的性质。
    * **"Contains"：** 表示实体是另一个实体的一部分（_如 Device A 是 Asset A 的一部分_）。
    * **"Manages"：** 表示实体负责管理另一个实体（_如 Asset A 管理 Device A_）。

实体关系图示例如下：
![image](/images/edge/user-guide/relations.webp){: style="display: block; margin: auto; max-width: 600px; max-height: 600px"}

## 下一步

{% include templates/edge/guides-banner-edge.md %}
