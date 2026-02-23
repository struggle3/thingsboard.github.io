---
layout: common
assignees:
- ashvayka
title: ThingsBoard Private Cloud 订阅方案定义
description: ThingsBoard Private Cloud 的实体、API 和速率限制

---


* TOC
{:toc}

ThingsBoard Private Cloud 基于**按需付费**模型提供订阅方案。  
订阅方案的主要参数为连接的设备数量及其产生的消息量。  
为保障环境安全，我们对实体、[API](/docs/pe/user-guide/tenant-profiles/#api-limits--usage) 和[速率限制](/docs/pe/user-guide/tenant-profiles/#rate-limits)设置了相应限制。

## 附加功能

<table>
    <thead>
        <tr>
            <th></th>
            <th>Launch</th>
            <th>Growth</th>
            <th>Scale</th>
            <th>Enterprise</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>数据与配置迁移</td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>自动备份</td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>24/7 监控</td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>支持</td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>自定义数据保留策略</td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>地理区域部署选择</td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>维护窗口选择</td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>Database</td>
            <td>SQL + NoSQL</td>
            <td>SQL + NoSQL</td>
            <td>SQL + NoSQL</td>
            <td>SQL + NoSQL</td>
        </tr>
        <tr>
            <td>Multi-AZ database replication</td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>High availability services</td>
            <td></td>
            <td></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
            <td><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></td>
        </tr>
        <tr>
            <td>架构评审与咨询</td>
            <td><a href="/docs/contact-us/?subject=Private%20Cloud&message=Architecture%20reviews%20and%20consults">按需提供</a></td>
            <td><a href="/docs/contact-us/?subject=Private%20Cloud&message=Architecture%20reviews%20and%20consults">Upon request</a></td>
            <td><a href="/docs/contact-us/?subject=Private%20Cloud&message=Architecture%20reviews%20and%20consults">Upon request</a></td>
            <td><a href="/docs/contact-us/?subject=Private%20Cloud&message=Architecture%20reviews%20and%20consults"><img src="/images/pricing/pricing-checkmark-icon.svg" alt="Checkmark icon" title="Option included in plan"></a></td>
        </tr>
    </tbody>
</table>

## 实体限制

请参阅下表对比各订阅方案的实体限制。

<table>
	<thead>
		<tr>
			<td><b>参数名称</b></td>
			<td><b>Launch</b></td>
			<td><b>Growth</b></td>
			<td><b>Scale</b></td>
			<td><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><b>Devices</b></td>
			<td>5,000</td>
			<td>25,000</td>
			<td>50,000</td>
			<td>设备数量上限</td>
		</tr>
		<tr>
			<td><b>Assets</b></td>
			<td>5,000</td>
			<td>25,000</td>
			<td>50,000</td>
			<td>资产数量上限</td>
		</tr>
		<tr>
			<td><b>Customers</b></td>
			<td>5,000</td>
			<td>25,000</td>
			<td>50,000</td>
			<td>客户数量上限</td>
		</tr>
		<tr>
			<td><b>Users</b></td>
			<td>5,000</td>
			<td>25,000</td>
			<td>50,000</td>
			<td>用户数量上限</td>
		</tr>
		<tr>
			<td><b>Dashboards</b></td>
			<td>1,000</td>
			<td>5,000</td>
			<td>10,000</td>
			<td>仪表板数量上限</td>
		</tr>
		<tr>
			<td><b>Scheduler Events</b></td>
			<td>1,000</td>
			<td>5,000</td>
			<td>10,000</td>
			<td>调度事件数量上限</td>
		</tr>
		<tr>
			<td><b>Integrations</b></td>
			<td>30</td>
			<td>50</td>
			<td>100</td>
			<td>集成数量上限</td>
		</tr>
		<tr>
			<td><b>Converters</b></td>
			<td>100</td>
			<td>200</td>
			<td>400</td>
			<td>转换器数量上限</td>
		</tr>
		<tr>
			<td><b>Rule Chains</b></td>
			<td>50</td>
			<td>100</td>
			<td>150</td>
			<td>规则链数量上限</td>
		</tr>
	</tbody>
</table>

## API 限制

请参阅下表对比各订阅方案的 API 限制。除另有说明外，数值为月度 API 限制。

<table>
	<thead>
		<tr>
			<td><b>参数名称</b></td>
			<td><b>Launch</b></td>
			<td><b>Growth</b></td>
			<td><b>Scale</b></td>
			<td><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
        <tr>
            <td>传输消息</td>
            <td>1B</td>
            <td>5B</td>
            <td>25B</td>
            <td>任意传输（MQTT、HTTP、CoAP 等）或集成接收的消息总数</td>
        </tr>
        <tr>
            <td>传输数据点</td>
            <td>1B</td>
            <td>5B</td>
            <td>25B</td>
            <td>遥测或属性传输消息包含的键值对总数</td>
        </tr>
		<tr>
			<td><b>Rule Engine 执行次数</b></td>
			<td>5B</td>
			<td>25B</td>
			<td>125B</td>
			<td>规则节点执行总次数。单条遥测消息处理可能触发多次 Rule Engine 执行。平台也会计入 Generator 节点等产生的周期性消息。</td>
		</tr>
		<tr>
			<td><b>TBEL 执行次数</b></td>
			<td>10B</td>
			<td>50B</td>
			<td>250B</td>
			<td>使用 TBEL 编写的用户自定义函数执行总次数。例如 Script 过滤器或转换节点处理、数据转换器调用等。</td>
		</tr>
		<tr>
			<td><b>JavaScript 执行次数</b></td>
			<td>200M</td>
			<td>1B</td>
			<td>5B</td>
			<td>使用 JS 编写的用户自定义函数执行总次数。 例如 Script 过滤器或转换节点处理、数据转换器调用等。</td>
		</tr>
		<tr>
			<td><b>默认存储 TTL</b></td>
			<td>365 天</td>
			<td>365 天</td>
			<td>365 天</td>
			<td>遥测默认在数据库中保留天数。可应要求配置。</td>
		</tr>
		<tr>
			<td><b>默认告警 TTL</b></td>
			<td>365 天</td>
			<td>365 天</td>
			<td>365 天</td>
			<td>告警默认在数据库中保留天数。可应要求配置。</td>
		</tr>
		<tr>
			<td><b>默认 RPC TTL</b></td>
			<td>1 周</td>
			<td>1 周</td>
			<td>1 周</td>
			<td>持久化 RPC 默认在数据库中保留天数。可应要求配置。</td>
		</tr>
		<tr>
			<td><b>默认通知 TTL</b></td>
			<td>1 周</td>
			<td>1 周</td>
			<td>1 周</td>
			<td>通知默认在数据库中保留天数。可应要求配置。</td>
		</tr>
		<tr>
			<td><b>默认调试事件 TTL</b></td>
			<td>1 周</td>
			<td>1 周</td>
			<td>1 周</td>
			<td>调试事件默认在数据库中保留天数。可应要求配置。</td>
		</tr>
		<tr>
			<td><b>每月新增告警</b></td>
			<td>50K</td>
			<td>75K</td>
			<td>100K</td>
			<td>每月创建的告警总数。</td>
		</tr>
		<tr>
			<td><b>每条消息 Rule Engine 执行次数</b></td>
			<td>20</td>
			<td>20</td>
			<td>20</td>
			<td>处理单条消息的最大规则节点执行次数。</td>
		</tr>
		<tr>
			<td><b>每实体计算字段数</b></td>
			<td>5</td>
			<td>5</td>
			<td>5</td>
			<td>每实体的计算字段数量。</td>
		</tr>
		<tr>
			<td><b>每计算字段参数数</b></td>
			<td>10</td>
			<td>10</td>
			<td>10</td>
			<td>计算字段中可使用参数的最大数量。</td>
		</tr>
		<tr>
			<td><b>滚动参数数据点数</b></td>
			<td>1000</td>
			<td>1000</td>
			<td>1000</td>
			<td>作为计算字段滚动参数存储的最大数据点数。</td>
		</tr>
	</tbody>
</table>

其中「**K**」表示千，「**M**」表示百万，「**B**」表示十亿。

## 速率限制

<table>
	<thead>
		<tr>
			<td><b>参数名称</b></td>
			<td><b>Launch</b></td>
			<td><b>Growth</b></td>
			<td><b>Scale</b></td>
            <td><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><b>所有消息</b></td>
			<td>Up to <b>2K</b> per second, not exceeding <b>25K</b> per minute and capped at <b>1.2M</b> per hour</td>
			<td>Up to <b>10K</b> per second, not exceeding <b>125K</b> per minute and capped at <b>6M</b> per hour</td>
			<td>Up to <b>20K</b> per second, not exceeding <b>600K</b> per minute and capped at <b>30M</b> per hour</td>
			<td>所有设备通过任意传输或集成接收的消息总数</td>
		</tr>
		<tr>
			<td><b>所有数据点</b></td>
			<td>Up to <b>2K</b> per second, not exceeding <b>25K</b> per minute and capped at <b>1.2M</b> per hour</td>
			<td>Up to <b>10K</b> per second, not exceeding <b>125K</b> per minute and capped at <b>6M</b> per hour</td>
			<td>Up to <b>20K</b> per second, not exceeding <b>600K</b> per minute and capped at <b>30M</b> per hour</td>
			<td>所有设备通过任意传输或集成接收的数据点总数</td>
		</tr>
		<tr>
			<td><b>每设备消息数</b></td>
			<td>Up to <b>200</b> per second, not exceeding <b>6K</b> per minute and capped at <b>20K</b> per hour</td>
			<td>Up to <b>200</b> per second, not exceeding <b>6K</b> per minute and capped at <b>20K</b> per hour</td>
			<td>Up to <b>200</b> per second, not exceeding <b>6K</b> per minute and capped at <b>20K</b> per hour</td>
			<td>单个设备通过任意传输或集成接收的消息总数</td>
		</tr>
		<tr>
			<td><b>每设备数据点数</b></td>
			<td>Up to <b>200</b> per second, not exceeding <b>6K</b> per minute and capped at <b>20K</b> per hour</td>
			<td>Up to <b>200</b> per second, not exceeding <b>6K</b> per minute and capped at <b>20K</b> per hour</td>
			<td>Up to <b>200</b> per second, not exceeding <b>6K</b> per minute and capped at <b>20K</b> per hour</td>
			<td>单个设备通过任意传输或集成接收的数据点总数</td>
		</tr>
		<tr>
			<td><b>所有 REST 请求</b></td>
			<td>Up to <b>100</b> per second, not exceeding <b>2,000</b> per minute </td>
			<td>Up to <b>100</b> per second, not exceeding <b>3,000</b> per minute </td>
			<td>Up to <b>100</b> per second, not exceeding <b>4,000</b> per minute </td>
			<td>任意用户接收的 REST API 调用总数</td>
		</tr>
		<tr>
			<td><b>客户 REST 请求</b></td>
			<td>Up to <b>50</b> per second, not exceeding <b>1,000</b> per minute </td>
			<td>Up to <b>50</b> per second, not exceeding <b>1,000</b> per minute </td>
			<td>Up to <b>50</b> per second, not exceeding <b>1,000</b> per minute </td>
			<td>属于特定客户端的用户接收的 REST API 调用总数</td>
		</tr>
        <tr>
            <td>每会话 WebSocket 更新</td>
            <td>Up to <b>1K</b> per second,<br>not exceeding <b>10K</b> per minute</td>
            <td>Up to <b>1K</b> per second,<br>not exceeding <b>10K</b> per minute</td>
            <td>Up to <b>1K</b> per second,<br>not exceeding <b>10K</b> per minute</td>
            <td>特定 WebSocket 会话接收的消息总数</td>
        </tr>
        <tr>
            <td>WebSocket 会话</td>
            <td>1K</td>
            <td>5K</td>
            <td>10K</td>
            <td>并发 WebSocket 会话最大数量</td>
        </tr>
        <tr>
            <td>WebSocket 订阅</td>
            <td>10K</td>
            <td>50K</td>
            <td>100K</td>
            <td>所有 WebSocket 会话的活跃订阅最大数量</td>
        </tr>
        <tr>
            <td>每客户 WebSocket 会话</td>
            <td>500</td>
            <td>500</td>
            <td>500</td>
            <td>每客户端的活跃 WebSocket 会话最大数量</td>
        </tr>
        <tr>
            <td>每客户 WebSocket 订阅</td>
            <td>5K</td>
            <td>5K</td>
            <td>5K</td>
            <td>每客户端的 WebSocket 订阅最大数量</td>
        </tr>
        <tr>
            <td>每用户 WebSocket 会话</td>
            <td>100</td>
            <td>100</td>
            <td>100</td>
            <td>每用户的 WebSocket 会话最大数量</td>
        </tr>
        <tr>
            <td>每用户 WebSocket 订阅</td>
            <td>1K</td>
            <td>1K</td>
            <td>1K</td>
            <td>每用户的 WebSocket 订阅最大数量</td>
        </tr>
        <tr>
            <td>每会话 WebSocket 队列大小</td>
            <td>500</td>
            <td>500</td>
            <td>500</td>
            <td>每会话传输中消息队列的最大大小</td>
        </tr>
		<tr>
			<td><b>遥测查询</b></td>
			<td>Up to <b>20K</b> per 10 seconds, not exceeding <b>60K</b> per minute </td>
			<td>Up to <b>20K</b> per 10 seconds, not exceeding <b>60K</b> per minute </td>
			<td>Up to <b>20K</b> per 10 seconds, not exceeding <b>60K</b> per minute </td>
            <td>任意用户的 WebSocket 会话或 REST API 调用接收的遥测查询总数</td>
		</tr>
	</tbody>
</table>




