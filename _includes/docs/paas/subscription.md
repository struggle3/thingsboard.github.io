* TOC
{:toc}

ThingsBoard {{cloudPrefix}} Cloud 提供基于灵活**按需付费**模式的订阅计划。
计划支持弹性扩展，可按需[充值](#top-ups)实体与 API 限额，并可启用 **ThingsBoard Edge** 和 **Trendz Analytics** 作为插件，方便在一处管理整个 IoT 基础设施。

订阅计划主要包含：[实体限制](/docs/{{docsPrefix}}user-guide/tenant-profiles/#entity-limits)、[API 限制](/docs/{{docsPrefix}}user-guide/tenant-profiles/#api-limits--usage)、[计算字段限制](#calculated-fields-limits)、[白标](#white-labeling)以及支持级别。

**查找旧版套餐详情？** 本页为 2026 年 1 月 20 日引入的订阅层级。若账号在此之前创建，请查看[历史订阅](/docs/{{docsPrefix}}legacy-subscriptions)页面。

## 实体限制

下表对比各订阅计划的实体限制。

<table>
  <thead>
      <tr>
          <td style="width: 20%"><b>参数名</b></td>
          <td style="width: 10%"><b>Free</b></td>
          <td style="width: 10%"><b>Prototype</b></td>
          <td style="width: 10%"><b>Pilot</b></td>
          <td style="width: 10%"><b>Startup</b></td>
          <td style="width: 10%"><b>Business</b></td>
          <td style="width: 30%"><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>Devices</td>
          <td>5</td>
          <td>50</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>设备最大数量</td>
      </tr>
      <tr>
          <td>Assets</td>
          <td>5</td>
          <td>50</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>资产最大数量</td>
      </tr>
      <tr>
          <td>Customers</td>
          <td>2</td>
          <td>5</td>
          <td>50</td>
          <td>100</td>
          <td>200</td>
          <td>客户最大数量</td>
      </tr>
      <tr>
          <td>Users</td>
          <td>5</td>
          <td>10</td>
          <td>50</td>
          <td>100</td>
          <td>200</td>
          <td>用户最大数量</td>
      </tr>
      <tr>
          <td>Dashboards</td>
          <td>5</td>
          <td>50</td>
          <td>100</td>
          <td>200</td>
          <td>500</td>
          <td>仪表板最大数量</td>
      </tr>
      <tr>
          <td>Rule chains</td>
          <td>3</td>
          <td>5</td>
          <td>20</td>
          <td>50</td>
          <td>100</td>
          <td>规则链最大数量</td>
      </tr>
      <tr>
          <td>Integrations</td>
          <td>1</td>
          <td>3</td>
          <td>5</td>
          <td>10</td>
          <td>20</td>
          <td>集成最大数量</td>
      </tr>
      <tr>
          <td>Converters</td>
          <td>3</td>
          <td>10</td>
          <td>15</td>
          <td>25</td>
          <td>50</td>
          <td>转换器最大数量</td>
      </tr>
      <tr>
          <td>Scheduler events</td>
          <td>5</td>
          <td>10</td>
          <td>100</td>
          <td>250</td>
          <td>500</td>
          <td>调度事件最大数量</td>
      </tr>            
  </tbody>
</table>

## API 限制

下表对比各订阅计划的 API 限制。除非另有说明，数值均为月度限制。

<table>
  <thead>
      <tr>
          <td style="width: 20%"><b>参数名</b></td>
          <td style="width: 10%"><b>Free</b></td>
          <td style="width: 10%"><b>Prototype</b></td>
          <td style="width: 10%"><b>Pilot</b></td>
          <td style="width: 10%"><b>Startup</b></td>
          <td style="width: 10%"><b>Business</b></td>
          <td style="width: 30%"><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>Transport messages</td>
          <td>0.5M</td>
          <td>5M</td>
          <td>50M</td>
          <td>250M</td>
          <td>500M</td>
          <td>任一传输服务（MQTT、HTTP、CoAP 等）或集成接收的消息总数</td>
      </tr>
      <tr>
          <td>Transport data points</td>
          <td>1M</td>
          <td>10M</td>
          <td>100M</td>
          <td>500M</td>
          <td>1B</td>
          <td>遥测或属性传输消息中包含的键值对总数</td>
      </tr>
      <tr>
          <td>Rule Engine executions</td>
          <td>3M</td>
          <td>30M</td>
          <td>250M</td>
          <td>1B</td>
          <td>2B</td>
          <td>规则节点任意执行的总次数。<br>单条遥测消息处理可能触发多次 Rule Engine 执行。<br>平台也会统计 Generator 节点产生的周期消息等。</td>
      </tr>
      <tr>
          <td>JavaScript executions</td>
          <td>100K</td>
          <td>1M</td>
          <td>10M</td>
          <td>50M</td>
          <td>100M</td>
          <td>用户自定义函数任意执行的总次数，如 “Script” 过滤器或转换节点的处理、数据转换器调用等。</td>
      </tr>
      <tr>
          <td>Default storage TTL</td>
          <td>30 days</td> 
          <td>60 days</td>
          <td>180 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>用于存储时序数据的“生存时间”参数默认值。<br>
          可在“Save Timeseries”规则节点或消息的“TTL”元数据字段中覆盖。<br>
          便于优化存储消耗。TTL 最大允许值为 10 年。<br>
          例如：可将“原始”数据存 3 个月、聚合数据存 3 年
          </td>
      </tr>      
      <tr>
          <td>Data point storage days</td>
          <td>30M</td>
          <td>1B</td>
          <td>10B</td>
          <td>100B</td>
          <td>200B</td>
          <td>针对所有存入数据库的时序数据点计算存储天数。<br>
          平台将数据点数量乘以存储天数。<br> 
          TTL 参数用于确定存储天数。例如：1M 数据点存 30 天即为 30M 数据点存储天数</td>
      </tr>
      <tr>
          <td>Alarms TTL</td>
          <td>30 days</td>
          <td>60 days</td>
          <td>180 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>告警在数据库中保存的天数</td>
      </tr>
      <tr>
          <td>RPC TTL</td>
          <td>30 days</td>
          <td>60 days</td>
          <td>180 days</td>
          <td>365 days</td>
          <td>365 days</td>
          <td>持久化 RPC 在数据库中保存的天数</td>
      </tr>
      <tr>
          <td>Alarms</td>
          <td>200</td>
          <td>1K</td>
          <td>4K</td>
          <td>20K</td>
          <td>40K</td>
          <td>每月创建的告警总数</td>
      </tr>
      <tr>
          <td>Emails</td>
          <td>100</td>
          <td>1K</td>
          <td>2K</td>
          <td>10K</td>
          <td>40K</td>
          <td>发送的邮件总数</td>
      </tr>
      <tr>
          <td>SMS</td>
          <td>0</td>
          <td>10</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>发送的 SMS 总数</td>
      </tr>
  </tbody>
</table>

其中“**K**”表示 1 千，“**M**”表示 1 百万，“**B**”表示 10 亿。

## 计算字段限制

下表对比各订阅计划的计算字段限制。

<table>
  <thead>
    <tr>
      <td style="width: 20%"><b>参数名</b></td>
      <td style="width: 10%"><b>Free</b></td>
      <td style="width: 10%"><b>Prototype</b></td>
      <td style="width: 10%"><b>Pilot</b></td>
      <td style="width: 10%"><b>Startup</b></td>
      <td style="width: 10%"><b>Business</b></td>
      <td style="width: 30%"><b>说明</b></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Calculated fields per entity maximum number</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
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
      <td>16</td>
      <td>16</td>
      <td>16</td>
      <td>16</td>
      <td>16</td>
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
          <td><b>Free</b></td>
          <td><b>Prototype</b></td>
          <td><b>Pilot</b></td>
          <td><b>Startup</b></td>
          <td><b>Business</b></td>
          <td><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>All Transport messages (Tenant)</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute,<br>and capped at 75,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 750,000 per hour</td>
          <td>Up to 2,000 per second,<br>not exceeding 60,000 per minute,<br>and capped at 1,500,000 per hour</td>
          <td>Up to 10,000 per second,<br>not exceeding 300,000 per minute,<br>and capped at 7,500,000 per hour</td>
          <td>Up to 20,000 per second,<br>not exceeding 600,000 per minute,<br>and capped at 15,000,000 per hour</td>
          <td>任一传输微服务为该租户下所有设备接收的消息总数</td>
      </tr>
      <tr>
          <td>Telemetry Transport messages (Tenant)</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute,<br>and capped at 35,000 per hour</td>
          <td>Up to 500 per second,<br>not exceeding 15,000 per minute,<br>and capped at 350,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 700,000 per hour</td>
          <td>Up to 5,000 per second,<br>not exceeding 150,000 per minute,<br>and capped at 3,500,000 per hour</td>
          <td>Up to 10,000 per second,<br>not exceeding 300,000 per minute,<br>and capped at 7,000,000 per hour</td>
          <td>任一传输微服务为该租户下所有设备接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>Telemetry Transport data points (Tenant)</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute,<br>and capped at 70,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 700,000 per hour</td>
          <td>Up to 2,000 per second,<br>not exceeding 60,000 per minute,<br>and capped at 1,400,000 per hour</td>
          <td>Up to 10,000 per second,<br>not exceeding 300,000 per minute,<br>and capped at 7,000,000 per hour</td>
          <td>Up to 20,000 per second,<br>not exceeding 600,000 per minute,<br>and capped at 14,000,000 per hour</td>
          <td>任一传输微服务为该租户下所有设备接收的遥测数据点总数</td>
      </tr>            
      <tr>
          <td>All Transport messages (Device)</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>任一传输微服务为各设备单独接收的消息总数</td>
      </tr>
      <tr>
          <td>Telemetry Transport messages (Device)</td>
          <td>Up to 50 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>任一传输微服务为各设备单独接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>Telemetry Transport data points (Device)</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>任一传输微服务为各设备单独接收的遥测数据点总数</td>
      </tr>
      <tr>
          <td>Integration messages (Tenant)</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute,<br>and capped at 30,000 per hour</td>
          <td>Up to 500 per second,<br>not exceeding 15,000 per minute,<br>and capped at 350,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 750,000 per hour</td>
          <td>Up to 5,000 per second,<br>not exceeding 150,000 per minute,<br>and capped at 3,500,000 per hour</td>
          <td>Up to 10,000 per second,<br>not exceeding 300,000 per minute,<br>and capped at 7,500,000 per hour</td>
          <td>任一传输微服务为该租户下所有设备接收的消息总数</td>
      </tr>
      <tr>
          <td>Integration messages (Device)</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>任一传输微服务为所有设备接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>Gateway Transport messages (All connected devices)</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute,<br>and capped at 60,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 360,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 360,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 360,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 360,000 per hour</td>
          <td>传输微服务为经特定网关连接的所有设备接收的消息总数</td>
      </tr>
      <tr>
          <td>Gateway Telemetry Transport messages (All connected  devices)</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute,<br>and capped at 30,000 per hour</td>
          <td>Up to 500 per second,<br>not exceeding 15,000 per minute,<br>and capped at 180,000 per hour</td>
          <td>Up to 500 per second,<br>not exceeding 15,000 per minute,<br>and capped at 180,000 per hour</td>
          <td>Up to 500 per second,<br>not exceeding 15,000 per minute,<br>and capped at 180,000 per hour</td>
          <td>Up to 500 per second,<br>not exceeding 15,000 per minute,<br>and capped at 180,000 per hour</td>
          <td>传输微服务为经特定网关连接的所有设备接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>Gateway Telemetry Transport data points (All connected devices)</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute,<br>and capped at 60,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 360,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 360,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 360,000 per hour</td>
          <td>Up to 1,000 per second,<br>not exceeding 30,000 per minute,<br>and capped at 360,000 per hour</td>
          <td>传输微服务为经特定网关连接的所有设备接收的遥测数据点总数</td>
      </tr> 
      <tr>
          <td>Gateway Transport messages (Gateway system messages)</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>传输微服务为特定网关（不含关联设备）接收的消息总数：统计、调试日志、配置更新</td>
      </tr>
      <tr>
          <td>Gateway Telemetry Transport messages (Gateway system messages)</td>
          <td>Up to 50 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>Up to 100 per second,<br>not exceeding 600 per minute,<br>and capped at 7,000 per hour</td>
          <td>传输微服务为特定网关接收的遥测消息总数：统计、调试日志及其他遥测</td>
      </tr>
      <tr>
          <td>Gateway Telemetry Transport data points (Gateway system messages)</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>Up to 200 per second,<br>not exceeding 2,000 per minute,<br>and capped at 15,000 per hour</td>
          <td>传输微服务为特定网关接收的遥测数据点总数：统计、调试日志及其他遥测</td>
      </tr>
      <tr>
          <td>REST requests (Tenant)</td>
          <td>Up to 100 per second,<br>not exceeding 1,000 per minute</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>Up to 100 per second,<br>not exceeding 2,000 per minute</td>
          <td>该租户下任一用户发起的 REST API 调用总数</td>
      </tr>
      <tr>
          <td>REST requests (Customer)</td>
          <td>Up to 50 per second,<br>not exceeding 500 per minute</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>Up to 50 per second,<br>not exceeding 1,000 per minute</td>
          <td>特定客户下任一用户发起的 REST API 调用总数</td>
      </tr>
      <tr>
          <td>WS updates per session</td>
          <td>Up to 1,000 per second,<br>not exceeding 5,000 per minute</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>Up to 1,000 per second,<br>not exceeding 10,000 per minute</td>
          <td>特定 WebSocket 会话接收的消息总数</td>
      </tr>
      <tr>
          <td>WS Sessions (Tenant)</td>
          <td>50</td>
          <td>100</td>
          <td>1K</td>
          <td>2K</td>
          <td>4K</td>
          <td>该租户的 WebSocket 会话最大数量</td>
      </tr>
      <tr>
          <td>WS Subscriptions (Tenant)</td>
          <td>1K</td>
          <td>2K</td>
          <td>4K</td>
          <td>20K</td>
          <td>40K</td>
          <td>该租户的 WebSocket 订阅最大数量</td>
      </tr>
      <tr>
          <td>WS Sessions (Customer)</td>
          <td>25</td>
          <td>50</td>
          <td>500</td>
          <td>1K</td>
          <td>2K</td>
          <td>该客户的 WebSocket 会话最大数量</td>
      </tr>
      <tr>
          <td>WS Subscriptions (Customer)</td>
          <td>500</td>
          <td>1K</td>
          <td>2K</td>
          <td>10K</td>
          <td>20K</td>
          <td>该客户的 WebSocket 订阅最大数量</td>
      </tr>
      <tr>
          <td>WS Sessions (Public user)</td>
          <td>20</td>
          <td>100</td>
          <td>250</td>
          <td>250</td>
          <td>250</td>
          <td>每位公开用户的会话最大数量</td>
      </tr>
      <tr>
          <td>WS Subscriptions (Public user)</td>
          <td>500</td>
          <td>1K</td>
          <td>5K</td>
          <td>5K</td>
          <td>5K</td>
          <td>每位公开用户的订阅最大数量</td>
      </tr> 
      <tr>
          <td>WS Sessions (Regular user)</td>
          <td>10</td>
          <td>50</td>
          <td>100</td>
          <td>100</td>
          <td>100</td>
          <td>每位普通用户的会话最大数量</td>
      </tr>
      <tr>
          <td>WS Subscriptions (Regular user)</td>
          <td>200</td>
          <td>1K</td>
          <td>2K</td>
          <td>2K</td>
          <td>2K</td>
          <td>每位普通用户的订阅最大数量</td>
      </tr>
      <tr>
          <td>WS queue message (Session)</td>
          <td>100</td>
          <td>250</td>
          <td>500</td>
          <td>500</td>
          <td>500</td>
          <td>每会话的队列消息最大大小</td>
      </tr>
  </tbody>
</table>

其中“**K**”表示 1 千，“**M**”表示 1 百万，“**B**”表示 10 亿。

## 充值

若订阅计划内某项限制已触达，通常无需升级到更高档位。
您可购买**充值包**即时提升单项限制。

**注意：** 充值为基础计划的每月叠加项，按月计费。

---

#### 实体充值

此类充值包可提升环境中管理的实体与集成数量。

<table>
  <thead>
      <tr>
          <td style="width: 30%"><b>充值包名称</b></td>
          <td style="width: 50%"><b>新增容量</b></td>
          <td style="width: 10%"><b>费用</b></td>
      </tr>
  </thead>
  <tbody>
    <tr>
      <td>Extra Device Pack</td>
      <td>+50 Devices、+50 Assets</td>
      <td>{{cloudCurrency}}15</td>
    </tr>
    <tr>
      <td>Extra Customer Pack</td>
      <td>+10 Customers、+10 Users</td>
      <td>{{cloudCurrency}}10</td>
    </tr>
    <tr>
      <td>Extra Integration Pack</td>
      <td>+1 Integration、+1 Converter</td>
      <td>{{cloudCurrency}}10</td>
    </tr>
    <tr>
      <td>Extra Calculated Field</td>
      <td>每实体 Calculated Fields 最大数量 +1</td>
      <td>{{cloudCurrency}}5</td>
    </tr>
  </tbody>
</table>

**可用范围：** Extra Device 包自 **Business** 套餐起可用；其他实体充值自 **Pilot** 套餐起可用。

#### API 限制充值

此类充值包可扩展解决方案的运行能力，保障数据处理与通信顺畅。

<table>
  <thead>
      <tr>
          <td style="width: 30%"><b>充值包名称</b></td>
          <td style="width: 60%"><b>新增容量</b></td>
          <td style="width: 10%"><b>费用</b></td>
      </tr>
  </thead>
  <tbody>
    <tr>
      <td>Traffic Pack</td>
      <td>+2.5M Transport Messages、+5M Transport Data Points</td>
      <td>{{cloudCurrency}}5</td>
    </tr>
    <tr>
      <td>Compute Pack</td>
      <td>+5M Rule Engine Executions、+1M JavaScript Executions</td>
      <td>{{cloudCurrency}}25</td>
    </tr>
    <tr>
      <td>Storage Pack</td>
      <td>+1B Data Points Storage Days</td>
      <td>{{cloudCurrency}}10</td>
    </tr>
    <tr>
      <td>Alarm Pack</td>
      <td>每月 +1K 告警创建</td>
      <td>{{cloudCurrency}}1</td>
    </tr>
    <tr>
      <td>Email Pack</td>
      <td>每月 +1K 邮件发送</td>
      <td>{{cloudCurrency}}1</td>
    </tr>
    <tr>
      <td>SMS Pack</td>
      <td>每月 +100 SMS 发送</td>
      <td>{{cloudCurrency}}15</td>
    </tr>
  </tbody>
</table>

<br>

**可用范围：** 所有用量与 API 充值自 **Pilot** 套餐起可用。

## 插件

### 白标

ThingsBoard Web 界面支持在 2 分钟内配置公司或产品 Logo 及配色，无需编码、无需重启服务。
详见功能[文档](/docs/{{docsPrefix}}user-guide/white-labeling/){:target="_blank"}。ThingsBoard Cloud 扩展了白标能力，支持便捷配置自有域名。
详见[域名管理](/products/{{docsPrefix}}domains/){:target="_blank"}。

白标插件自 **Pilot** 套餐起自动启用。

### Edge Computing

**Edge Computing** 插件将智能与数据处理能力带到现场。
支持在本地部署平台实例，确保即便与云端的网络完全中断，关键业务仍可持续运行。
详见产品[首页](/products/thingsboard-edge/){:target="_blank"}。

### Trendz Analytics

**Trendz Analytics** 插件是面向 IoT 的 BI 工具，可将原始 IoT 数据转化为可执行的洞察。
除基础可视化外，还支持复杂计算、模式识别及基于高级统计模型的未来趋势预测。
详见产品[首页](/products/trendz/){:target="_blank"}。

## 如何取消订阅？

取消 ThingsBoard {{cloudPrefix}} Cloud 订阅可按下述步骤操作：

- 进入**计划与计费**。
- 点击**取消订阅**。
- 按界面提示完成操作。
- 在确认对话框中再次点击**取消订阅**完成确认。

{% capture update-only-keys-cluster-mode %}
**注意：**
<br>
此操作不可撤销，将**永久删除**您的租户账号、所有设备、资产、仪表板、规则链、用户及其他实体，以及所有遥测数据与告警。
{% endcapture %}
{% include templates/warn-banner.md content=update-only-keys-cluster-mode %}
