* TOC
{:toc}

  
**历史内容**：本页记录 **2026 年 1 月 20 日**之前创建账号的订阅计划。

**为何升级？** 新版订阅计划更灵活，可按需[充值](/docs/{{docsPrefix}}subscriptions/#top-ups)实体与 API 限制。
还支持将 ThingsBoard Edge 和 Trendz Analytics 作为[插件](/docs/{{docsPrefix}}subscriptions/#add-ons)启用，便于在一处管理整个 IoT 基础设施。

准备切换？请参阅[如何切换到新订阅计划](#how-to-switch-to-the-new-subscription-plans)页面。

这些计划已不再接受新订阅。
若需查看当前套餐与限制，请访问[**最新订阅**](/docs/{{docsPrefix}}subscriptions/)页面。

订阅计划主要包含：[实体限制](/docs/{{docsPrefix}}user-guide/tenant-profiles/#entity-limits)、[API 限制](/docs/{{docsPrefix}}user-guide/tenant-profiles/#api-limits--usage)、[计算字段限制](#calculated-fields-limits)、[白标](#white-labeling)以及支持级别。

## 实体限制

下表对比**历史**订阅计划的实体限制。

<table>
  <thead>
      <tr>
          <td style="width: 20%"><b>参数名</b></td>
          <td style="width: 10%"><b>Maker</b></td>
          <td style="width: 10%"><b>Prototype</b></td>
          <td style="width: 10%"><b>Startup</b></td>
          <td style="width: 10%"><b>Business</b></td>
          <td style="width: 10%"><b>Business+</b></td>
          <td style="width: 30%"><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>Devices</td>
          <td>30</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>2000</td>
          <td>设备最大数量</td>
      </tr>
      <tr>
          <td>Assets</td>
          <td>30</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>2000</td>
          <td>资产最大数量</td>
      </tr>
      <tr>
          <td>Customers</td>
          <td>2</td>
          <td>50</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>客户最大数量</td>
      </tr>
      <tr>
          <td>Users</td>
          <td>5</td>
          <td>50</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>用户最大数量</td>
      </tr>
      <tr>
          <td>Dashboards</td>
          <td>25</td>
          <td>100</td>
          <td>200</td>
          <td>500</td>
          <td>1000</td>
          <td>仪表板最大数量</td>
      </tr>
      <tr>
          <td>Rule chains</td>
          <td>5</td>
          <td>20</td>
          <td>50</td>
          <td>100</td>
          <td>200</td>
          <td>规则链最大数量</td>
      </tr>
      <tr>
          <td>Integrations</td>
          <td>1</td>
          <td>5</td>
          <td>10</td>
          <td>20</td>
          <td>40</td>
          <td>集成最大数量</td>
      </tr>
      <tr>
          <td>Converters</td>
          <td>5</td>
          <td>25</td>
          <td>50</td>
          <td>100</td>
          <td>200</td>
          <td>转换器最大数量</td>
      </tr>
      <tr>
          <td>Scheduler events</td>
          <td>5</td>
          <td>20</td>
          <td>50</td>
          <td>100</td>
          <td>200</td>
          <td>调度事件最大数量</td>
      </tr>            
  </tbody>
</table>

## API 限制

下表对比**历史**订阅计划的 API 限制。除非另有说明，数值均为月度限制。

<table>
  <thead>
      <tr>
          <td style="width: 20%"><b>参数名</b></td>
          <td style="width: 10%"><b>Maker</b></td>
          <td style="width: 10%"><b>Prototype</b></td>
          <td style="width: 10%"><b>Startup</b></td>
          <td style="width: 10%"><b>Business</b></td>
          <td style="width: 10%"><b>Business+</b></td>
          <td style="width: 30%"><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>Transport messages</td>
          <td>5M</td>
          <td>50M</td>
          <td>250M</td>
          <td>500M</td>
          <td>1B</td>
          <td>任一传输服务（MQTT、HTTP、CoAP 等）或集成接收的消息总数</td>
      </tr>
      <tr>
          <td>Transport data points</td>
          <td>10M</td>
          <td>100M</td>
          <td>500M</td>
          <td>1B</td>
          <td>2B</td>
          <td>遥测或属性传输消息中包含的键值对总数</td>
      </tr>
      <tr>
          <td>Rule Engine executions</td>
          <td>25M</td>
          <td>250M</td>
          <td>1B</td>
          <td>2B</td>
          <td>4B</td>
          <td>规则节点任意执行的总次数。<br>单条遥测消息处理可能触发多次 Rule Engine 执行。<br>平台也会统计 Generator 节点产生的周期消息等。</td>
      </tr>
      <tr>
          <td>JavaScript executions</td>
          <td>1M</td>
          <td>10M</td>
          <td>50M</td>
          <td>100M</td>
          <td>200M</td>
          <td>用户自定义函数任意执行的总次数，如“Script”过滤器或转换节点的处理、数据转换器调用等。</td>
      </tr>
      <tr>
          <td>Default storage TTL</td>
          <td>60 days</td>
          <td>180 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>用于存储时序数据的“生存时间”参数默认值。<br>
          可在“Save Timeseries”规则节点或消息的“TTL”元数据字段中覆盖。<br>
          便于优化存储消耗。TTL 最大允许值为 5 年。<br>
          例如：可将“原始”数据存 3 个月、聚合数据存 3 年
          </td>
      </tr>      
      <tr>
          <td>Data point storage days</td>
          <td>300M</td>
          <td>10B</td>
          <td>100B</td>
          <td>200B</td>
          <td>400B</td>
          <td>针对所有存入数据库的时序数据点计算存储天数。<br>
          平台将数据点数量乘以存储天数。<br> 
          TTL 参数用于确定存储天数。例如：1M 数据点存 30 天即为 30M 数据点存储天数</td>
      </tr>
      <tr>
          <td>Alarms TTL</td>
          <td>60 days</td>
          <td>180 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>告警在数据库中保存的天数</td>
      </tr>
      <tr>
          <td>RPC TTL</td>
          <td>60 days</td>
          <td>180 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>持久化 RPC 在数据库中保存的天数</td>
      </tr>
      <tr>
          <td>Alarms</td>
          <td>200</td>
          <td>4K</td>
          <td>20K</td>
          <td>40K</td>
          <td>60K</td>
          <td>每月创建的告警总数</td>
      </tr>
      <tr>
          <td>Emails</td>
          <td>100</td>
          <td>2K</td>
          <td>10K</td>
          <td>40K</td>
          <td>80K</td>
          <td>发送的邮件总数</td>
      </tr>
      <tr>
          <td>SMS</td>
          <td>0</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>2000</td>
          <td>发送的 SMS 总数</td>
      </tr>
  </tbody>
</table>

其中“**K**”表示 1 千，“**M**”表示 1 百万，“**B**”表示 10 亿。

## 计算字段限制

下表对比**历史**订阅计划的计算字段限制。

<table>
  <thead>
    <tr>
      <td style="width: 20%"><b>参数名</b></td>
      <td style="width: 10%"><b>Maker</b></td>
      <td style="width: 10%"><b>Prototype</b></td>
      <td style="width: 10%"><b>Startup</b></td>
      <td style="width: 10%"><b>Business</b></td>
      <td style="width: 10%"><b>Business+</b></td>
      <td style="width: 30%"><b>说明</b></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Calculated fields per entity maximum number</td>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>单实体允许的计算字段最大数量。</td>
    </tr>
    <tr>
      <td>Max data points number in rolling arguments</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>滚动参数支持的数据点最大数量。</td>
    </tr>
    <tr>
      <td>Arguments per calculated field max number</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>单个计算字段可使用的输入参数最大数量。</td>
    </tr>
    <tr>
      <td>State maximum size in KB</td>
      <td>32</td>
      <td>32</td>
      <td>32</td>
      <td>32</td>
      <td>32</td>
      <td>存储状态数据允许的最大大小（以 KB 计）。</td>
    </tr>
    <tr>
      <td>Single value argument maximum size in KB</td>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>单个参数值的最大大小（以 KB 计）。</td>
    </tr>
  </tbody>
</table> 

## 速率限制

平台的速率限制策略旨在保证可预测的服务质量，并在峰值负载下保持运行韧性。限制在**租户层面**（所有设备与用户的聚合活动）和**单设备层面**同时生效，采用每秒、每分钟、每小时的统一时间窗口，在突发容忍与持续吞吐上限之间取得平衡。阈值随套餐（Maker、Prototype、Startup、Business、Business+）变化，与预期流量画像匹配，确保多租户公平使用及 SLA 达标。

若工作负载超过分配限制，相应请求将被平台临时拒绝，直至速率恢复到策略范围内。此外，发生超限时平台会通知租户管理员。

<table>
  <thead>
      <tr>
          <td><b>参数名</b></td>
          <td><b>Maker</b></td>
          <td><b>Prototype</b></td>
          <td><b>Startup</b></td>
          <td><b>Business</b></td>
          <td><b>Business+</b></td>
          <td><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>All Transport messages (Tenant)</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 140,000 per hour</td>
          <td>Up to 2,000 per second,<br>not exceeding 60,000 per minute,<br>and capped at 1,400,000 per hour</td>
          <td>Up to 10,000 per second,<br>not exceeding 300,000 per minute,<br>and capped at 6,000,000 per hour</td>
          <td>Up to 20,000 per second,<br>not exceeding 600,000 per minute,<br>and capped at 12,000,000 per hour</td>
          <td>Up to 40,000 per second,<br>not exceeding 1,200,000 per minute,<br>and capped at 24,000,000 per hour</td>
          <td>任一传输微服务为该租户下所有设备接收的消息总数</td>
      </tr>
      <tr>
          <td>Telemetry Transport messages (Tenant)</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 70,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 700,000 per hour</td>
          <td>Up to 5,000 per second,<br>not exceeding 150,000 per minute,<br>and capped at 3,500,000 per hour</td>
          <td>Up to 10,000 per second,<br>not exceeding 300,000 per minute,<br>and capped at 7,000,000 per hour</td>
          <td>Up to 20,000 per second,<br>not exceeding 600,000 per minute,<br>and capped at 14,000,000 per hour</td>
          <td>任一传输微服务为该租户下所有设备接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>Telemetry Transport data points (Tenant)</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 140,000 per hour</td>
          <td>Up to 2,000 per second,<br>not exceeding 60,000 per minute,<br>and capped at 1,400,000 per hour</td>
          <td>Up to 10,000 per second,<br>not exceeding 300,000 per minute,<br>and capped at 7,000,000 per hour</td>
          <td>Up to 20,000 per second,<br>not exceeding 600,000 per minute,<br>and capped at 14,000,000 per hour</td>
          <td>Up to 40,000 per second,<br>not exceeding 1,200,000 per minute,<br>and capped at 28,000,000 per hour</td>
          <td>任一传输微服务为该租户下所有设备接收的遥测数据点总数</td>
      </tr>            
      <tr>
          <td>All Transport messages (Device)</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>任一传输微服务为各设备单独接收的消息总数</td>
      </tr>
      <tr>
          <td>Telemetry Transport messages (Device)</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>任一传输微服务为各设备单独接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>Telemetry Transport data points (Device)</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 6,000 per minute,<br>and capped at 14,000 per hour</td>
          <td>任一传输微服务为各设备单独接收的遥测数据点总数</td>
      </tr>
      <tr>
          <td>Integration messages (Tenant)</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 70,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 700,000 per hour</td>
          <td>Up to 5,000 per second,<br>not exceeding 150,000 per minute,<br>and capped at 3,500,000 per hour</td>
          <td>Up to 10,000 per second,<br>not exceeding 300,000 per minute,<br>and capped at 7,000,000 per hour</td>
          <td>Up to 20,000 per second,<br>not exceeding 600,000 per minute,<br>and capped at 14,000,000 per hour</td>
          <td>任一传输微服务为该租户下所有设备接收的消息总数</td>
      </tr>
      <tr>
          <td>Integration messages (Device)</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 3,000 per minute,<br>and capped at 7,000 per hour</td>
          <td>任一传输微服务为所有设备接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>REST requests (Tenant)</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>该租户下任一用户发起的 REST API 调用总数</td>
      </tr>
      <tr>
          <td>REST requests (Customer)</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>特定客户下任一用户发起的 REST API 调用总数</td>
      </tr>
      <tr>
          <td>WS updates per session</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>特定 WebSocket 会话接收的消息总数</td>
      </tr>
      <tr>
          <td>WS Sessions (Tenant)</td>
          <td>1K</td>
          <td>1K</td>
          <td>1K</td>
          <td>1K</td>
          <td>1K</td>
          <td>该租户的 WebSocket 会话最大数量</td>
      </tr>
      <tr>
          <td>WS Subscriptions (Tenant)</td>
          <td>20K</td>
          <td>20K</td>
          <td>20K</td>
          <td>20K</td>
          <td>20K</td>
          <td>该租户的 WebSocket 订阅最大数量</td>
      </tr>
      <tr>
          <td>WS Sessions (Customer)</td>
          <td>500</td>
          <td>500</td>
          <td>500</td>
          <td>500</td>
          <td>500</td>
          <td>该客户的 WebSocket 会话最大数量</td>
      </tr>
      <tr>
          <td>WS Subscriptions (Customer)</td>
          <td>10K</td>
          <td>10K</td>
          <td>10K</td>
          <td>10K</td>
          <td>10K</td>
          <td>该客户的 WebSocket 订阅最大数量</td>
      </tr>
      <tr>
          <td>WS Sessions (Public user)</td>
          <td>250</td>
          <td>250</td>
          <td>250</td>
          <td>250</td>
          <td>250</td>
          <td>每位公开用户的会话最大数量</td>
      </tr>
      <tr>
          <td>WS Subscriptions (Public user)</td>
          <td>5K</td>
          <td>5K</td>
          <td>5K</td>
          <td>5K</td>
          <td>5K</td>
          <td>每位公开用户的订阅最大数量</td>
      </tr> 
      <tr>
          <td>WS Sessions (Regular user)</td>
          <td>100</td>
          <td>100</td>
          <td>100</td>
          <td>100</td>
          <td>100</td>
          <td>每位普通用户的会话最大数量</td>
      </tr>
      <tr>
          <td>WS Subscriptions (Regular user)</td>
          <td>2K</td>
          <td>2K</td>
          <td>2K</td>
          <td>2K</td>
          <td>2K</td>
          <td>每位普通用户的订阅最大数量</td>
      </tr>
      <tr>
          <td>WS queue message (Session)</td>
          <td>500</td>
          <td>500</td>
          <td>500</td>
          <td>500</td>
          <td>500</td>
          <td>每会话的队列消息最大大小</td>
      </tr>
  </tbody>
</table>

其中“**K**”表示 1 千，“**M**”表示 1 百万，“**B**”表示 10 亿。

## 白标

ThingsBoard Web 界面支持在 2 分钟内配置公司或产品 Logo 及配色，无需编码、无需重启服务。
详见功能[文档](/docs/{{docsPrefix}}user-guide/white-labeling/){:target="_blank"}。ThingsBoard Cloud 扩展了白标能力，支持便捷配置自有域名。
详见[域名管理](/products/{{docsPrefix}}domains/){:target="_blank"}。

白标功能在 **Prototype**、**Startup** 和 **Business** 的**历史**订阅计划中可用。

## 如何切换到新订阅计划？

研究表明**约 90% 的现有客户**在现有历史计划下已能满足需求，但不少用户仍可能认为新的**按需付费 + 充值**模式更具吸引力且更经济。

切换的主要优势在于**灵活性**。无需为了提升某项限制（如 API 调用或 SMS 数量）而升级到明显更高级的套餐，新模型支持为所需资源单独购买充值。

**充值可用范围**：

* **通用充值**：API 限制及通用实体（如告警、规则链等）的充值自 Pilot 套餐起可用。
* **设备与资产充值**：设备与资产最大数量的充值仅在 Business 套餐中提供。

**两步即可切换**

切换至新模型无需数据迁移，过程简单。

1. 在左侧主导航进入**“计划与计费”**。
2. 点击**“更新计划”**按钮。
3. 选择目标套餐并确认。

## 如何取消订阅？

终止 ThingsBoard Cloud 订阅可按下述步骤操作：

- 以租户管理员身份登录 ThingsBoard Cloud。
- 点击屏幕右上角**三点图标**，在下拉菜单中选择**账户**进入账户设置。
- 在**个人资料**标签下点击橙色**删除账户**按钮。
- 按提示完成取消订阅流程。
- 在确认对话框中点击**“我了解后果，删除账户”**完成确认。

之后，订阅终止入口将迁移至 ThingsBoard 导航菜单中的**“计划与计费”**页面。

{% include images-gallery.html imageCollection="cancel-my-subscription" %}